import 'dart:async';
import 'package:flutter/material.dart';

// Components
import './forecast.dart';
import './loading.dart';

// Utils
import '../misc/utils/utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<Map> futureWeather;
  bool fetchNew = false;
  String stationID = '';

  @override
  void initState() {
    super.initState();
  }

  /* Function providing an id of the weather station or an empty string. 
    Empty String is used if client allowed to get the current location of the device.
  */
  refresh(sID) {
    setState(() {
      stationID = sID;
      fetchNew = true;
      Future.delayed(const Duration(milliseconds: 100), () {
        stationID = '';
        fetchNew = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /* Checking for locale. Default is 'en' for english. 
      Since Data can be fetched in 2 languages we inject local into fetchWeather method to specify
      in which language should API return it's data.
    */
    Locale locale = Localizations.localeOf(context);
    return FutureBuilder<Map>(
      future: fetchWeather(fetchNew, locale.toString(), stationID),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
             return Loading(stationPick: false, fetchByStation: refresh);
          case ConnectionState.waiting:
             return Loading(stationPick: false, fetchByStation: refresh);
          case ConnectionState.active:
            return Loading(stationPick: false, fetchByStation: refresh);
          case ConnectionState.done:
            if (snapshot.hasData) {
              String name = snapshot.data!['results'][0]['name'];
              List transformed = transform(snapshot.data!['results'][0]['forecast']);
              return Forecast(name: name, data: transformed, refresh: refresh,);
            } else if (snapshot.hasError) {
              return Loading(stationPick: true, fetchByStation: refresh);
            }
            return Loading(stationPick: false, fetchByStation: refresh);
        }
      },
    );
  }
}