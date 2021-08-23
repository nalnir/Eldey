import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// An example showing how to drive two boolean state machine inputs.
class Loading extends StatefulWidget {
  final bool stationPick;
  final Function fetchByStation;
  const Loading({Key? key, required this.stationPick, required this.fetchByStation}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  int selectedIndex = 0;
  Map stationIDS = {0: '1', 1: '422', 2: '2642', 3: '571', 4: '6300'};

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.fetchByStation(stationIDS[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: const Center(
        child: RiveAnimation.asset(
            'assets/animations/testing.riv',
            fit: BoxFit.contain,
        ),
      ),
      bottomNavigationBar: widget.stationPick ? Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [ 
          Text(AppLocalizations.of(context)!.chooseMessage, style: TextStyle( color: Colors.white, fontFamily: 'KleeOne', fontSize: 20)),
          BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
            unselectedItemColor: Colors.green,
            selectedItemColor: Colors.deepOrange,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.brightness_high_outlined),
                label: 'Reykjavík'
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.brightness_high_rounded),
                label: 'Akureyri'
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.brightness_high_sharp ),
                label: 'Ísafjörður'
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.brightness_low),
                label: 'Egilstaðir'
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.brightness_low_outlined),
                label: 'Selfoss'
              ),
            ],
          )
        ]
      ) : Container(),
    );
  }
}