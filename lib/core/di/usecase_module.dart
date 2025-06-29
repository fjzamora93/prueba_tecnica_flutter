
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/repository_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/auth_usecase.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/child_usecase.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/usecase/event_usecase.dart';

final childUseCaseProvider = Provider((ref) {
  final childRepository = ref.watch(childRepositoryProvider);
  return ChildUsecase(childRepository);
});

final authUseCaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthUseCase(authRepository);
});


final eventUseCaseProvider = Provider((ref) {
  final eventRepository = ref.watch(eventRepositoryProvider);
  return EventUsecase(eventRepository);
});