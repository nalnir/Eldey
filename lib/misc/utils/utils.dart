// Packages
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';


// Async functions
Future<String> findClosest() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String jsonData = await rootBundle.loadString('assets/data/stationsList.json');
    final jsonResult = json.decode(jsonData);
    var stationsList = jsonResult["list"] as List;

    double distanceInMeters = 0.0 ;
    String id = '1';
    for (int i = 0; i < stationsList.length; i++) {
      if(i == 0){ distanceInMeters = calculateDistance(position.latitude, position.longitude, stationsList[i]['lat'], -stationsList[i]['long']); }
      double compare = calculateDistance(position.latitude, position.longitude, stationsList[i]['lat'], -stationsList[i]['long']);
      if(compare.compareTo(distanceInMeters) < 0){
        distanceInMeters = compare;
        id = stationsList[i]['id'];
      }
    }
    return id;
}

Future<Map> fetchWeather(shouldFetchNew, locale, stationID) async {
  if(shouldFetchNew){
    return await fetchFromApi(locale, stationID);
  } else {
    String cache = await getData();
    if(cache == 'error'){
      return await fetchFromApi(locale, stationID);
    } else {
      return json.decode(cache);
    }
  }
}

Future <Map> fetchFromApi(locale, String sID) async {
  String stationID = sID;
  if(stationID == ''){
    stationID = await findClosest();
  } 
  final response = await http.get(Uri.parse('https://apis.is/weather/forecasts/'+locale+'?stations='+stationID));
  if (response.statusCode == 200) {
    await setData(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/vedur-data.txt');
  }

  Future<String> getData() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();   
      bool result = timeCheck(contents);

      if(result){
        return contents;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<File> setData(data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

// Supporting functions
double calculateDistance(lat,long,lat2,long2) {
  return Geolocator.distanceBetween(lat, long, lat2, long2);
}

List transform(list) {
  List dates = [];
  List listOfObj = [];
  for (int i = 0; i < list.length; i++) {
    dates.add(list[i]['ftime'].split(' ')[0]);
  }
  List unique = dates.toSet().toList();
  for(int i = 0; i < unique.length; i++) {
    Map obj = {};
    obj['date'] = unique[i];
    obj['time'] = [];
    listOfObj.add(obj);
  };
  for(int i = 0; i < listOfObj.length; i++) {
    for(int j = 0; j < list.length; j++){
      if(list[j]['ftime'].split(' ')[0] == listOfObj[i]['date']) {
        list[j]['ftime'] = list[j]['ftime'].split(' ')[1];
        listOfObj[i]['time'].add(list[j]);
      }
    }
  }
  return listOfObj;
}

bool timeCheck(data){
  String dateOld = json.decode(data)['results'][0]['atime'];
  int hourCached = int.parse(dateOld.toString().substring(10, 13));
  String dateCached = dateOld.toString().substring(0,10);

  DateTime dateToday = DateTime.now(); 
  int hour = int.parse(dateToday.toString().substring(10, 13));
  String date = dateToday.toString().substring(0,10);

  if(date == dateCached){
    int hourDiscrepancy = hour - hourCached;
    if(hourDiscrepancy > 10) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
}