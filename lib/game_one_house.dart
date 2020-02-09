import 'package:flutter/material.dart';
import 'game_one_window.dart';
import 'navigation_page.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GameOnePage extends StatefulWidget {
  AudioPlayer player = AudioPlayer();
  GameOnePage(this.player);
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
  AnimationController _animationController;
  Animation fade;
  Animation zoom;
  bool zoomedOut = false;
  int time = 4;
  bool zoomedIn = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (round) {
      case 0:
        {
          time = 4;
          fade = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
              parent: _animationController, curve: Interval(0, 1)))
            ..addListener(() {
              setState(() {});
            })
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed && intro) {
                intro = false;
                zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                    parent: _animationController, curve: Interval(0, 1)))
                  ..addListener(() {
                    setState(() {});
                  })
                  ..addStatusListener(
                    (status) {
                      if (status == AnimationStatus.completed && round == 0) {
                        _animationController.stop();
                        _animationController.dispose();
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

                                _animationController = AnimationController(
                                  vsync: this,
                                  duration: Duration(seconds: 2),
                                );
                                _animationController.forward(from: 0);
                              },
                            );
                          },
                        );
                        zoom.removeStatusListener((status) {});
                        fade.removeStatusListener((status) {});
                        _animationController.removeStatusListener((status) {});
                      }
                    },
                  );

                _animationController.forward(from: 0);
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
                parent: _animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed && round == 1) {
                  _animationController.stop();
                  _animationController.dispose();
                  zoomedOut = true;
                  _animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = -0.165;
                  yCoord = -1 / 14;
                  _animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: _animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    zoomedIn = true;
                    _animationController.stop();

                    _animationController.dispose();
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

                            _animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            _animationController.forward(from: 0);
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
                parent: _animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _animationController.dispose();
                  zoomedOut = true;
                  _animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = 0.205;
                  yCoord = 0.25;
                  _animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: _animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    _animationController.stop();
                    zoomedIn = true;
                    zoomedOut = false;
                    _animationController.dispose();
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
                            _animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            _animationController.forward(from: 0);
                          },
                        );
                      },
                    );
                    zoom.removeStatusListener((status) {});
                    fade.removeStatusListener((status) {});
                    _animationController.removeStatusListener((status) {});
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
                parent: _animationController,
                curve: Interval(0.0, 1.0),
              ),
            )
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _animationController.dispose();
                  zoomedOut = true;
                  _animationController = AnimationController(
                    vsync: this,
                    duration: Duration(seconds: time),
                  );
                  xCoord = -0.24;
                  yCoord = 0.25;
                  _animationController.forward(from: 0);
                }
              });
          } else {
            zoom = Tween<double>(begin: 1, end: 9).animate(CurvedAnimation(
                parent: _animationController, curve: Interval(0.0, 1.0)))
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener(
                (status) {
                  if (status == AnimationStatus.completed && zoomedOut) {
                    _animationController.stop();
                    zoomedOut = false;
                    zoomedIn = true;
                    _animationController.dispose();
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
                            _animationController = AnimationController(
                              vsync: this,
                              duration: Duration(seconds: time),
                            );
                            _animationController.forward(from: 0);
                          },
                        );
                      },
                    );
                    zoom.removeStatusListener((status) {});
                    fade.removeStatusListener((status) {});
                    _animationController.removeStatusListener((status) {});
                  }
                },
              );
          }
        }
        break;
    }

    return WillPopScope(
      onWillPop: () {
        navigateBack();
        _animationController?.stop();
        _animationController?.dispose();
        widget.player?.stop();
      },
      child: Scaffold(
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
      ),
    );
  }

  navigateBack() async {
    AudioPlayer player = AudioPlayer();
    final cache = AudioCache();
    player = await cache.loop('music/pzz_loop2.wav');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NavigationPage(player)));
  }
}
