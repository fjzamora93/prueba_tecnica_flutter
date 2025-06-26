import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart'; 

@JsonSerializable()
class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  const Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  // ✅ AGREGAR ESTOS MÉTODOS
  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}