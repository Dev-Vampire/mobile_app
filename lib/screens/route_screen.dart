import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stargazer_mobile_app/screens/login_screen.dart';
import 'package:stargazer_mobile_app/main.dart';
import 'package:stargazer_mobile_app/screens/registration_screen.dart';

class RouteScreen extends StatelessWidget {
  Future<Widget> navigate() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('login') == true) {
      return MyApp();
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: navigate(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.blue,
          );
        } else {
          return snapshot.data;
        }
      },
    );
  }
}
