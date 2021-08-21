import 'package:flutter/material.dart';

class ForecastCard extends StatefulWidget {
  final List data;

  const ForecastCard({Key? key, required this.data}) : super(key: key);

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}


class _ForecastCardState extends State<ForecastCard> with TickerProviderStateMixin {
  int navigationIndex = 0;
  late TabController _tabController; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.data.length);
    _tabController.addListener(() {
      print(_tabController.index);
      print(widget.data[_tabController.index]);
      // setState(() {
      //   _selectedIndex = _tabController.index;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Colors.red,
        isScrollable: true,
        labelColor: Colors.red,
        tabs: widget.data.map<Widget>((item) {
          return Tab(
            text: item['ftime'],
          );
        }).toList(),
      )
    );
  }
}