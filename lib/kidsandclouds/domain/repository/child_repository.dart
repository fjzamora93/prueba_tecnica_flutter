import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';

abstract class ChildRepository {
  Future<List<Child>> getChildren({int results = 10});

  Future<Child> getChildById(String id);
}