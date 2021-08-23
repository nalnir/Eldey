import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Components
import './forecastCard.dart';
import './eldey.dart';

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
  int timeIndex = 0;
  late Map dataForEldey;

  bool playGroundMode = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.data.length);
    dataForEldey = widget.data[_tabController.index]['time'][timeIndex];
    _tabController.addListener(() {
      if(timeIndex >= widget.data[_tabController.index]['time'].length){
        setState(() {
          dataForEldey = widget.data[_tabController.index]['time'][0];
        });
      } else {
        setState(() {
          dataForEldey = widget.data[_tabController.index]['time'][timeIndex];
        });
      }
    });
  }

  // Specifing index of the chaild TabBar.
  setIndex(data) {
    setState(() {
      timeIndex = data;
      dataForEldey = widget.data[_tabController.index]['time'][timeIndex];
    });
  }

  // Playground Function to substract from the currently viewed temperature
  takeTemp(index) {
    Map modified = widget.data[_tabController.index]['time'][index];
    modified['T'] = (int.parse(modified['T']) - 1).toString();
    setState(() {
      dataForEldey = widget.data[_tabController.index]['time'][timeIndex];
    });
  }

  // Playground Function to add to the currently viewed temperature
  addTemp(index) {
    Map modified = widget.data[_tabController.index]['time'][index];
    modified['T'] = (int.parse(modified['T']) + 1).toString();
    setState(() {
      dataForEldey = widget.data[_tabController.index]['time'][timeIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          AppLocalizations.of(context)!.navbartext + widget.name + AppLocalizations.of(context)!.navbartextend,
          style: const TextStyle(fontSize: 12, fontFamily: 'KleeOne'), 
        ),
        actions: [
          IconButton(
            onPressed: () async { widget.refresh(''); },
            icon: const Icon(Icons.refresh),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Eldey(data: dataForEldey) 
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.data.map<Widget>((view) {
                return ForecastCard(data: view['time'], setIndex: setIndex, timeIndex: timeIndex, takeTemp: takeTemp, addTemp: addTemp);
              }).toList(),
            ),
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.orangeAccent,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          isScrollable: true,
          tabs: widget.data.map<Widget>((item) {
            return Tab(
              text: item['date'],
            );
          }).toList(),
        ),
      )
    );
  }
}