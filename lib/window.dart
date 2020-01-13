import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audio_cache.dart';
import 'house.dart';

class WindowPage extends StatefulWidget {
  int round;
  WindowPage(this.round);
  @override
  State<StatefulWidget> createState() {
    return _WindowPageState();
  }
}

class _WindowPageState extends State<WindowPage> {
  @override
  Widget build(BuildContext context) {
    AudioCache player = AudioCache();
    String track;

    int round = widget.round;
    switch (round) {
      case 0:
        track = 'music/g1_windmill.wav';
        break;
      case 1:
        track = 'music/g1_hands.wav';
        break;
      case 2:
        track = 'music/g1_bird.wav';
        break;
      case 3:
        track = 'music/g1_fish.wav';
    }
    player.play(track);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            painter: DrawGrid(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Guess(0, round, context, track),
                  Guess(1, round, context, track)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Guess(2, round, context, track),
                  Guess(3, round, context, track),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Guess(int imageNumber, int round, BuildContext context, String track) {
    bool flipOnTouch = true;
    List<Map<String, dynamic>> images = List<Map<String, dynamic>>();
    switch (round) {
      case 0:
        {
          images = [
            {'url': 'assets/images/g1_balloon.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_bird.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_car.png', 'correctAnswer': false},
            {'url': 'assets/images/g1_windmill.png', 'correctAnswer': true},
          ];
        }
    }

    return FlipCard(
      onFlip: () async {
        if (images[imageNumber]['correctAnswer'] == false) {
          AudioCache player = AudioCache();
          player.play(track);
          player.clearCache();
          flipOnTouch = false;
        } else {
          await Future.delayed(Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HousePage(round+1)),
          );
        }
      },
      flipOnTouch: flipOnTouch,
      front: Container(
        child: Image.asset(images[imageNumber]['url']),
      ),
      back: Container(
        child: images[imageNumber]['correctAnswer']
            ? Image.asset('assets/images/correct.png')
            : Image.asset('assets/images/incorrect.png'),
      ),
    );
  }
}

class DrawGrid extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 20;

    Offset p1 = Offset(size.width / 2, 0);
    Offset p2 = Offset(size.width / 2, size.height);
    canvas.drawLine(p1, p2, paint);
    p1 = Offset(0, size.height / 2);
    p2 = Offset(size.width, size.height / 2);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
