import 'package:flutter/material.dart';
import 'game_one_house.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'music_player.dart';
import 'game_two.dart';
import 'dart:async';

class NavigationPage extends StatefulWidget {
  AudioPlayer player = AudioPlayer();
  NavigationPage([this.player]);
  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  bool moulinButtonDown = false;
  bool infoButtonDown = false;
  bool animateButtons = false;
  final cache = AudioCache();
  AnimationController _animationController;
  Animation fadeIn;
  Animation padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: -55,
                child: Transform.scale(
                    scale: 0.4,
                    child: Image.asset('assets/images/logo_white.png'))),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 40, 0),
                  child: Image.asset('assets/images/pzz.png'),
                )),
            Positioned(
              bottom: 0,
              height: 550,
              child: Opacity(
                opacity: animateButtons ? 1 : fadeIn.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          right: animateButtons ? padding.value : 0),
                      child: GestureDetector(
                        onTap: () {
                          moulinButtonDown = true;
                          setState(() {});
                          Timer(Duration(milliseconds: 300), () {
                            animateButtons = true;
                            moulinButtonDown = false;
                            padding = Tween<double>(begin: 0, end: 700).animate(
                                CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(0, 1)))
                              ..addListener(() {
                                setState(() {});
                              })
                              ..addStatusListener((status) {
                                  if (status == AnimationStatus.completed) {
                                    print('should stop file!');
                                    _stopFile();
                                    PlayMoulin();

                                };
                              });
                            _animationController.forward(from: 0);
                            setState(() {});
                          });
                        },
                        child: Image.asset(
                          moulinButtonDown
                              ? 'assets/images/g1_button_on.png'
                              : 'assets/images/g1_button.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: animateButtons ? padding.value : 0),
                      child: GestureDetector(
                        onTap: () {
                          infoButtonDown = true;
                          setState(() {});
                          Timer(Duration(milliseconds: 300), () {
                            animateButtons = true;
                            infoButtonDown = false;
                            padding = Tween<double>(begin: 0, end: 700).animate(
                                CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(0, 1)))
                              ..addListener(() {
                                setState(() {});
                              })
                              ..addStatusListener((status) {
                                if (status == AnimationStatus.completed) {
                                  _stopFile();
                                  PlayGameTwo();

                                };
                              });
                            _animationController.forward(from: 0);
                            setState(() {});
                          });
                        },
                        child: Image.asset(
                          infoButtonDown
                              ? 'assets/images/g2_button_on.png'
                              : 'assets/images/g2_button.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: animateButtons ? padding.value : 0),
                      child: GestureDetector(
                          onTap: () {},
                          child: Image.asset('assets/images/info_button.png')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _stopFile() async {
    widget.player.stop();
  }

  void PlayMoulin() async {
    _stopFile();
    AudioPlayer player = await cache.play('music/intro.mp3');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameOnePage(player)),
    );
  }

  void PlayGameTwo() async {
    _stopFile();
    AudioPlayer player = await cache.play('music/gameTwo.wav');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameTwoPage(player)),
    );
  }

  @override
  void dispose() {
//    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cache.loadAll(['music/g1_intro.wav', 'music/gameTwo.wav']);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    fadeIn = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }
}
