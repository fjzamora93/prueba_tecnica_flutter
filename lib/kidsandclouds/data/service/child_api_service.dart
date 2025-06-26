import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/core/helper/constants.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:retrofit/http.dart';

part 'child_api_service.g.dart';



@RestApi(baseUrl: "${AppConstants.childMockUrl}")
abstract class ChildApiService {
  factory ChildApiService(Dio dio, {String baseUrl}) = _ChildApiService;


  // Para obtener varios usuarios usar un query param con el número de resutlados esperados: 
  // https://randomuser.me/api/?results=10
  @GET('/api')
  Future<List<Child>> getChildren({
    @Query('results') int results = 10,
  });


  
}