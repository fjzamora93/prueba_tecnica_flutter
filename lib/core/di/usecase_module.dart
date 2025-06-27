
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/repository_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/auth_usecase.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/child_usecase.dart';

final childUseCaseProvider = Provider((ref) {
  final childRepository = ref.watch(childRepositoryProvider);
  return ChildUsecase(childRepository);
});

final authUseCaseProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthUseCase(repo);
});
