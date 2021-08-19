import 'package:flutter/material.dart';

class ForecastCard extends StatefulWidget {
  final Map data;

  const ForecastCard({Key? key, required this.data}) : super(key: key);

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}


class _ForecastCardState extends State<ForecastCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Card(
        // child: Text(widget.data['name'])
        child: Text(widget.data['name'])
      );
  }
}