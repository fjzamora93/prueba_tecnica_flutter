

import 'package:pruebakidsandclouds/core/helper/log_helper.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/child_api_service.dart';

class ChildRepository {
  final ChildApiService _apiService;
  ChildRepository(this._apiService);


  // GET ALL CHILDREN
  Future<List<Child>> getChildren({int results = 10}) async {
      try {
        final response = await _apiService.getChildren(results: results);
        return response;
      } catch (e) {
        Log.e('Error fetching children: $e');
        return []; 
      }
  }
  
}
