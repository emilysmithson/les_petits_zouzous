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
  bool secondArea = true;
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
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                color: Colors.black,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Image.asset('assets/images/title.png')))),
        Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue[100],
          ),
          Positioned(
            bottom: top.value,
            right: right.value,
            child: Transform.scale(
                scale: zoom.value,
                origin: Offset(30, -300),
                child: Image.asset('assets/images/character_with_kite.png')),
          ),


          Positioned(
              top: 20,
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
            top: 0,
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
              ? areaButton(80, 160, 80, 150, 0, 'head', true)
              : Container(),
          firstArea
              ? areaButton(210, 150, 60, 150, 1, 'shoulders', true)
              : Container(),
          firstArea
              ? areaButton(420, 140, 60, 150, 2, 'knees', true)
              : Container(),
          firstArea
              ? areaButton(500, 100, 50, 100, 3, 'toes', true)
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
      ],
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
          secondsSinceStart =
              DateTime.now().difference(startTime).inMilliseconds;
          updateAnswer();
          print(secondsSinceStart);
          print(answer);
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
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.grey[600]),
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
    right = Tween<double>(begin: -300, end: 100).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    top = Tween<double>(begin: 470, end: 470).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    zoom = Tween<double>(begin: 0.7, end: 1.9).animate(
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
    });
//    Timer(Duration(milliseconds: 12219), () {
//      hideFirstAreas();
//    });
//    Timer(Duration(milliseconds: 12220), () {
//      zoomIn();
//    });
//    Timer(Duration(milliseconds: 12500), () {
//      showSecondAreas();
//    });
//    Timer(Duration(milliseconds: 17000), () {
//      zoomOut();
//    });
//    Timer(Duration(milliseconds: 17010), () {
//      showFirstAreas();
//    });
//    Timer(Duration(milliseconds: 27900), () {
//      zoomIn();
//    });
//    Timer(Duration(milliseconds: 27910), () {
//      showSecondAreas();
//    });
//    Timer(Duration(milliseconds: 31800), () {
//      zoomOut();
//    });
//    Timer(Duration(milliseconds: 31810), () {
//      showFirstAreas();
//    });
//
//    Timer(Duration(milliseconds: 40050), () {
//      zoomIn();
//    });
//    Timer(Duration(milliseconds: 40060), () {
//      showSecondAreas();
//    });
//    Timer(Duration(milliseconds: 43300), () {
//      zoomOut();
//    });
//    Timer(Duration(milliseconds: 43400), () {
//      showFirstAreas();
//    });
    Timer(
        Duration(
            milliseconds:
                //45900
                5000), () {
      //   hideFirstAreas();
//      zoom = Tween<double>(begin: 1, end: 0.5).animate(
//          CurvedAnimation(parent: animationController, curve: Interval(0, 1)));
//    //  animationController.forward(from: 0);
//      right = Tween<double>(begin: 0, end: -70).animate(
//          CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
//        ..addListener(() {
//          setState(() {});
//        });
//      top = Tween<double>(begin: 20, end: -250).animate(
//          CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
//        ..addListener(() {
//          setState(() {});
//        });
    });
  }

  @override
  void dispose() {
    player.dispose();
  }

  void updateAnswer() {
// Head
    if (((secondsSinceStart >= 4550) && (secondsSinceStart <= 5650)) ||
        ((secondsSinceStart >= 8810) && (secondsSinceStart <= 9650)) ||
        ((secondsSinceStart >= 17010) && (secondsSinceStart <= 17770)) ||
        ((secondsSinceStart >= 20510) && (secondsSinceStart <= 21550)) ||
        ((secondsSinceStart >= 24360) && (secondsSinceStart <= 25330)) ||
        ((secondsSinceStart >= 31800) && (secondsSinceStart <= 32300)) ||
        ((secondsSinceStart >= 34066) && (secondsSinceStart <= 35220)) ||
        ((secondsSinceStart >= 37560) && (secondsSinceStart <= 38150)) ||
        ((secondsSinceStart >= 43310) && (secondsSinceStart <= 43850))) {
      answer = 'head';
    }
// Shoulders
    else if (((secondsSinceStart >= 5660) && (secondsSinceStart <= 6150)) ||
        ((secondsSinceStart >= 9660) && (secondsSinceStart <= 10350)) ||
        ((secondsSinceStart >= 17780) && (secondsSinceStart <= 18460)) ||
        ((secondsSinceStart >= 21560) && (secondsSinceStart <= 22000)) ||
        ((secondsSinceStart >= 25340) && (secondsSinceStart <= 26050)) ||
        ((secondsSinceStart >= 32310) && (secondsSinceStart <= 32900)) ||
        ((secondsSinceStart >= 35230) && (secondsSinceStart <= 35720)) ||
        ((secondsSinceStart >= 38160) && (secondsSinceStart <= 38550)) ||
        ((secondsSinceStart >= 43860) && (secondsSinceStart <= 44350))) {
      answer = 'shoulders';
    }
// Knees
    else if (((secondsSinceStart >= 6160) && (secondsSinceStart <= 6730)) ||
        ((secondsSinceStart >= 7250) && (secondsSinceStart <= 7750)) ||
        ((secondsSinceStart >= 10360) && (secondsSinceStart <= 10930)) ||
        ((secondsSinceStart >= 11450) && (secondsSinceStart <= 11950)) ||
        ((secondsSinceStart >= 18470) && (secondsSinceStart <= 18910)) ||
        ((secondsSinceStart >= 19360) && (secondsSinceStart <= 19810)) ||
        ((secondsSinceStart >= 22010) && (secondsSinceStart <= 22700)) ||
        ((secondsSinceStart >= 23160) && (secondsSinceStart <= 23640)) ||
        ((secondsSinceStart >= 26060) && (secondsSinceStart <= 26500)) ||
        ((secondsSinceStart >= 26990) && (secondsSinceStart <= 27430)) ||
        ((secondsSinceStart >= 32910) && (secondsSinceStart <= 33250)) ||
        ((secondsSinceStart >= 33610) && (secondsSinceStart <= 33950)) ||
        ((secondsSinceStart >= 35730) && (secondsSinceStart <= 36100)) ||
        ((secondsSinceStart >= 36500) && (secondsSinceStart <= 36820)) ||
        ((secondsSinceStart >= 38560) && (secondsSinceStart <= 38950)) ||
        ((secondsSinceStart >= 39360) && (secondsSinceStart <= 39650)) ||
        ((secondsSinceStart >= 44360) && (secondsSinceStart <= 44700)) ||
        ((secondsSinceStart >= 45060) && (secondsSinceStart <= 45400))) {
      answer = 'knees';
    }

// Toes
    else if (((secondsSinceStart >= 6740) && (secondsSinceStart <= 7240)) ||
        ((secondsSinceStart >= 7760) && (secondsSinceStart <= 8800)) ||
        ((secondsSinceStart >= 10940) && (secondsSinceStart <= 11450)) ||
        ((secondsSinceStart >= 11960) && (secondsSinceStart <= 12220)) ||
        ((secondsSinceStart >= 18920) && (secondsSinceStart <= 19350)) ||
        ((secondsSinceStart >= 19820) && (secondsSinceStart <= 20500)) ||
        ((secondsSinceStart >= 22710) && (secondsSinceStart <= 23150)) ||
        ((secondsSinceStart >= 23650) && (secondsSinceStart <= 24350)) ||
        ((secondsSinceStart >= 26510) && (secondsSinceStart <= 26980)) ||
        ((secondsSinceStart >= 27440) && (secondsSinceStart <= 27900)) ||
        ((secondsSinceStart >= 33260) && (secondsSinceStart <= 33600)) ||
        ((secondsSinceStart >= 33960) && (secondsSinceStart <= 34650)) ||
        ((secondsSinceStart >= 36110) && (secondsSinceStart <= 36490)) ||
        ((secondsSinceStart >= 36830) && (secondsSinceStart <= 37550)) ||
        ((secondsSinceStart >= 38960) && (secondsSinceStart <= 39350)) ||
        ((secondsSinceStart >= 39660) && (secondsSinceStart <= 40050)) ||
        ((secondsSinceStart >= 44710) && (secondsSinceStart <= 45050)) ||
        ((secondsSinceStart >= 45410) && (secondsSinceStart <= 45900))) {
      answer = 'toes';
    }
// Eyes
    else if (((secondsSinceStart >= 12230) && (secondsSinceStart <= 13450)) ||
        ((secondsSinceStart >= 27910) && (secondsSinceStart <= 28900)) ||
        ((secondsSinceStart >= 40060) && (secondsSinceStart <= 40800))) {
      answer = 'eyes';
    }
// Ears
    else if (((secondsSinceStart >= 13460) && (secondsSinceStart <= 14550)) ||
        ((secondsSinceStart >= 28910) && (secondsSinceStart <= 29910)) ||
        ((secondsSinceStart >= 40810) && (secondsSinceStart <= 41450))) {
      answer = 'ears';
    }
// Mouth
    else if (((secondsSinceStart >= 14560) && (secondsSinceStart <= 15800)) ||
        ((secondsSinceStart >= 29900) && (secondsSinceStart <= 30750)) ||
        ((secondsSinceStart >= 41460) && (secondsSinceStart <= 42250))) {
      answer = 'mouth';
    }
// Nose
    else if (((secondsSinceStart >= 15810) && (secondsSinceStart <= 17000)) ||
        ((secondsSinceStart >= 30760) && (secondsSinceStart <= 31800)) ||
        ((secondsSinceStart >= 42260) && (secondsSinceStart <= 43300))) {
      answer = 'nose';
    } else {
      answer = 'none';
    }
  }

  void zoomIn() {
    hideFirstAreas();
    zoom = Tween<double>(begin: 1.9, end: 4).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 0.1)));
    right = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)));
    top = Tween<double>(begin: 20, end: -200).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)));
    animationController.forward(from: 0);
  }

  void zoomOut() {
    hideSecondAreas();
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
