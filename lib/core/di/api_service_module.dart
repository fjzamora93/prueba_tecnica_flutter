
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/general_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/service/child_api_service.dart';

final childApiServiceProvider = Provider<ChildApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ChildApiService(dio);
});