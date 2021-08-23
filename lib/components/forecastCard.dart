import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './eldey.dart';

class ForecastCard extends StatefulWidget {
  final List data;
  final Function setIndex;
  final int timeIndex;

  const ForecastCard({Key? key, required this.data, required this.setIndex, required this.timeIndex}) : super(key: key);

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}


class _ForecastCardState extends State<ForecastCard> with TickerProviderStateMixin {
  late TabController _tabController; 
  late Map dataForEldey;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.data.length);
    dataForEldey = widget.data[_tabController.index];
    if(widget.timeIndex >=  widget.data.length){
      _tabController.index = 0;
    } else {
      _tabController.index = widget.timeIndex;
    }
    _tabController.addListener(() {
      setState(() {
        dataForEldey = widget.data[_tabController.index];
      });
      widget.setIndex(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(dataForEldey);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wb_sunny_outlined),
                Text(AppLocalizations.of(context)!.t + dataForEldey['T'], style: const TextStyle(fontFamily: 'KleeOne'),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.air),
                Text(AppLocalizations.of(context)!.f + dataForEldey['F'], style: const TextStyle(fontFamily: 'KleeOne')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.north_east),
                Text(AppLocalizations.of(context)!.d + dataForEldey['D'], style: const TextStyle(fontFamily: 'KleeOne')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description),
                Text(AppLocalizations.of(context)!.w + dataForEldey['W'], style: const TextStyle(fontFamily: 'KleeOne')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Colors.red,
        isScrollable: true,
        labelColor: Colors.red,
        tabs: widget.data.map<Widget>((item) {
          return Tab(
            text: item['ftime'].substring(0, 5),
          );
        }).toList(),
      )
    );
  }
}