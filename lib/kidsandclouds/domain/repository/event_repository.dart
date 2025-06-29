import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';

abstract class EventRepository {
  /// Obtiene todos los eventos
  Future<List<Event>> getEvents();

  /// Obtiene eventos filtrados por categoría
  Future<List<Event>> getFilteredEvents(String category);
}