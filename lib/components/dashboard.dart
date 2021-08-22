import 'dart:async';
import 'package:flutter/material.dart';


// Components
import './forecast.dart';

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
      future: fetchWeather(fetchNew, locale),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
             return const CircularProgressIndicator();
          case ConnectionState.waiting:
             return const CircularProgressIndicator();
          case ConnectionState.active:
            return const CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              String name = snapshot.data!['results'][0]['name'];
              List transformed = transform(snapshot.data!['results'][0]['forecast']);
              return Forecast(name: name, data: transformed, refresh: refresh,);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
        }
      },
    );
  }
}