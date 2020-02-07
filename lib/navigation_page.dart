import 'package:flutter/material.dart';
import 'game_one.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'game_two.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> with SingleTickerProviderStateMixin{
  AudioCache cache = AudioCache();
  AudioPlayer player;
  AnimationController animationController;
  Animation fadeIn;

  void _playFile() async {
//    player = await cache.loop('music/pzz_loop2.wav');
  }

  void _stopFile() {
    player?.stop();
  }


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
              child: Opacity(opacity: fadeIn.value,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _stopFile();
                        PlayMoulin();
                      },
                      child: Image.asset('assets/images/g1_button.png'),
                    ),
                    GestureDetector(
                        onTap: () {
                          _stopFile();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameTwoPage()),
                          );
                        },
                        child: Image.asset('assets/images/g2_button.png')),
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/images/info_button.png')),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void PlayMoulin() async {
    _stopFile();
    cache.play('music/intro.mp3');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameOnePage()),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    fadeIn = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 1)))
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    _playFile();
  }
}
