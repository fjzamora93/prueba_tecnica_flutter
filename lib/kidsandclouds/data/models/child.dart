
import 'package:json_annotation/json_annotation.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/picture.dart';

part 'child.g.dart';

@JsonSerializable()
class Child {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  
  // Campos anidados como Map para no crear clases adicionales... aunque idealmente habría que crearlos
  final Map<String, dynamic> name;
  final Map<String, dynamic> location;
  final Map<String, dynamic> login;
  final Map<String, dynamic> dob;
  final Map<String, dynamic> id;
  final Picture picture;

  const Child({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.location,
    required this.login,
    required this.dob,
    required this.id,
    required this.picture,
  });

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);
  
  // Métodos helper para acceder a datos anidados fácilmente
  String get firstName => name['first'] ?? '';
  String get lastName => name['last'] ?? '';
  String get fullName => '$firstName $lastName';
}



