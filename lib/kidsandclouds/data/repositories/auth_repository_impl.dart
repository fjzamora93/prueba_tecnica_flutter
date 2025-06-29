
import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/core/helper/log_helper.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_request.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/auth_api_service.dart';
import 'package:pruebakidsandclouds/kidsandclouds/security/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService api;
  final TokenStorage storage;



  AuthRepositoryImpl(this.api, this.storage);

  Future<User> login(String username, String password) async {
    try {
      final loginRequest = LoginRequest(username: username, password: password);
      final LoginResponse response= await api.login(loginRequest);
      await storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      User user = User.fromLoginResponse(response);
      return user;
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


  Future<User> me() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final LoginResponse response = await api.me();
      User user = User.fromLoginResponse(response);
      return user;
    } catch (e) {
      Log.e('Error en me(): $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await storage.clearTokens();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
    } catch (e) {
      Log.e('Error en logout(): $e');
      rethrow;
    }
  }

}
