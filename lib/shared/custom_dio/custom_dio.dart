import 'package:MovieStar/shared/custom_dio/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:MovieStar/env/enviroment.dart';

class CustomDio {
  var dio;
  CustomDio() {
    dio = Dio();
    dio.options.baseUrl = BASE_URL;
    dio.interceptors.add(CustomIntercetors());
    dio.options.connectTimeout = 15000;
  }
  Dio get instance => dio;
}
