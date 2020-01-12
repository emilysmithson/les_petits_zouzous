import 'package:flutter/material.dart';
import 'moulin.dart';
import 'package:audioplayers/audio_cache.dart';

class HousePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HousePageState();
  }
}

class _HousePageState extends State<HousePage> with TickerProviderStateMixin {
  bool intro = true;
  bool forward = true;
  int round = 0;
  double xCoord;
  double yCoord;

  AnimationController animationController;
  Animation fade;
  Animation zoomIn;
  Animation zoomOut;

  _navigation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoulinPage(round)),
    );
    setState(() {
      intro = false;
      round = result;
      animationController.forward(from: 0);
    });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 6), vsync: this)
          ..addStatusListener((status) {
            print(status);
            if (status == AnimationStatus.completed) {
              _navigation(context);
            }
          });
    fade = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.3),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );
    zoomIn = Tween<double>(
      begin: 1,
      end: 9,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    switch (round) {
      case 0:
        {
          xCoord = 0.175;
          yCoord = -1 / 14;
        }
        break;
      case 1:
        {
          xCoord = -0.165;
          yCoord = -1 / 14;
        }
        break;
      case 2:
        {
          xCoord = 0.205;
          yCoord = 0.25;
        }
        break;

      default:
        {
          xCoord = -0.24;
          yCoord = 0.25;
        }
        break;
    }
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: <Widget>[
          Center(
            child: Transform.scale(
              scale: zoomIn.value,
              origin: Offset(
                -MediaQuery.of(context).size.width * xCoord,
                MediaQuery.of(context).size.height * yCoord,
              ),
              child: Image.asset('assets/images/house2.png'),
            ),
          ),
          Opacity(
            opacity: intro ? fade.value : 0,
            child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
          ),
        ],
      ),
    );
  }
}
