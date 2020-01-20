import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TetePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TetePageState();
  }
}

class TetePageState extends State<TetePage> {
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: Stack(children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                color: Colors.black,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Image.asset('assets/images/title.png')))),
        Positioned(
          bottom: 20,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Image.asset(
              'assets/images/character.png',
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 20,
          child: Text(score.toString(),
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontFamily: 'CoveredByYourGrace',
                fontSize: 100,
              )),
        ),
        areaButton(150, 150, 80, 150),
        areaButton(300, 140, 80, 150),
        areaButton(530, 140, 60, 150),
        areaButton(630, 100, 50, 100),
      ]),
    );
  }
}

Widget areaButton(double top, double left, double height, double width) {
  return Positioned(
    top: top,
    left: left,
    child: Opacity(
      opacity: 0.5,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
        ),
      ),
    ),
  );
}

_resetScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('score', 40);
}

Future<int> _addPoints() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int score = await prefs.getInt('score');
  await prefs.setInt('score', score++);
  return score;
}
