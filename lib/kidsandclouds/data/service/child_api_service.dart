import 'package:dio/dio.dart';
import 'package:pruebakidsandclouds/core/helper/constants.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/children_response.dart';
import 'package:retrofit/retrofit.dart';

part 'child_api_service.g.dart';

@RestApi(baseUrl: AppConstants.childMockUrl)
abstract class ChildApiService {
  factory ChildApiService(Dio dio, {String baseUrl}) = _ChildApiService;

 
  @GET('/api')
  Future<ChildrenResponse> getChildren({
    @Query('results') int results = 10,
  });

  @GET('/api/{id}')
  Future<Child> getChildById(@Path('id') String id);
}

