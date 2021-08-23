import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';


/// An example showing how to drive two boolean state machine inputs.
class Loading extends StatefulWidget {
  final bool stationPick;
  const Loading({Key? key, required this.stationPick}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const RiveAnimation.asset(
            'assets/animations/testing.riv',
            fit: BoxFit.contain,
        ),
      ),
      bottomNavigationBar: widget.stationPick ? BottomNavigationBar(
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
            label: 'Vík'
          ),
        ],
      ) : Container(),
    );
  }
}