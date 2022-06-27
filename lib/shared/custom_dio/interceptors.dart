import 'package:dio/dio.dart';

class CustomIntercetors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZWYxNTg2MWFlMzhmMDEwNzRjMWFhMmEzZDFiMzg4ZSIsInN1YiI6IjYyYjY0NWRjYmRkNTY4MDA1NTZmNzFkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ayE4cZwzRT2GUmDRvBWcGfZXseby7blaHovmErP33Oc"
    };
    handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    //200
    //201
    handler.next(response);
  }

  @override
  onError(DioError e, ErrorInterceptorHandler handler) {
    //Exception
    handler.next(e);
  }
}
