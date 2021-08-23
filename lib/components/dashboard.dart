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

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {
      fetchNew = true;
      Future.delayed(const Duration(milliseconds: 100), () {
        fetchNew = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return FutureBuilder<Map>(
      future: fetchWeather(fetchNew, locale.toString()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
             return Loading(stationPick: true);
          case ConnectionState.waiting:
             return Loading(stationPick: true);
          case ConnectionState.active:
            return Loading(stationPick: true);
          case ConnectionState.done:
            if (snapshot.hasData) {
              String name = snapshot.data!['results'][0]['name'];
              List transformed = transform(snapshot.data!['results'][0]['forecast']);
              return Forecast(name: name, data: transformed, refresh: refresh,);
            } else if (snapshot.hasError) {
              return Loading(stationPick: true);
            }
            return Loading(stationPick: false);
        }
      },
    );
  }
}