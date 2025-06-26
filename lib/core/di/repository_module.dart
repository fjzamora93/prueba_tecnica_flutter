

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/api_service_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/child_repository.dart';

final childRepositoryProvider = Provider((ref) {
  final api = ref.watch(childApiServiceProvider);
  return ChildRepository(api);
});