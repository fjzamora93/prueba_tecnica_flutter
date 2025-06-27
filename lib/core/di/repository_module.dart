

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/api_service_module.dart';
import 'package:pruebakidsandclouds/core/di/general_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/child_repository.dart';

final childRepositoryProvider = Provider((ref) {
  final api = ref.watch(childApiServiceProvider);
  return ChildRepository(api);
});

final authRepositoryProvider = Provider((ref) {
  final api = ref.read(authApiServiceProvider);
  final storage = ref.read(tokenStorageProvider);
  return AuthRepository(api, storage);
});
