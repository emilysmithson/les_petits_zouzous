import 'package:flutter/material.dart';
import 'house.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> {
  AudioCache player;
  AudioPlayer audioPlayer;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/title.png'),
              GestureDetector(
                onTap: () {
                  audioPlayer.stop();
                  PlayMoulin();
                },
                child: Image.asset('assets/images/g1_button.png'),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/g2_button.png')),
              GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/info_button.png')),
            ],
          ),
        ));
  }

  void PlayMoulin() async {
    player.play('music/g1_intro.wav');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HousePage()),
    );
    player.clearCache();
  }

  @override
  void initState() {
    _playMusic();
  }


  void _playMusic() async {
    player = AudioCache();
    audioPlayer = await player.loop('music/pzz_loop2.wav');
    player.clearCache();
  }
}