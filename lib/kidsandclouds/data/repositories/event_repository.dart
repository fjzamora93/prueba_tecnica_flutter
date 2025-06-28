
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';

class EventRepository {
  static const String _eventsPath = 'assets/data/events.json';

  // Método privado para cargar todos los eventos
  Future<List<Event>> _loadAllEvents() async {
    try {
      final content = await rootBundle.loadString(_eventsPath);
      final List<dynamic> jsonList = json.decode(content) as List<dynamic>;
      return jsonList.map((json) => Event.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error al cargar eventos: $e'); 
    }
  }

  // Obtener todos los eventos
  Future<List<Event>> getEvents() async {
    return await _loadAllEvents();
  }

  // Filtrar por categoría (String) - Mantener compatibilidad
  Future<List<Event>> getFilteredEvents(String category) async {
    final allEvents = await _loadAllEvents();
    final categoryEnum = EventCategory.fromString(category);
    return allEvents.where((event) => event.category == categoryEnum).toList();
  }

  // Filtrar por categoría (Enum) - Más seguro
  Future<List<Event>> getEventsByCategory(EventCategory category) async {
    final allEvents = await _loadAllEvents();
    return allEvents.where((event) => event.category == category).toList();
  }

  // Filtrar por usuario
  Future<List<Event>> getEventsByUser(String userId) async {
    final allEvents = await _loadAllEvents();
    return allEvents.where((event) => event.userId == userId).toList();
  }

  // Filtrar por usuario y categoría
  Future<List<Event>> getEventsByUserAndCategory(String userId, EventCategory category) async {
    final allEvents = await _loadAllEvents();
    return allEvents.where((event) => 
      event.userId == userId && event.category == category
    ).toList();
  }

  // Obtener categorías únicas de los eventos
  Future<List<EventCategory>> getAvailableCategories() async {
    final allEvents = await _loadAllEvents();
    final categories = allEvents.map((event) => event.category).toSet().toList();
    return categories;
  }
}