import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subunit/UI/decoration.dart';
import 'package:subunit/authorize.dart';
import 'package:subunit/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubUnit Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance
        .currentUser()
        .then((cu) => {currentUser = cu})
        .catchError((err) => print(err));

    print(currentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              currentUser == null ? LoginPage() : HomePage(),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xffffffff),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 235,
                  child: Image.asset(
                    'assets/images/splashmaskbluecrop.jpeg',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  top: 180,
                  left: (MediaQuery.of(context).size.width - 90) / 2,
                  child: Image.asset(
                    'assets/images/loader2.gif',
                    height: 90,
                    width: 90,
                  ),
                ),
                WavyHeaderImage(),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 140,
                    speed: 0.8,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 80,
                    speed: 0.8,
                    offset: pi,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 180,
                    speed: 0.8,
                    offset: pi / 2,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
