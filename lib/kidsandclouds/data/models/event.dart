import 'package:json_annotation/json_annotation.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String id;
  
  @JsonKey(name: 'category', fromJson: _categoryFromJson, toJson: _categoryToJson)
  final EventCategory category;
  
  final String title;
  final String description;
  final String date;
  final String userId;

  const Event({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
  });


  static EventCategory _categoryFromJson(String category) => EventCategory.fromString(category);
  static String _categoryToJson(EventCategory category) => category.value;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  bool get hasTitle => title.isNotEmpty;
  String get displayTitle => hasTitle ? title : category.displayName;
  String get categoryIcon => category.icon;
  String get categoryColor => category.colorHex;

  bool belongsToUser(String userId) => this.userId == userId;

  Event copyWith({
    String? id,
    EventCategory? category,
    String? title,
    String? description,
    String? date,
    String? userId,
  }) {
    return Event(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, category: ${category.value}, title: $title, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}