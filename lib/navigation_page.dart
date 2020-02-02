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

class _NavigationPageState extends State<NavigationPage> {
  AudioCache cache = AudioCache();
  AudioPlayer player;

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/title.png'),
              GestureDetector(
                onTap: () {
                  _stopFile();
                  PlayMoulin();
                },
                child: Image.asset('assets/images/g1_button.png'),
              ),
              GestureDetector(
                  onTap: () {_stopFile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameTwoPage()),
                  );
                  },
                  child: Image.asset('assets/images/g2_button.png')),
              GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/info_button.png')),
            ],
          ),
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

    _playFile();
  }
}
