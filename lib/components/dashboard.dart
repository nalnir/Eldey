import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// Components
import './forecastCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class Weather {
  final Iterable data;
  
  Weather({
    required this.data,
  });

  factory Weather.fromJson(Iterable<dynamic> json) {
    return Weather(
      data: json,
    );
  }
}

class _DashboardState extends State<Dashboard> {
  late Future<Map> futureWeather;

  Future<Map> fetchWeather() async {
    final response = await http.get(Uri.parse('https://apis.is/weather/forecasts/en?stations=1'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eldey'),
      ),
      body: Center(
        child: FutureBuilder<Map>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: ForecastCard(data: snapshot.data!['results'][0])
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
      ),
    );
  }
}

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState) {
//         int counter = Store.of(context).counter;
//       },
//     );
//   }
// }