// Almacenamiento del token en secure shared preferences
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/kidsandclouds/security/auth_interceptor.dart';
import 'package:pruebakidsandclouds/kidsandclouds/security/token_storage.dart';

final tokenStorageProvider = Provider((ref) => TokenStorage());


// Interceptor que añade los headers y la url base a cada petición
final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return createDio(tokenStorage);
});