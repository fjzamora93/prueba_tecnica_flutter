import 'package:json_annotation/json_annotation.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';

part 'children_response.g.dart';

@JsonSerializable()
class ChildrenResponse {
  final List<Child> results;
  final Info info;

  const ChildrenResponse({
    required this.results,
    required this.info,
  });

  factory ChildrenResponse.fromJson(Map<String, dynamic> json) =>
      _$ChildrenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenResponseToJson(this);
}

@JsonSerializable()
class Info {
  final String seed;
  final int results;
  final int page;
  final String version;

  const Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}