// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildrenResponse _$ChildrenResponseFromJson(Map<String, dynamic> json) =>
    ChildrenResponse(
      results:
          (json['results'] as List<dynamic>)
              .map((e) => Child.fromJson(e as Map<String, dynamic>))
              .toList(),
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChildrenResponseToJson(ChildrenResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'info': instance.info.toJson(),
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
  seed: json['seed'] as String,
  results: (json['results'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  version: json['version'] as String,
);

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
  'seed': instance.seed,
  'results': instance.results,
  'page': instance.page,
  'version': instance.version,
};
