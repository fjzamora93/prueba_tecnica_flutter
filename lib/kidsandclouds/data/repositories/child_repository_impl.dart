

import 'package:pruebakidsandclouds/core/helper/log_helper.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/child_api_service.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/repository/child_repository.dart';

class ChildRepositoryImpl implements ChildRepository {
  final ChildApiService _apiService;
  ChildRepositoryImpl(this._apiService);


  // GET ALL CHILDREN
  Future<List<Child>> getChildren({int results = 10}) async {
      try {
        final response = await _apiService.getChildren(results: results);
        final List<Child> childrenList = response.results;
        return childrenList;
      } catch (e) {
        Log.e('Error fetching children: $e');
        throw Exception('Failed to fetch children $e');
      }
  }

  Future<Child> getChildById(String id) async {
    try {
      final response = await _apiService.getChildById(id);
      return response;
    } catch (e) {
      Log.e('Error fetching child by ID: $e');
      throw Exception('Failed to fetch child by ID');
    }
  }
  
}
