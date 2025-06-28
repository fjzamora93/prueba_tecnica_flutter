
import 'package:pruebakidsandclouds/kidsandclouds/data/models/login_response.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;


  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,

  });

  static User fromLoginResponse(LoginResponse loginResponse) {
    return User(
      id: loginResponse.id,
      username: loginResponse.username,
      email: loginResponse.email,
      firstName: loginResponse.firstName,
      lastName: loginResponse.lastName,
      gender: loginResponse.gender,
      image: loginResponse.image,

    );
  }


}