import 'dart:io';

import 'package:dio/dio.dart';
import 'package:MovieStar/shared/custom_dio/custom_dio.dart';

class SearchService {
  final _client = new CustomDio().instance;

  Future searchMovie({query}) async {
    try {
      var response = await _client.get("search/movie",
          queryParameters: {"language": "pt-BR", "query": query});
      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future searchByCategory({genre_id}) async {
    try {
      var response = await _client.get("discover/movie",
          queryParameters: {"language": "pt-BR", "with_genres": genre_id});
      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }
}
