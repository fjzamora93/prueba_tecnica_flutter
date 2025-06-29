
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<User> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<User> me() {
    return repository.me();
  }

  Future<void> logout() {
    return repository.logout();
  }


}
