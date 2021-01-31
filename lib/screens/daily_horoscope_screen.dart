import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stargazer_mobile_app/services/api_instance.dart';
import 'package:stargazer_mobile_app/services/api_services.dart';
import 'package:stargazer_mobile_app/models/daily_horoscope.dart';

class DailyHoroscopeScreen extends StatefulWidget {
  @override
  _DailyHoroscopeState createState() => _DailyHoroscopeState();
}

class _DailyHoroscopeState extends State<DailyHoroscopeScreen> {
  String imagename = "";

  Future<String> getImageName() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('sign');
  }

  Future<DailyHoroscope> getHoroscopeData() async {
    var prefs = await SharedPreferences.getInstance();
    var apiServices = APIServices(APIInstance().instance);

    return apiServices.getDailyHoroscopeData(prefs.getString('sign'));
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
        title: Text('Daily Horoscope'),
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
                      FutureBuilder<DailyHoroscope>(
                          future: getHoroscopeData(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              );
                            } else {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'နေ့မှ - နေ့ထိ: ${snapshot.data.dateRange}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'လက်ရှိနေ့စွဲ: ${snapshot.data.currentDate}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      AutoSizeText(
                                        'ယနေ့အတွက်စာဆို: ${snapshot.data.description}\n',
                                        maxLines: 10,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'လက်တွဲဖော်ရာသီခွင်: ${snapshot.data.compatibility}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'ယနေ့စိတ်အနေအထား : ${snapshot.data.mood}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'ကံကောင်းစေသောအရောင် : ${snapshot.data.color}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'ကံကောင်းစေသောနံပါတ် : ${snapshot.data.luckyNumber}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'ကံကောင်းစေသောအချိန် : ${snapshot.data.luckyTime}\n',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ],
                                  ));
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
