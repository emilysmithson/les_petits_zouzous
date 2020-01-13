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
  AudioCache cache = AudioCache(); // you have this
  AudioPlayer player; // create this

  void _playFile() async {
    player = await cache.play('music/pzz_loop2.wav'); // assign player here
  }

  void _stopFile() {
    player?.stop(); // stop the file like this
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
    _stopFile();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HousePage(0)),
    );
  }

  @override
  void initState() {
    _playFile();
  }
}
