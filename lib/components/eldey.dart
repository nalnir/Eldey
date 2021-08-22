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
  SMIInput<num>? _hoursInput;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/animations/testing_3.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'State Machine');
        if (controller != null) {
          artboard.addController(controller);
          _hoursInput = controller.findInput('Hours');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int time = int.parse(widget.data['ftime'].substring(0,2));
    if(time > 9  && time < 17){
      print('day');
      setState(() {
        _hoursInput?.value = 99.0;
      });
    }
    return Expanded(
      child: Center(
        child: _riveArtboard == null
          ? const SizedBox()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Rive(
                artboard: _riveArtboard!,
              ),
            ),
          )
    );
  }
}