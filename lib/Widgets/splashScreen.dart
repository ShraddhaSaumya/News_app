import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:api_call/News/NewsFeed.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Login/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/icon.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
          duration: 3000,
          animationDuration: Duration(milliseconds: 700),
          splash: FlareActor(
            "assets/sec.flr",
            animation: 'loading',
          ),
          splashIconSize: 500,
          nextScreen: //NewsFeed(),
              LoginScreen(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
        ),
      ),
    );
  }
}
