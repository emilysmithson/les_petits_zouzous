import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GameOne extends StatefulWidget {
  Function returnToNavigation;
  AudioPlayer player;
  GameOne({this.returnToNavigation, this.player});

  @override
  State<StatefulWidget> createState() {
    return _GameOneState();
  }
}

class _GameOneState extends State<GameOne>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController animationController;
  Animation fadeIn;
  Animation zoomIn;
  Animation fadeOutHouse;
  Animation fadeInBravo;
  int round = 0;
  bool intro = true;
  bool flipCardsVisible = false;
  Offset offset;
  bool finale = false;
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();
  String track;
  List<bool> flipOnTouch = [true, true, true, true];

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5500));
    fadeIn = Tween<double>(begin: 1, end: 0).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && intro) {
          animationController.stop();
          animationController.dispose();
          animationController =
              AnimationController(vsync: this, duration: Duration(seconds: 2));
          zoomIn =
              Tween<double>(begin: 1, end: 8.5).animate(animationController)
                ..addListener(() {
                  setState(() {});
                })
                ..addStatusListener((status) {
                  if (status == AnimationStatus.completed && !finale) {
                    playMusic();
                    flipCardsVisible = true;
                  }
                });
          intro = false;

          animationController.forward(from: 0);
        }
      });

    animationController.forward();
    super.initState();
  }

  playMusic() async {
    player = await cache.play(track);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = width*1.3;

      switch (round) {
        case 0:
          offset = Offset(
            -width * 0.19,
            -height * 0.085,
          );
          track = 'music/g1_windmill.wav';
          break;
        case 1:
          offset = Offset(
            width * 0.179,
            -height * 0.086,
          );
          track = 'music/g1_hands.wav';
          break;

        case 2:
          offset = Offset(
            -width * 0.223,
            height * 0.345,
          );
          track = 'music/g1_bird.wav';
          break;
        case 3:
          offset = Offset(
            width * 0.258,
            height * 0.345,
          );
          track = 'music/g1_fish.wav';
      }

      return WillPopScope(
        onWillPop: () {
          intro ? widget.player?.stop() : player?.stop();
          widget.returnToNavigation();
          return null;
        },
        child: GestureDetector(
          onTap: () {
            if (finale) {
              widget.returnToNavigation();
            }
          },
          child: Container(
            height: height,
            width: width,
            color: Colors.lightBlueAccent,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: height,
                  width: width,
                  child: Opacity(
                    opacity: finale ? fadeOutHouse.value : 1,
                    child: Transform.scale(
                      scale: intro ? 1 : finale ? 1 : zoomIn.value,
                      origin: offset,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/house2.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: intro ? fadeIn.value : 0,
                  child: Container(
                    height: constraints.maxHeight,
                    width: width,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: height,
                  width: width,
                ),
                Positioned(
                  top: height * 0.6,
                  child: Opacity(
                    opacity: finale ? fadeInBravo.value : 0,
                    child: Transform.scale(
                      scale: 2,
                      child: Image.asset('assets/images/balloon.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Opacity(
                    opacity: finale ? fadeInBravo.value : 0,
                    child: Center(
                      child: Text(
                        'Bravo!!',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 120,
                            fontFamily: 'CoveredByYourGrace'),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: finale ? false : flipCardsVisible,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              height: height * 0.35,
                              width: width * 0.35,
                              child: guess(0)),
                          Container(
                              height: height * 0.35,
                              width: width * 0.35,
                              child: guess(1)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              height: height * 0.35,
                              width: width * 0.35,
                              child: guess(2)),
                          Container(
                              height: height * 0.35,
                              width: width * 0.35,
                              child: guess(3)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget guess(int imageNumber) {
    bool _flipOnTouch = true;
    List<Map<String, dynamic>> images = List<Map<String, dynamic>>();
    switch (round) {
      case 0:
        {
          images = [
            {'url': 'assets/images/g1_windmill.png', 'correctAnswer': true},
            {'url': 'assets/images/g1_balloon.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_cake.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_car.png', 'correctAnswer': false},
          ];
        }
        break;
      case 1:
        {
          images = [
            {'url': 'assets/images/g1_cat.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_dog.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_fish.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_hands.png', 'correctAnswer': true},
          ];
        }
        break;
      case 2:
        {
          images = [
            {'url': 'assets/images/g1_hat.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_bird.png', 'correctAnswer': true},
            {'url': 'assets/images/g1_kite.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_scooter.png', 'correctAnswer': false},
          ];
        }
        break;
      case 3:
        {
          images = [
            {'url': 'assets/images/g1_socks.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_fish.png', 'correctAnswer': true},
            {'url': 'assets/images/g1_spider.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_tree.png', 'correctAnswer': false},
          ];
        }
    }

    return FlipCard(
      onFlip: () async {
        if (images[imageNumber]['correctAnswer'] == false) {
          setState(() {
            flipOnTouch[imageNumber] = false;
          });
          player?.stop();
          playMusic();
        } else {
          flipOnTouch = [true, true, true, true];
          if (round == 3) {
            Timer(
              Duration(seconds: 1),
              () async {
                player.stop();
                player = await cache.play('music/g1_outro.wav');
                flipCardsVisible = false;
                animationController.reverse().whenComplete(() {
                  fadeOutHouse = Tween<double>(begin: 1, end: 0)
                      .animate(animationController)
                        ..addListener(() {
                          setState(() {});
                        });

                  fadeInBravo = Tween<double>(begin: 0, end: 1)
                      .animate(animationController)
                        ..addListener(() {
                          setState(() {});
                        });
                  setState(() {
                    finale = true;
                  });
                  animationController.forward();
                });
              },
            );
          } else {
            Timer(Duration(seconds: 1), () {
              animationController.reverse().whenComplete(() {
                round++;
                setState(() {});
                animationController.forward();
              });
            });
            flipCardsVisible = false;
          }
        }
      },
      flipOnTouch: flipOnTouch[imageNumber],
      front: Container(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(images[imageNumber]['url']),
      )),
      back: Container(
        child: images[imageNumber]['correctAnswer']
            ? Image.asset('assets/images/correct.png')
            : Image.asset('assets/images/incorrect.png'),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    player?.dispose();
    cache?.clearCache();
    super.dispose();
  }
}
