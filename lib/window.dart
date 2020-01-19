import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audio_cache.dart';
import 'house.dart';
import 'moulin_results_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WindowPage extends StatefulWidget {
  int round;
  WindowPage(this.round);
  @override
  State<StatefulWidget> createState() {
    return _WindowPageState();
  }
}

class _WindowPageState extends State<WindowPage> {
  _resetScore() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', 0);
  }
  @override
  Widget build(BuildContext context) {
    AudioCache player = AudioCache();
    String track;

_resetScore();


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
    int scoreForRound = 10;
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
         // scoreForRound = scoreForRound - 3;
          AudioCache player = AudioCache();
          player.play(track);
          flipOnTouch = false;
        } else {
          //_addScore(scoreForRound);
         // int score = await _getScore();
          await Future.delayed(Duration(seconds: 2));
          round == 3
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoulinResultsPage(1)))
              : Navigator.pop(context, HousePage());
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
  Future<int> _getScore()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int score =  await prefs.getInt('score');
    return score;
  }
   _addScore(int score) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _score =  await prefs.getInt('score');
    await prefs.setInt('score', score+_score);

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
