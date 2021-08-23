import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive two boolean state machine inputs.
class Eldey extends StatefulWidget {
  final Map data;
  const Eldey({Key? key, required this.data}) : super(key: key);

  @override
  _EldeyState createState() => _EldeyState();
}

class _EldeyState extends State<Eldey> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMITrigger? _isDay;
  SMITrigger? _isNight;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/animations/testing.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'Day Change');
        if (controller != null) {
          artboard.addController(controller);
          _isDay = controller.findInput<bool>('day') as SMITrigger;
          _isNight = controller.findInput<bool>('night') as SMITrigger;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int time = int.parse(widget.data['ftime'].substring(0,2));
    // I have no idea what is || operator in dart. Why do you have to change things google >:(
    if(time < 18  && time > 5){ _isDay?.fire();
    } else if(time < 25  && time > 17 || time >= 0 && time < 18){ _isNight?.fire();}
    
    return _riveArtboard == null
          ? const SizedBox()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Rive(
                artboard: _riveArtboard!,
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
                useArtboardSize: false
              ),
            );
          
  }
}