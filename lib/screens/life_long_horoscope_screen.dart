import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stargazer_mobile_app/services/api_instance.dart';
import 'package:stargazer_mobile_app/services/api_services.dart';

class LifeLongHoroscope extends StatefulWidget {
  @override
  _LifeLongHoroscopeState createState() => _LifeLongHoroscopeState();
}

class _LifeLongHoroscopeState extends State<LifeLongHoroscope> {
  String imagename = "";

  Future<String> getImageName() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('sign');
  }

  Future<String> getHoroscopeData() async {
    var prefs = await SharedPreferences.getInstance();
    var apiServices = APIServices(APIInstance().instance);

    return await apiServices.getLifeLongHoroscopeData(prefs.getString('sign'));
  }

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('LifeTime Horoscope'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Object>(
              future: getImageName(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/${snapshot.data}.png',
                        width: 200,
                        height: 200,
                      ),
                      FutureBuilder<Object>(
                          future: getHoroscopeData(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  snapshot.data,
                                  maxLines: 300,
                                  maxFontSize: 20,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }
                          })
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
