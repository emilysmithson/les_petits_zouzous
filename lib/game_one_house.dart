import 'package:flutter/material.dart';
import 'game_one_window.dart';

class GameOnePage extends StatefulWidget {
  GameOnePage();
  @override
  State<StatefulWidget> createState() {
    return _GameOnePageState();
  }
}

class _GameOnePageState extends State<GameOnePage>
    with TickerProviderStateMixin {
  int round = 0;
  double xCoord = 0.175;
  double yCoord = -1 / 14;
  bool intro = true;
  AnimationController animationController;
  Animation fade;
  Animation zoom;
  bool zoomedOut = false;
  int time = 4;
  bool zoomedIn = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (round) {
      case 0:
        {
          time = 4;
          fade = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
              parent: animationController, curve: Interval(0, 1)))
            ..addListener(() {
              setState(() {});
            })
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed && intro) {
                intro = false;
                zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                    parent: animationController, curve: Interval(0, 1)))
                  ..addListener(() {
                    setState(() {});
                  })
                  ..addStatusListener(
                    (status) {
                      if (status == AnimationStatus.completed && round == 0) {
                        animationController.stop();
                        animationController.dispose();
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WindowPage(round)))
                            .whenComplete(
                          () {
                            setState(
                              () {
                                round++;
                                zoomedOut = false;

                                animationController = AnimationController(
                                  vsync: this,
                                  duration: Duration(seconds: 2),
                                );
                                animationController.forward(from: 0);
                              },
                            );
                          },
                        );
                        zoom.removeStatusListener((status) {});
                        fade.removeStatusListener((status) {});
                        animationController.removeStatusListener((status) {});
                      }
                    },
                  );

                animationController.forward(from: 0);
              }
            });
        }
        break;
      case 1:
        {
          time = 2;
          if (!zoomedOut) {
            zoom = Tween<double>(begin: 9, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed && round == 1) {
                  animationController.stop();
                  animationController.dispose();
                  zoomedOut = true;
                  animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = -0.165;
                  yCoord = -1 / 14;
                  animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    zoomedIn = true;
                    animationController.stop();

                    animationController.dispose();
                    zoomedOut = false;

                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WindowPage(round)))
                        .whenComplete(
                      () {
                        setState(
                          () {
                            round++;
                            zoomedIn = false;

                            animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            animationController.forward(from: 0);
                          },
                        );
                      },
                    );
                  }
                },
              );
          }
        }
        break;
      case 2:
        {
          time = 2;
          if (!zoomedOut) {
            zoom = Tween<double>(begin: 9, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  animationController.dispose();
                  zoomedOut = true;
                  animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = 0.205;
                  yCoord = 0.25;
                  animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    animationController.stop();
                    zoomedIn = true;
                    zoomedOut = false;
                    animationController.dispose();
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WindowPage(round)))
                        .whenComplete(
                      () {
                        setState(
                          () {
                            round++;

                            zoomedIn = false;
                            animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            animationController.forward(from: 0);
                          },
                        );
                      },
                    );
                    zoom.removeStatusListener((status) {});
                    fade.removeStatusListener((status) {});
                    animationController.removeStatusListener((status) {});
                  }
                },
              );
          }
        }
        break;
      case 3:
        {
          time = 2;
          if (!zoomedOut) {
            zoom = Tween<double>(begin: 9, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  animationController.dispose();
                  zoomedOut = true;
                  animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = -0.24;
                  yCoord = 0.25;
                  animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    animationController.stop();
                    zoomedOut = false;
                    zoomedIn = true;
                    animationController.dispose();
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WindowPage(round)))
                        .whenComplete(
                      () {
                        setState(
                          () {
                            round++;

                            zoomedIn = false;
                            animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            animationController.forward(from: 0);
                          },
                        );
                      },
                    );
                    zoom.removeStatusListener((status) {});
                    fade.removeStatusListener((status) {});
                    animationController.removeStatusListener((status) {});
                  }
                },
              );
          }
        }
        break;
    }

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: <Widget>[
          Center(
            child: Transform.scale(
              scale: intro ? 1 : zoomedIn ? 9 : zoom.value,
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
