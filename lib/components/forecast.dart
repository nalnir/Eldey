import 'package:flutter/material.dart';

// Components
import './forecastCard.dart';

class Forecast extends StatefulWidget {
  final String name;
  final List data;
  final Function refresh;

  const Forecast({Key? key, required this.name, required this.data, required this.refresh}) : super(key: key);

  @override
  State<Forecast> createState() => _ForecastState();
}


class _ForecastState extends State<Forecast> with TickerProviderStateMixin {
  int navigationIndex = 0;
  late TabController _tabController; 
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.data.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eldey got data from '+widget.name+' station',
          style: const TextStyle(fontSize: 13)
        ),
        actions: [
          IconButton(
            onPressed: () async { widget.refresh(); },
            icon: const Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.data.map<Widget>((view) {
          return ForecastCard(data: view['time']);
        }).toList(),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Colors.blue,
        isScrollable: true,
        labelColor: Colors.blue,
        tabs: widget.data.map<Widget>((item) {
          return Tab(
            text: item['date'],
          );
        }).toList(),
      ),
    );
  }
}