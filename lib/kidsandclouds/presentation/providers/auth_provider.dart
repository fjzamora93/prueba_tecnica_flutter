import 'dart:async';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/auth_usecase.dart';





// Riverpod 3
final authProvider =
    AsyncNotifierProvider<AuthNotifier, LoginResponse?>(() => AuthNotifier());



class AuthNotifier extends AsyncNotifier<LoginResponse?> {
  late final AuthUseCase _useCase;

  @override
  FutureOr<LoginResponse?> build() {
    _useCase = ref.read(authUseCaseProvider);  
    return null; 
  }

  Future<void> login(String email, String pass) =>
      _guard(() => _useCase.login(email, pass));


  // Future<void> me() =>
  //     _guard(_useCase.me);




  Future<void> _guard(Future<LoginResponse?> Function() cb) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(cb);          
  }

}
