
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> me();
  Future<void> logout();
}