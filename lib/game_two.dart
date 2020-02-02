import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class GameTwoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameTwoPageState();
  }
}

class GameTwoPageState extends State<GameTwoPage>
    with TickerProviderStateMixin {
  int score = 0;
  bool start = true;
  AudioCache cache = AudioCache();
  AudioPlayer player;
  bool correct = true;
  Color color = Colors.white;
  double transparency = 0;
  static var startTime;
  String answer;
  var secondsSinceStart;
  AnimationController animationController;
  Animation right;
  Animation top;
  Animation zoom;
  bool firstArea = false;
  bool secondArea = false;
  bool intro = true;
  void _playFile() async {
     AudioCache player = AudioCache();
     player.play('music/tete_epaule.mp3');
  }
  var time = 4550;
  var buttonColor = [Colors.white, Colors.white, Colors.white, Colors.white];
  Color color1 = Colors.white;
  Color color2 = Colors.white;
  Color color3 = Colors.white;
  Color color4 = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: Stack(children: <Widget>[
        Positioned(
          bottom: top.value,
          right: right.value,
          child: Transform.scale(
            scale: zoom.value,
            origin: Offset(
              30,
              -300,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Image.asset(
                'assets/images/character.png',
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                color: Colors.black,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Image.asset('assets/images/title.png')))),
        Positioned(
            top: 140,
            right: 20,
            child: Opacity(
              opacity: transparency,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(correct
                      ? 'assets/images/correct.png'
                      : 'assets/images/incorrect.png')),
            )),
        Positioned(
          top: 100,
          left: 20,
          child: Text(score.toString(),
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontFamily: 'CoveredByYourGrace',
                fontSize: 100,
              )),
        ),
        firstArea
            ? areaButton(150, 150, 80, 150, 0, 'head', true)
            : Container(),
        firstArea
            ? areaButton(300, 140, 80, 150, 1, 'shoulders', true)
            : Container(),
        firstArea
            ? areaButton(530, 140, 60, 150, 2, 'knees', true)
            : Container(),
        firstArea
            ? areaButton(630, 100, 50, 100, 3, 'toes', true)
            : Container(),
        secondArea
            ? areaButton(245, 245, 50, 50, 0, 'eyes', true)
            : Container(),
        secondArea
            ? areaButton(310, 330, 80, 80, 1, 'ears', true)
            : Container(),
        secondArea
            ? areaButton(300, 145, 60, 120, 2, 'mouth', true)
            : Container(),
        secondArea
            ? areaButton(240, 180, 60, 60, 3, 'nose', true)
            : Container(),
      ]),
    );
  }

  Widget areaButton(
    double top,
    double left,
    double height,
    double width,
    int colorNumber,
    String buttonName,
    bool firstArea,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          setState(() {
            buttonColor[colorNumber] = Colors.blue;
          });
          secondsSinceStart = DateTime.now().difference(startTime).inSeconds;
          updateAnswer();

          if (buttonName == answer) {
            transparency = 1;
            correct = true;
            score++;
            setState(() {});
          } else {
            transparency = 1;
            correct = false;
            setState(() {});
          }
          Timer(Duration(milliseconds: 300), () {
            setState(() {
              transparency = 0;
            });
          });

          Timer(Duration(milliseconds: 300), () {
            setState(() {
              buttonColor[colorNumber] = Colors.white;
            });
          });
        },
        child: Opacity(
          opacity: 0.5,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(border: Border.all(width: 0.2, color: Colors.grey[600]) ,
                borderRadius: BorderRadius.circular(20),
                color: buttonColor[colorNumber]),

          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    startTime = DateTime.now();
   _playFile();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4550),
    );
    right = Tween<double>(begin: -300, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    top = Tween<double>(begin: 150, end: 20).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    zoom = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && intro == true) {
          intro = false;
        }
      });

    animationController.forward();
    Timer(Duration(milliseconds: 4550), () {
      showFirstAreas();
      print('show firstAreas 1');
    });
    Timer(Duration(milliseconds: 12219), () {
      hideFirstAreas();
      print('hide first areas 1');
    });
    Timer(Duration(milliseconds: 12220), () {
      print('zoom in 1');
      zoomIn();

    });
    Timer(Duration(milliseconds: 12500), () {
      showSecondAreas();
      print('show second areas 1');
    });
    Timer(Duration(milliseconds: 17000), () {
      hideSecondAreas();
      print('hide second area 1');
      zoomOut();
      print('zoom out 1');
    });
    Timer(Duration(milliseconds: 17010), () {
      showFirstAreas();
      print('show firstAreas 2');
    });
    Timer(Duration(milliseconds: 27900), () {
      hideFirstAreas();
      print('hide first areas 2');
      print('zoom in 2');
      zoomIn();
    });
    Timer(Duration(milliseconds: 27910), () {
      showSecondAreas();
      print('show second areas 2');
    });
    Timer(Duration(milliseconds: 31800), () {
      hideSecondAreas();
      zoomOut();
      print('zoom out 2');
    });
    Timer(Duration(milliseconds: 31810), () {
      showFirstAreas();
      print('show firstAreas 3');
    });

    Timer(Duration(milliseconds: 40050), () {
      hideFirstAreas();
      zoomIn();
      print('zoom in 3');
    });
    Timer(Duration(milliseconds: 40060), () {
      showSecondAreas();
      print('show second areas 3');
    });
    Timer(Duration(milliseconds: 43300), () {
      hideSecondAreas();
      zoomOut();
      print('zoom out 3');
    });
    Timer(Duration(milliseconds: 43400), () {
      showFirstAreas();
      print('show firstAreas 4');
    });
  }

  @override
  void dispose() {
    player.dispose();
  }

  void updateAnswer() {
// Head
    if (((secondsSinceStart >= 4.55) && (secondsSinceStart <= 5.65)) ||
        ((secondsSinceStart >= 8.81) && (secondsSinceStart <= 9.65)) ||
        ((secondsSinceStart >= 17.01) && (secondsSinceStart <= 17.77)) ||
        ((secondsSinceStart >= 20.51) && (secondsSinceStart <= 21.55)) ||
        ((secondsSinceStart >= 24.36) && (secondsSinceStart <= 25.33)) ||
        ((secondsSinceStart >= 31.80) && (secondsSinceStart <= 32.30)) ||
        ((secondsSinceStart >= 34.66) && (secondsSinceStart <= 35.22)) ||
        ((secondsSinceStart >= 37.56) && (secondsSinceStart <= 38.15)) ||
        ((secondsSinceStart >= 43.31) && (secondsSinceStart <= 43.85))) {
      answer = 'head';
    }
// Shoulders
    else if (((secondsSinceStart >= 5.66) && (secondsSinceStart <= 6.15)) ||
        ((secondsSinceStart >= 9.66) && (secondsSinceStart <= 10.35)) ||
        ((secondsSinceStart >= 17.78) && (secondsSinceStart <= 18.46)) ||
        ((secondsSinceStart >= 21.56) && (secondsSinceStart <= 22.00)) ||
        ((secondsSinceStart >= 25.34) && (secondsSinceStart <= 26.05)) ||
        ((secondsSinceStart >= 32.31) && (secondsSinceStart <= 32.90)) ||
        ((secondsSinceStart >= 35.23) && (secondsSinceStart <= 35.72)) ||
        ((secondsSinceStart >= 38.16) && (secondsSinceStart <= 38.55)) ||
        ((secondsSinceStart >= 43.86) && (secondsSinceStart <= 44.35))) {
      answer = 'shoulders';
    }
// Knees
    else if (((secondsSinceStart >= 6.16) && (secondsSinceStart <= 6.73)) ||
        ((secondsSinceStart >= 7.25) && (secondsSinceStart <= 7.75)) ||
        ((secondsSinceStart >= 10.36) && (secondsSinceStart <= 10.93)) ||
        ((secondsSinceStart >= 11.45) && (secondsSinceStart <= 11.95)) ||
        ((secondsSinceStart >= 18.47) && (secondsSinceStart <= 18.91)) ||
        ((secondsSinceStart >= 19.36) && (secondsSinceStart <= 19.81)) ||
        ((secondsSinceStart >= 22.01) && (secondsSinceStart <= 22.70)) ||
        ((secondsSinceStart >= 23.16) && (secondsSinceStart <= 23.64)) ||
        ((secondsSinceStart >= 26.06) && (secondsSinceStart <= 26.50)) ||
        ((secondsSinceStart >= 26.99) && (secondsSinceStart <= 27.43)) ||
        ((secondsSinceStart >= 32.91) && (secondsSinceStart <= 33.25)) ||
        ((secondsSinceStart >= 33.61) && (secondsSinceStart <= 33.95)) ||
        ((secondsSinceStart >= 35.73) && (secondsSinceStart <= 36.10)) ||
        ((secondsSinceStart >= 36.50) && (secondsSinceStart <= 36.82)) ||
        ((secondsSinceStart >= 38.56) && (secondsSinceStart <= 38.95)) ||
        ((secondsSinceStart >= 39.36) && (secondsSinceStart <= 39.65)) ||
        ((secondsSinceStart >= 44.36) && (secondsSinceStart <= 44.70)) ||
        ((secondsSinceStart >= 45.06) && (secondsSinceStart <= 45.40))) {
      answer = 'knees';
    }



// Toes
    else if (((secondsSinceStart >= 6.74) && (secondsSinceStart <= 7.24)) ||
        ((secondsSinceStart >= 7.76) && (secondsSinceStart <= 8.80)) ||
        ((secondsSinceStart >= 10.94) && (secondsSinceStart <= 11.45)) ||
        ((secondsSinceStart >= 11.96) && (secondsSinceStart <= 12.22)) ||
        ((secondsSinceStart >= 18.92) && (secondsSinceStart <= 19.35)) ||
        ((secondsSinceStart >= 19.82) && (secondsSinceStart <= 20.50)) ||
        ((secondsSinceStart >= 22.71) && (secondsSinceStart <= 23.15)) ||
        ((secondsSinceStart >= 23.65) && (secondsSinceStart <= 24.35)) ||
        ((secondsSinceStart >= 26.51) && (secondsSinceStart <= 26.98)) ||
        ((secondsSinceStart >= 27.44) && (secondsSinceStart <= 27.90)) ||
        ((secondsSinceStart >= 33.26) && (secondsSinceStart <= 33.60)) ||
        ((secondsSinceStart >= 33.96) && (secondsSinceStart <= 34.65)) ||
        ((secondsSinceStart >= 36.11) && (secondsSinceStart <= 36.49)) ||
        ((secondsSinceStart >= 36.83) && (secondsSinceStart <= 37.55)) ||
        ((secondsSinceStart >= 38.96) && (secondsSinceStart <= 39.35)) ||
        ((secondsSinceStart >= 39.66) && (secondsSinceStart <= 40.05)) ||
        ((secondsSinceStart >= 44.71) && (secondsSinceStart <= 45.05)) ||
        ((secondsSinceStart >= 45.41) && (secondsSinceStart <= 45.90))) {
      answer = 'toes';
    }
// Eyes
    else if (((secondsSinceStart >= 12.23) && (secondsSinceStart <= 13.45)) ||
        ((secondsSinceStart >= 27.91) && (secondsSinceStart <= 28.90)) ||
        ((secondsSinceStart >= 40.06) && (secondsSinceStart <= 40.80))) {
      answer = 'eyes';
    }
// Ears
    else if (((secondsSinceStart >= 13.46) && (secondsSinceStart <= 14.55)) ||
        ((secondsSinceStart >= 28.91) && (secondsSinceStart <= 29.91)) ||
        ((secondsSinceStart >= 40.81) && (secondsSinceStart <= 41.45))) {
      answer = 'ears';
    }
// Mouth
    else if (((secondsSinceStart >= 14.56) && (secondsSinceStart <= 15.80)) ||
        ((secondsSinceStart >= 29.90) && (secondsSinceStart <= 30.75)) ||
        ((secondsSinceStart >= 41.46) && (secondsSinceStart <= 42.25))) {
      answer = 'mouth';
    }
// Nose
    else if (((secondsSinceStart >= 15.81) && (secondsSinceStart <= 17.00)) ||
        ((secondsSinceStart >= 30.76) && (secondsSinceStart <= 31.80)) ||
        ((secondsSinceStart >= 42.26) && (secondsSinceStart <= 43.30))) {
      answer = 'nose';
    } else {
      answer = 'none';
    }
  }

  void zoomIn() {
    zoom = Tween<double>(begin: 1, end: 2).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 0.1)));
    right = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)));
    top = Tween<double>(begin: 20, end: 20).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)));
    animationController.forward(from: 0);
  }

  void zoomOut() {
    animationController.reverse(from: 0.1);
  }

  void showFirstAreas() {
    setState(() {
      firstArea = true;
    });
  }

  void hideFirstAreas() {
    setState(() {
      firstArea = false;
    });
  }

  void showSecondAreas() {
    setState(() {
      secondArea = true;
    });
  }

  void hideSecondAreas() {
    setState(() {
      secondArea = false;
    });
  }
}
