import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/kidsandclouds/security/token_storage.dart';


Dio createDio(TokenStorage tokenStorage) {
  final dio = Dio(); 

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await tokenStorage.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (e, handler) async {
      return handler.next(e);
    },
  ));

  return dio;
}
