
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
    this.gender = '',
    this.email = '',
    this.phone = '',
    this.cell = '',
    this.nat = '',
    this.name = const {},
    this.location = const {},
    this.login = const {},
    this.dob = const {},
    this.id = const {},
    this.picture = const Picture(large: '', medium: '', thumbnail: ''),
  });

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);

  // Constructor vacío para inicializar con valores por defecto
  static Child empty() => const Child();
  
  // Métodos helper para acceder a datos anidados fácilmente
  String get firstName => name['first'] ?? '';
  String get lastName => name['last'] ?? '';
  String get fullName => '$firstName $lastName';
}



