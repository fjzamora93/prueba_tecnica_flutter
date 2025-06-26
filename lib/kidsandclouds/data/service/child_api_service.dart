import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/core/helper/constants.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'child_api_service.g.dart';

@RestApi(baseUrl: AppConstants.childMockUrl)
abstract class ChildApiService {
  factory ChildApiService(Dio dio, {String baseUrl}) = _ChildApiService;

  // Corregido: La API devuelve un objeto con "results", no directamente una lista
  @GET('/api')
  Future<List<Child>> getChildren({
    @Query('results') int results = 10,
  });
}

