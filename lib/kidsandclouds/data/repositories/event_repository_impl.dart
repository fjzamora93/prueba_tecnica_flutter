
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/repository/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  static const String _eventsPath = 'assets/data/events.json';

  Future<List<Event>> _loadAllEvents() async {
    try {
      final content = await rootBundle.loadString(_eventsPath);
      final List<dynamic> jsonList = json.decode(content) as List<dynamic>;
      return jsonList.map((json) => Event.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error al cargar eventos: $e'); 
    }
  }

  Future<List<Event>> getEvents() async {
    return await _loadAllEvents();
  }

  Future<List<Event>> getFilteredEvents(String category) async {
    final allEvents = await _loadAllEvents();
    final categoryEnum = EventCategory.fromString(category);
    return allEvents.where((event) => event.category == categoryEnum).toList();
  }

}