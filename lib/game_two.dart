import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class GameTwoPage extends StatefulWidget {
  final Function() returnToNavigation;
  AudioPlayer player;
  GameTwoPage({this.returnToNavigation, this.player});
  @override
  State<StatefulWidget> createState() {
    return GameTwoPageState();
  }
}

class GameTwoPageState extends State<GameTwoPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int score = 0;
  bool correct = true;
  double transparency = 0;
  static var startTime;
  String answer;
  var secondsSinceStart;
  AnimationController _animationController;
  Animation right;
  Animation bottom;
  Animation zoom;
  Animation finale;
  bool firstArea = false;
  bool secondArea = false;
  bool intro = true;
  bool outOf = false;
  bool showMessage = false;
  var buttonColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  bool clickToReturn = false;
  bool initialAnimation = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 1.3;
    double scale0 = 1.3;
    double bottom0 = height * 2;
    double right0 = -width * 1.5;
    double scale1 = 1.7;
    double bottom1 = height / 2;
    double right1 = width / 2;
    double scale2 = 3.2;
    double bottom2 = height * 0.1;
    double right2 = width * 0.37;
    double scale3 = 0.9;
    double bottom3 = height * 0.2;
    double right3 = width * 0.2;

    if (initialAnimation) {
      right = Tween<double>(begin: right0, end: right1).animate(
          CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
        ..addListener(() {
          setState(() {});
        });
      bottom = Tween<double>(begin: bottom0, end: bottom1).animate(
          CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
        ..addListener(() {
          setState(() {});
        });
      zoom = Tween<double>(begin: scale0, end: scale1).animate(
          CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
        ..addListener(() {
          setState(() {});
        });
      finale = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(0.7, 1)));
    }

    return WillPopScope(
      onWillPop: () {
        widget.player?.stop();
        navigateBack();
        return null;
      },
      child: GestureDetector(
        onTap: () {
          clickToReturn ? navigateBack() : null;
        },
        child: Container(
          height: height,
          width: width,
          color: Colors.lightBlue[100],
          child: ClipRect(
            child: Stack(children: <Widget>[
              Transform.scale(
                  scale: zoom.value,
                  origin: Offset(right.value, bottom.value),
                  child: Image.asset('assets/images/character_with_kite.png')),
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
                left: 30,
                child: Text(score.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CoveredByYourGrace',
                      fontSize: 60,
                    )),
              ),
              outOf
                  ? Positioned(
                      top: 20,
                      left: score < 10 ? 50 : 80,
                      child: Opacity(
                        opacity: finale.value,
                        child: Text('/66',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CoveredByYourGrace',
                              fontSize: 60,
                            )),
                      ),
                    )
                  : Container(),
              showMessage
                  ? Positioned(
                      top: 200,
                      left: 20,
                      child: Opacity(
                        opacity: finale.value,
                        child: Text(
                            score < 20
                                ? 'Rejoue!'
                                : score < 35
                                    ? 'Pas Mal!'
                                    : score < 45
                                        ? 'Bien!'
                                        : score < 66 ? 'Bravo!' : 'Parfait!',
                            style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CoveredByYourGrace',
                              fontSize: 70,
                            )),
                      ),
                    )
                  : Container(),
              firstArea
                  ? areaButton(height * 0.1, width * 0.4, height * 0.12,
                      width * 0.35, 0, 'head', true)
                  : Container(),
              firstArea
                  ? areaButton(height * 0.36, width * 0.38, height * 0.12,
                      width * 0.35, 1, 'shoulders', true)
                  : Container(),
              firstArea
                  ? areaButton(height * 0.75, width * 0.36, height * 0.12,
                      width * 0.35, 2, 'knees', true)
                  : Container(),
              firstArea
                  ? areaButton(height * 0.88, width * 0.27, height * 0.11,
                      width * 0.35, 3, 'toes', true)
                  : Container(),
              secondArea
                  ? areaButton(height * 0.23, width * 0.57, height * 0.1,
                      width * 0.15, 0, 'eyes', true)
                  : Container(),
              secondArea
                  ? areaButton(height * 0.34, width * 0.78, height * 0.15,
                      width * 0.2, 1, 'ears', true)
                  : Container(),
              secondArea
                  ? areaButton(height * 0.35, width * 0.35, height * 0.1,
                      width * 0.3, 2, 'mouth', true)
                  : Container(),
              secondArea
                  ? areaButton(height * 0.23, width * 0.44, height * 0.1,
                      width * 0.13, 3, 'nose', true)
                  : Container(),
            ]),
          ),
        ),
      ),
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
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.grey[600]),
                borderRadius: BorderRadius.circular(20),
                color:
                    //Colors.blue),
                    buttonColor[colorNumber]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    startTime = DateTime.now();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4550),
    );

    _animationController.forward();
    Timer(Duration(milliseconds: 4550), () {
      initialAnimation = false;
      showFirstAreas();
    });
    Timer(Duration(milliseconds: 12219), () {
      hideFirstAreas();
    });
    Timer(Duration(milliseconds: 12220), () {
      zoomIn();
    });
    Timer(Duration(milliseconds: 12500), () {
      showSecondAreas();
    });
    Timer(Duration(milliseconds: 17000), () {
      zoomOut();
    });
    Timer(Duration(milliseconds: 17010), () {
      showFirstAreas();
    });
    Timer(Duration(milliseconds: 27900), () {
      zoomIn();
    });
    Timer(Duration(milliseconds: 27910), () {
      showSecondAreas();
    });
    Timer(Duration(milliseconds: 31800), () {
      zoomOut();
    });
    Timer(Duration(milliseconds: 31810), () {
      showFirstAreas();
    });

    Timer(Duration(milliseconds: 40050), () {
      zoomIn();
    });
    Timer(Duration(milliseconds: 40060), () {
      showSecondAreas();
    });
    Timer(Duration(milliseconds: 43300), () {
      zoomOut();
    });
    Timer(Duration(milliseconds: 43400), () {
      showFirstAreas();
    });
    Timer(
        Duration(milliseconds: 45900
            //     5000
            ), () {
      showResults();
    });
  }

  void updateAnswer() {
    secondsSinceStart = DateTime.now().difference(startTime).inMilliseconds;
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
    double width = MediaQuery.of(context).size.width;
    double height = width * 1.3;
    double scale0 = 1;
    double bottom0 = height;
    double right0 = width;
    double scale1 = 1.7;
    double bottom1 = height / 2;
    double right1 = width / 2;
    double scale2 = 3.2;
    double bottom2 = height * 0.1;
    double right2 = width * 0.37;
    double scale3 = 0.9;
    double bottom3 = height * 0.2;
    double right3 = width * 0.2;
    hideFirstAreas();
    zoom = Tween<double>(begin: scale1, end: scale2).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.1)));
    _animationController.forward(from: 0);
    right = Tween<double>(begin: right1, end: right2).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.1)))
      ..addListener(() {
        setState(() {});
      });
    bottom = Tween<double>(begin: bottom1, end: bottom2).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.1)))
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward(from: 0);
  }

  void zoomOut() {
    hideSecondAreas();
    _animationController.reverse(from: 0.1);
  }

  void showFirstAreas() {
    mounted
        ? setState(() {
            firstArea = true;
          })
        : null;
  }

  void hideFirstAreas() {
    mounted
        ? setState(() {
            firstArea = false;
          })
        : null;
  }

  void showSecondAreas() {
    mounted
        ? setState(() {
            secondArea = true;
          })
        : null;
  }

  void hideSecondAreas() {
    mounted
        ? setState(() {
            secondArea = false;
          })
        : null;
  }

  void showResults() {
    double width = MediaQuery.of(context).size.width;
    double height = width * 1.3;
    double scale0 = 1;
    double bottom0 = height;
    double right0 = width;
    double scale1 = 1.7;
    double bottom1 = height / 2;
    double right1 = width / 2;
    double scale2 = 3.2;
    double bottom2 = height * 0.1;
    double right2 = width * 0.37;
    double scale3 = 0.9;
    double bottom3 = height * 0.2;
    double right3 = width * 0.2;
    hideFirstAreas();
    zoom = Tween<double>(begin: scale1, end: scale3).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 1)));

    right = Tween<double>(begin: right1, end: right3).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    bottom = Tween<double>(begin: bottom1, end: bottom3).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          clickToReturn = true;
          setState(() {});
        }
      });
    outOf = true;
    showMessage = true;
    _animationController.forward(from: 0);
  }

  navigateBack() async {
    widget.returnToNavigation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.inactive) {
      navigateBack();
      _animationController?.stop();
      _animationController?.dispose();
    }
  }

  @override
  void dispose() {

    _animationController.dispose();
    super.dispose();
  }
}
