import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'my_flutter_app_icons.dart';
import 'package:audioplayers/audioplayers.dart';

class InformationPage extends StatelessWidget {
  Function() returnToNavigation;
  AudioPlayer player;
  InformationPage(this.returnToNavigation, this.player);
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/chansons_pour_apprendre.png',
      'assets/images/chansons_pour_samuser_1.jpg',
      'assets/images/chansons_pour_samuser_2.jpg',
      'assets/images/chansons_pour_sendormir.jpg',
      'assets/images/chansons_dhiver.jpg'
    ];
    Color iconColor = Colors.white;
    double iconSize = 30;
    String fontFamily = 'Pangolin';

    return WillPopScope(
      onWillPop: () {
        player?.stop();
        player?.dispose();
        returnToNavigation();
        return null;
      },
      child: Container(
        color: Colors.black,
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Image.asset('assets/images/hat.png')),
                  Text(
                    'Information',
                    style: TextStyle(
                        fontFamily: 'Pangolin',
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'French Nursery Rhymes and Action Songs For Babies, Toddlers and Preschoolers. Classes, music and more!',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'For more information, visit:',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset('assets/images/g1_socks.png'),
                      )),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _launchURL('http://www.petitszouzous.com');
                },
                child: Text(
                  'petitzouzous.com',
                  style: TextStyle(
                      color: Colors.red, fontSize: 40, fontFamily: fontFamily),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'To listen to one of our fabulous French music albums, click to buy a cd or visit your favourite streaming service below',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: CarouselSlider(
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  height: 200,
                  items: [0, 1, 2, 3, 4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            player?.stop();
                            _launchURL(
                                'http://www.petitszouzous.com/index.php/shop');
                          },
                          child: Container(
                              margin: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.black),
                              child: Image.asset(
                                imgList[i],
                                fit: BoxFit.fitHeight,
                              )),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: Image.asset('assets/images/brush.png',
                          fit: BoxFit.fill)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(MyFlutterApp.amazon,
                                color: iconColor, size: iconSize),
                            onPressed: () {
                              _launchURL(
                                  'https://music.amazon.co.uk/artists/B004IEWPFC?ref=dm_sh_8270-b42c-dmcp-5003-9a2a0&musicTerritory=GB&marketplaceId=A1F83G8C2ARO7P');
                            }),
                        IconButton(
                            icon: Icon(MyFlutterApp.itunes,
                                color: iconColor, size: iconSize),
                            onPressed: () {
                              player?.stop();
                              _launchURL(
                                  'https://itunes.apple.com/us/artist/les-petits-zouzous/id413688226');
                            }),
                        IconButton(
                            icon: Icon(MyFlutterApp.spotify,
                                color: iconColor, size: iconSize),
                            onPressed: () {
                              player?.stop();
                              _launchURL(
                                  'https://open.spotify.com/artist/0HoPMQE1US9eqqc96YppjH');
                            }),
                        IconButton(
                            icon: Icon(MyFlutterApp.youtube,
                                color: iconColor, size: iconSize),
                            onPressed: () {
                              player?.stop();
                              _launchURL(
                                  'https://www.youtube.com/channel/UCMzr9zsdKxjWUZNPqd5NjxA');
                            }),
                        IconButton(
                            icon: Icon(MyFlutterApp.facebook,
                                color: iconColor, size: iconSize),
                            onPressed: () {
                              player?.stop();
                              _launchURL(
                                  'https://www.facebook.com/petitszouzous/');
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset('assets/images/g1_dog.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Application by Emily Smithson based on ideas by Christopher Mapp',
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: fontFamily,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'Illustrations by Aurellie Guillerey\naurelieguillereysite.free.fr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: fontFamily,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      returnToNavigation();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        'assets/images/g1_hands.png',
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 10),
              Container(width: MediaQuery.of(context).size.width/5,height: MediaQuery.of(context).size.width/5,
                child: GestureDetector(
                  onTap: () {
                    player?.stop();
                    returnToNavigation();
                  },
                  child: Image.asset(
                    'assets/images/back_button.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
