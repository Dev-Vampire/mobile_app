import 'package:dio/dio.dart';
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

  Future<bool> login(LoginUser user) async {
    var response = await this._apiInstance.post('/login', data: user.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future getDailyHoroscopeData() async {}

  Future<String> getLifeLongHoroscopeData(String sign) async {
    var response = await this._apiInstance.get('/user/lifetimehoroscope/$sign');
    return response.data;
  }
}
