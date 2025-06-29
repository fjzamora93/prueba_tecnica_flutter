
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';

abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}