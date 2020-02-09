import 'package:flutter/material.dart';
import 'navigation_page.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animateTreeX;
  Animation animateTreeY;
  Animation animateUmbrellaX;
  Animation animateUmbrellaY;
  Animation animateBoyX;
  Animation animateBoyY;
  Animation animateZY;
  Animation animateZscale;
  Animation fadeOut;
  double animationStart = 0.3;
  double animationEnd = 0.5;
  AudioPlayer player = AudioPlayer();
  final cache = AudioCache();

  @override
  void initState() {
    playFile(String fileName) async {
      player = await cache.loop(fileName);
    }

    playFile('music/pzz_loop2.wav');
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationPage(player)));
        }
      });
    animateTreeX = Tween<double>(begin: 30, end: -100).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateTreeY = Tween<double>(begin: 50, end: -100).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateUmbrellaX = Tween<double>(begin: 30, end: -100).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateUmbrellaY = Tween<double>(begin: 50, end: -100).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateBoyX = Tween<double>(begin: 30, end: -100).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateBoyY = Tween<double>(begin: 50, end: -100).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(animationStart, animationEnd)))
      ..addListener(() {
        setState(() {});
      });
    animateZscale = Tween<double>(begin: 1, end: 0.4).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.6, 1)))
      ..addListener(() {
        setState(() {});
      });
    animateZY = Tween<double>(begin: 120, end: -55).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.6, 1)))
      ..addListener(() {
        setState(() {});
      });
    fadeOut = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.4, 0.6)))
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 200),
                child: Image.asset('assets/images/logo.png'),
              )),
          Positioned(
              left: animateBoyX.value,
              bottom: animateBoyY.value,
              child: Container(
                  height: 120, child: Image.asset('assets/images/man.png'))),
          Positioned(
              left: animateUmbrellaX.value,
              top: animateUmbrellaY.value,
              child: Container(
                  height: 80,
                  child: Image.asset('assets/images/umbrella.png'))),
          Positioned(
              right: animateTreeX.value,
              bottom: animateTreeY.value,
              child: Container(
                  height: 120, child: Image.asset('assets/images/tree.png'))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
                child: Text(
                  'Illustrations by Aurélie Guillerey \nApplication by Emily Smithson',
                  style: TextStyle(
                      fontFamily: 'Sacramento',
                      fontSize: 30,
                      color: Colors.red),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  '© Les Petits Zouzous',
                  style: TextStyle(
                      fontFamily: 'Sacramento',
                      fontSize: 30,
                      color: Colors.black),
                )),
          ),
          Opacity(
            opacity: fadeOut.value,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black),
          ),
          Positioned(
              top: animateZY.value,
              child: Transform.scale(
                  scale: animateZscale.value,
                  child: Opacity(
                      opacity: fadeOut.value,
                      child: Image.asset('assets/images/logo_white.png')))),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 40, 0),
                child: Opacity(
                    opacity: fadeOut.value,
                    child: Image.asset('assets/images/pzz.png')),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {

  }

}
