
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/network_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/auth_api_service.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/child_api_service.dart';

final childApiServiceProvider = Provider<ChildApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ChildApiService(dio);
});

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiService(dio);
});

