import 'package:dio/dio.dart';

class APIInstance {
  get instance {
    BaseOptions options = new BaseOptions(
      baseUrl: "http://localhost:3000",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    return Dio(options);
  }
}
