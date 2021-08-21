import 'package:flutter/material.dart';

class Forecast extends StatefulWidget {
  final String name;
  final List data;

  const Forecast({Key? key, required this.name, required this.data}) : super(key: key);

  @override
  State<Forecast> createState() => _ForecastState();
}


class _ForecastState extends State<Forecast> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: Text('Testing')
      ),
    );
      
  }
}