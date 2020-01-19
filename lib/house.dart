import 'package:flutter/material.dart';
import 'window.dart';

class HousePage extends StatefulWidget {
  HousePage();
  @override
  State<StatefulWidget> createState() {
    return _HousePageState();
  }
}

class _HousePageState extends State<HousePage> with TickerProviderStateMixin {
  int round = 0;
  double xCoord = 0.175;
  double yCoord = -1 / 14;
  bool intro = true;
  AnimationController animationController;
  Animation fade;
  Animation zoom;
  bool zoomedOut = false;
  int time = 1;
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
                if (status == AnimationStatus.completed&& round ==1) {
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
                  if (status == AnimationStatus.completed) {
                    if(animationController!=null){
                    animationController.dispose();}
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
      case 2:
        {
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
                  if (status == AnimationStatus.completed) {
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
                  if (status == AnimationStatus.completed) {
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
                              duration: Duration(seconds:time ),
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
              scale: intro ? 1 : zoom.value,
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
