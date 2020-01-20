import 'package:flutter/material.dart';

class TetePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TetePageState();
  }
}

class TetePageState extends State<TetePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Image.asset('assets/images/title.png'),
          )),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.lightBlue[100],
          child: Image.asset('assets/images/character.png'),
        ),
      ),
      Positioned(
        top: 120,
        left: 140,
        child: Opacity(
          opacity: 0.7,
          child: Container(
            height: 80,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
      ),
      Positioned(
        top: 300,
        left: 140,
        child: Opacity(
          opacity: 0.7,
          child: Container(
            height: 80,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
      ),
      Positioned(
        top: 530,
        left: 140,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
      ),   Positioned(
        top: 630,
        left: 90,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
          ),
        ),
      ),
    ]);
  }
}
