// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: json['id'] as String,
  category: Event._categoryFromJson(json['category'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
  date: json['date'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': instance.id,
  'category': Event._categoryToJson(instance.category),
  'title': instance.title,
  'description': instance.description,
  'date': instance.date,
  'userId': instance.userId,
};
