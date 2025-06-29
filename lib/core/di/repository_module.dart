

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/api_service_module.dart';
import 'package:pruebakidsandclouds/core/di/network_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository_impl.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/child_repository_impl.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/event_repository_impl.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/repository/child_repository.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/repository/event_repository.dart';


// Declaramos que cada uno de los reposotires devuelve una instancia de su implementación correspondiente.

final childRepositoryProvider = Provider<ChildRepository>((ref) {
  final api = ref.watch(childApiServiceProvider);
  return ChildRepositoryImpl(api);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(authApiServiceProvider);
  final storage = ref.read(tokenStorageProvider);
  return AuthRepositoryImpl(api, storage);
});


final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl();
});

