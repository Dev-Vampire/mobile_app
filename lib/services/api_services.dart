import 'package:dio/dio.dart';
import 'package:stargazer_mobile_app/models/daily_horoscope.dart';
import 'package:stargazer_mobile_app/models/login_user_model.dart';
import 'package:stargazer_mobile_app/models/registration_user_model.dart';

class APIServices {
  final Dio _apiInstance;

  APIServices(this._apiInstance);

  Future<String> register(RegistrationUser user) async {
    var response =
        await this._apiInstance.post('/register', data: user.toJson());
    if (response.statusCode == 201) {
      print(response.data);
      return response.data['sign'];
    } else {
      return "";
    }
  }

  Future<RegistrationUser> login(LoginUser user) async {
    
      var response =
          await this._apiInstance.post('/login', data: user.toJson());
   
        return RegistrationUser.fromJson(response.data);
       
    
  }

  Future<String> getLifeLongHoroscopeData(String sign) async {
    var response = await this._apiInstance.get('/user/lifetimehoroscope/$sign');
    return response.data;
  }

  Future<DailyHoroscope> getDailyHoroscopeData(String sign) async {
    var response = await this._apiInstance.get('/user/Dailyhoroscope/$sign');
    return Future.value(DailyHoroscope.fromJson(response.data));
  }
}
