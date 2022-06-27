import 'dart:io';

import 'package:dio/dio.dart';
import 'package:MovieStar/shared/custom_dio/custom_dio.dart';

class MovieService {
  final _client = new CustomDio().instance;

  Future getTop() async {
    try {
      var response = await _client
          .get("movie/top_rated", queryParameters: {"language": "pt-BR"});

      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future getPopular() async {
    try {
      var response = await _client
          .get("movie/popular", queryParameters: {"language": "pt-BR"});

      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future getUpComming() async {
    try {
      var response = await _client
          .get("movie/upcoming", queryParameters: {"language": "pt-BR"});

      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future getSimilar({movieId}) async {
    try {
      var response = await _client.get("movie/$movieId/similar",
          queryParameters: {"language": "pt-BR"});

      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future getReviews({movieId}) async {
    try {
      var response = await _client.get("movie/$movieId/reviews",
          queryParameters: {"language": "pt-BR"});

      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }

  Future getGenres() async {
    try {
      var response = await _client
          .get("genre/movie/list", queryParameters: {"language": "pt-BR"});
      return response;
    } on DioError catch (error) {
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }
}
