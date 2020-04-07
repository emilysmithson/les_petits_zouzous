import 'package:flutter/material.dart';
import 'navigation_page.dart';
import 'game_one.dart';
import 'game_two.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'information_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animateZscale;
  Animation animateZtranslate;
  Animation animatePZZscale;
  Animation animatePZZtranslate;
  Animation translateImages;
  Animation fadeOutIntro;
  Animation fadeInNavigation;
  int widgetNumber = 0;
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  @override
  void initState() {
    playFile();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    animateZscale = Tween<double>(begin: 1, end: width * 0.00125).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.6, 1)))
      ..addListener(() {
        setState(() {});
      });
    animateZtranslate = Tween<double>(begin: 0, end: width * 0.15 - height / 2 + 10)
        .animate(CurvedAnimation(
            parent: animationController, curve: Interval(0.6, 1)))
          ..addListener(() {
            setState(() {});
          });
    animatePZZscale = Tween<double>(begin: width * 0.001, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.6, 1)))
      ..addListener(() {
        setState(() {});
      });
    animatePZZtranslate = Tween<double>(begin: width * 1.3, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.6, 1)))
      ..addListener(() {
        setState(() {});
      });
    translateImages = Tween<double>(begin: 0, end: width / 3).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.2, 0.5)))
      ..addListener(() {
        setState(() {});
      });
    fadeOutIntro = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.4, 0.55)))
      ..addListener(() {
        setState(() {});
      });
    fadeInNavigation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0.9, 1)))
      ..addListener(() {
        setState(() {});
      });
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.translate(
                offset: Offset(0.0, animateZtranslate.value),
                child: Transform.scale(
                    scale: animateZscale.value,
                    child: Image.asset('assets/images/logo_white.png'))),
            Opacity(
                opacity: fadeOutIntro.value,
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                )),
            Opacity(
              opacity: fadeOutIntro.value,
              child: Image.asset('assets/images/logo.png'),
            ),
            Transform.translate(
              offset: Offset(translateImages.value, translateImages.value),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: width * 0.2,
                        child: Image.asset('assets/images/tree.png')),
                  )),
            ),
            Transform.translate(
              offset: Offset(-translateImages.value, translateImages.value),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: width * 0.2,
                        child: Image.asset('assets/images/man.png')),
                  )),
            ),
            Transform.translate(
              offset: Offset(-translateImages.value, -translateImages.value),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 25, 8, 8),
                    child: Container(
                        width: width * 0.2,
                        child: Image.asset('assets/images/umbrella.png')),
                  )),
            ),
            Transform.translate(
              offset: Offset(translateImages.value, -translateImages.value),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 80, 8, 8),
                    child: Container(
                        width: width * 0.2,
                        child: Image.asset('assets/images/spider.png')),
                  )),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: Offset(0, -height * 0.2),
                  child: Opacity(
                    opacity: fadeOutIntro.value,
                    child: Text(
                      'Illustrations by Aurélie Guillerey \nApplication by Emily Smithson',
                      style: TextStyle(
                          fontFamily: 'Sacramento',
                          fontSize: 30,
                          color: Colors.red),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Opacity(
                    opacity: fadeOutIntro.value,
                    child: Text(
                      '© Les Petits Zouzous',
                      style: TextStyle(
                          fontFamily: 'Sacramento',
                          fontSize: 30,
                          color: Colors.black),
                    ),
                  )),
            ),
            Opacity(
              opacity: fadeInNavigation.value,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 0.3,
                    child: Transform.translate(
                      offset: Offset(0, -animatePZZtranslate.value),
                      child: Transform.scale(
                        scale: animatePZZscale.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset('assets/images/pzz1.png',
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 1 / 1.3,
                        child: ClipRect(
                          child: returnWidget(widgetNumber, playGameOne,
                              playGameTwo, showNavigation, stopFile, showInformationPage),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  playFile() async {
    player = await cache.loop('music/pzz_loop2.wav');
  }

  stopFile() async {
    player?.stop();
  }

  playGameOne() async {
    player = await cache.play('music/g1_intro.wav');
    setState(() {
      widgetNumber = 1;
    });
  }

  playGameTwo() async {
    cache.load('music/gameTwo.wav');
    player = await cache.play('music/gameTwo.wav');
    setState(() {
      widgetNumber = 2;
    });
  }

  showNavigation() {
    setState(() {
      widgetNumber = 0;
    });
  }
showInformationPage() async {
  player = await cache.loop('music/pzz_loop1.wav');
    setState(() {
      widgetNumber = 3;
    });
}
  Widget returnWidget(int widgetNumber, Function playGameOne,
      Function playGameTwo, Function returnToNavigation, Function stopFile, Function showInformationPage) {
    switch (widgetNumber) {
      case 0:
        return NavigationPage(playGameOne, playGameTwo, stopFile, showInformationPage);
        break;
      case 1:
        return GameOne(returnToNavigation: returnToNavigation, player: player);
        break;
      case 2:
        return GameTwoPage(
            returnToNavigation: returnToNavigation, player: player);
      case 3:
        return InformationPage(returnToNavigation, player);
    }
  }
  @override
  void dispose() {
    animationController.dispose();
    player.stop();
    player.dispose();
    cache.clearCache();
    super.dispose();
  }

}
