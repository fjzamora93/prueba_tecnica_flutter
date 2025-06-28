import 'dart:async';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/auth_usecase.dart';





// Riverpod 3
final authProvider =
    AsyncNotifierProvider<AuthNotifier, User?>(() => AuthNotifier());



class AuthNotifier extends AsyncNotifier<User?> {
  late final AuthUseCase _useCase;

  @override
  FutureOr<User?> build() {
    _useCase = ref.read(authUseCaseProvider);  
    return null; 
  }

  Future<void> login(String email, String pass) =>
      _guard(() => _useCase.login(email, pass));


  Future<void> me() =>
      _guard(_useCase.me);

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _useCase.logout();
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }


  Future<void> _guard(Future<User?> Function() cb) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(cb);          
  }

}
