
import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_request.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/auth_api_service.dart';
import 'package:pruebakidsandclouds/kidsandclouds/security/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthApiService api;
  final TokenStorage storage;



  AuthRepository(this.api, this.storage);

  Future<LoginResponse> login(String username, String password) async {
    try {
      final loginRequest = LoginRequest(username: username, password: password);
      final response = await api.login(loginRequest);
      await storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
   
      return response;
    } catch (e) {
      if (e is DioError && e.response != null) {
        final data = e.response?.data;
        if (e.response?.statusCode == 401 && data is Map<String, dynamic> && data['message'] != null) {
          throw Exception(data['message']);
        }
      }
      rethrow;
    }
  }



  // Future<LoginResponse> me() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userString = prefs.getString('user');
  //     if (userString == null || userString.isEmpty) {
  //       throw Exception('No user found in storage');
  //     }
   
  //     final user = User.fromJson(userJson);
  //     return user;
  //   } catch (e) {
  //     Log.e('Error en me(): $e');
  //     rethrow;
  //   }
  // }

}
