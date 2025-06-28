import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/event_repository.dart';

class EventUsecase {
  final EventRepository repository;

  EventUsecase(this.repository);
  
  Future<List<Event>> getEvents() async {
    return await repository.getEvents();
  }

  Future<List<Event>> getFilteredEvents(String category) async {
    return await repository.getFilteredEvents(category);
  }

}