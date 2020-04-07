import 'package:flutter/material.dart';
import 'navigation_page.dart';


class MoulinResultsPage extends StatefulWidget {
  int score;
  MoulinResultsPage(this.score);
  @override
  State<StatefulWidget> createState() {
    return _MoulinResultsPageState();
  }
}

class _MoulinResultsPageState extends State<MoulinResultsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation zoomOut;
  Animation panHouse;
  Animation fadeInBravo;
  Animation fadeOutHouse;
  Animation fadeInBalloon;
  Animation fadeOutAll;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 12), vsync: this);
    zoomOut = Tween<double>(begin: 9, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.2),
      ),
    );
    panHouse = Tween<double>(begin: 0, end: 0.25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.4),
      ),
    );

    fadeInBravo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.25, 0.6),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );
    fadeOutHouse = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.6),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );
    fadeInBalloon = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.45, 0.8),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );
    fadeOutAll = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.8, 1.0),
      )..addListener(
          () {
            setState(() {});
          },
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        navigateBack();
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
            );
          },
          child: Stack(
            children: <Widget>[
              Positioned.fromRect(
                rect: Rect.fromLTWH(
                    0, panHouse.value * size.height, size.width, size.height),
                child: Opacity(
                  opacity: fadeOutHouse.value == null ? 1 : fadeOutHouse.value,
                  child: Transform.scale(
                    scale: zoomOut.value,
                    origin: Offset(
                      -MediaQuery.of(context).size.width * -0.24,
                      MediaQuery.of(context).size.height * 0.25,
                    ),
                    child: Image.asset('assets/images/house2.png'),
                  ),
                ),
              ),
              Positioned.fromRect(
                rect: Rect.fromLTWH(
                    0, 0 * size.height, size.width, size.height / 3),
                child: Opacity(
                  opacity: fadeInBravo.value == null ? 0 : fadeInBravo.value,
                  child: Center(
                    child: Text(
                      'Bravo!!',
                      style: TextStyle(
                          fontSize: 120, fontFamily: 'CoveredByYourGrace'),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: fadeInBalloon.value == null ? 0 : fadeInBalloon.value,
                child: Stack(
                  children: <Widget>[
                    Positioned.fromRect(
                        rect: Rect.fromLTWH(
                            0, 0.25 * size.height, size.width, size.height),
                        child: Transform.scale(
                          scale: 2,
                          child: Image.asset('assets/images/balloon.png'),
                        )),
                    Positioned.fromRect(
                      rect: Rect.fromLTWH(
                          0, 0.32 * size.height, size.width, size.height / 4),
                      child: Center(
                        child: Text(
                          widget.score.toString(),
                          style: TextStyle(
                              fontSize: 90, fontFamily: 'CoveredByYourGrace'),
                        ),
                      ),
                    ),
                    Positioned.fromRect(
                      rect: Rect.fromLTWH(0.11 * size.width, 0.37 * size.height,
                          size.width, size.height / 4),
                      child: Center(
                        child: Transform.rotate(
                          angle: 0.3,
                          child: Text(
                            '/',
                            style: TextStyle(
                                fontSize: 90, fontFamily: 'CoveredByYourGrace'),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fromRect(
                      rect: Rect.fromLTWH(0.2 * size.width, 0.4 * size.height,
                          size.width, size.height / 4),
                      child: Center(
                        child: Text(
                          '40',
                          style: TextStyle(
                              fontSize: 90, fontFamily: 'CoveredByYourGrace'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateBack() async {
    _animationController?.stop();
    _animationController?.dispose();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NavigationPage()));
  }
}
