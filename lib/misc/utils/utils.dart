// Packages
import 'package:flutter/services.dart' show rootBundle;

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

Future<Map> fetchWeather() async {
    String stationID = await findClosest();
    final response = await http.get(Uri.parse('https://apis.is/weather/forecasts/en?stations='+stationID));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
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