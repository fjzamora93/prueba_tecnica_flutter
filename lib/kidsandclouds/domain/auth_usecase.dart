
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<LoginResponse> login(String email, String password) {
    return repository.login(email, password);
  }



}
