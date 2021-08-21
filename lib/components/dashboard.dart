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

  @override
  void initState() {
    findClosest();
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: futureWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String name = snapshot.data!['results'][0]['name'];
          List transformed = transform(snapshot.data!['results'][0]['forecast']);
          return Forecast(name: name, data: transformed);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Eldey'),
    //   ),
    //   body: Center(
    //     child: FutureBuilder<Map>(
    //         future: futureWeather,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             Map data = snapshot.data!['results'][0];
    //             List transformed = transform(data['forecast']);
    //             return Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 new Text(data['name']),

    //               ],
    //             );
    //           } else if (snapshot.hasError) {
    //             return Text('${snapshot.error}');
    //           }
    //           return const CircularProgressIndicator();
    //         },
    //       ),
    //   ),
    // );
  }
}