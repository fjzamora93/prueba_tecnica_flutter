// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
  gender: json['gender'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  cell: json['cell'] as String,
  nat: json['nat'] as String,
  name: json['name'] as Map<String, dynamic>,
  location: json['location'] as Map<String, dynamic>,
  login: json['login'] as Map<String, dynamic>,
  dob: json['dob'] as Map<String, dynamic>,
  id: json['id'] as Map<String, dynamic>,
  picture: Picture.fromJson(json['picture'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
  'gender': instance.gender,
  'email': instance.email,
  'phone': instance.phone,
  'cell': instance.cell,
  'nat': instance.nat,
  'name': instance.name,
  'location': instance.location,
  'login': instance.login,
  'dob': instance.dob,
  'id': instance.id,
  'picture': instance.picture.toJson(),
};
