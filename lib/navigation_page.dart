import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class NavigationPage extends StatefulWidget {
  final Function() playGameOne;
  final Function() playGameTwo;
  final Function() stopMusic;

  final Function() showInformationPage;

  NavigationPage(
      [this.playGameOne, this.playGameTwo, this.stopMusic,  this.showInformationPage]);
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
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();
  AnimationController _animationController;
  Animation fadeIn;
  Animation padding;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 1.3;
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: animateButtons ? 1 : fadeIn.value,
                child: Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            right: animateButtons ? padding.value : 0),
                        child: GestureDetector(
                          onTap: () {
                            widget.stopMusic();
                            moulinButtonDown = true;
                            setState(() {});
                            Timer(Duration(milliseconds: 300), () {
                              animateButtons = true;
                              moulinButtonDown = false;
                              padding = Tween<double>(begin: 0, end: 700)
                                  .animate(CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(0, 1)))
                                    ..addListener(() {
                                      setState(() {});
                                    })
                                    ..addStatusListener((status) {
                                      if (status == AnimationStatus.completed) {
                                        PlayMoulin();
                                      }
                                      ;
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
                            widget.stopMusic();
                            infoButtonDown = true;
                            setState(() {});
                            Timer(Duration(milliseconds: 300), () {
                              animateButtons = true;
                              infoButtonDown = false;
                              padding = Tween<double>(begin: 0, end: 700)
                                  .animate(CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(0, 1)))
                                    ..addListener(() {
                                      setState(() {});
                                    })
                                    ..addStatusListener((status) {
                                      if (status == AnimationStatus.completed) {
                                        PlayGameTwo();
                                      }
                                      ;
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
                            onTap: () {
                              widget.stopMusic();
                              infoButtonDown = true;
                              setState(() {});
                              Timer(Duration(milliseconds: 300), () {
                                animateButtons = true;
                                infoButtonDown = false;
                                padding = Tween<double>(begin: 0, end: 700)
                                    .animate(CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(0, 1)))
                                  ..addListener(() {
                                    setState(() {});
                                  })
                                  ..addStatusListener((status) {
                                    if (status == AnimationStatus.completed) {
                                      widget.showInformationPage();
                                    }
                                    ;
                                  });
                                _animationController.forward(from: 0);
                                setState(() {});
                              });
                            },
                            child:
                                Image.asset('assets/images/info_button.png')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void PlayMoulin() async {
    widget.playGameOne();
  }

  void PlayGameTwo() async {
    widget.playGameTwo();
  }

  @override
  void dispose() {
    player?.stop();
    // player?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
