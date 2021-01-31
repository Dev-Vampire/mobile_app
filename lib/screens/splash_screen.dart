import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:stargazer_mobile_app/screens/main_screen.dart';
import 'package:stargazer_mobile_app/screens/registration_screen.dart';

class AppSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: Register(),
          image: Image.asset('images/telescope.png'),
          backgroundColor: Colors.black,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.blue),
    );
  }
}
