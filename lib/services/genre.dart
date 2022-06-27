import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:MovieStar/shared/custom_dio/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenreService {
  final _client = new CustomDio().instance;

  Future getGenres() async {
    try {
      var jsonEncoder2 = JsonEncoder();
      var response = await _client
          .get("genre/movie/list", queryParameters: {"language": "pt-BR"});
      SharedPreferences.getInstance().then((prefs) => {
            prefs.setString(
                'genres', jsonEncoder2.convert(response.data["genres"])),
          });
      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }
}
