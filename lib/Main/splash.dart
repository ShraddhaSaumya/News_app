import 'package:api_app/homelogin.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body: AnimatedSplashScreen(
          backgroundColor: Colors.blue,
          splashIconSize: 500,
          splash: FlareActor(
            'assets/loading-animation-sun-flare.flr',
            animation: 'active',
          ),
          splashTransition: SplashTransition.slideTransition,
          duration: 2500,
          animationDuration: Duration(milliseconds: 1900),
          nextScreen:HomePage(),
        )
      )
    );
  }
}
