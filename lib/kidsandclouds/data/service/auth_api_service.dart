
import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/core/helper/constants.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_request.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: "${AppConstants.dummyUsersMock}")
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST("/api/login")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
  

  @GET("/User")
  Future<LoginResponse> me();

}
