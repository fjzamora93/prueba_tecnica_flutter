import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/di/usecase_module.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';
import 'package:pruebakidsandclouds/kidsandclouds/domain/event_usecase.dart';

final eventProvider = AsyncNotifierProvider<EventNotifier, List<Event>>(
  EventNotifier.new,
);

// Provider para la categoría seleccionada
final selectedCategoryProvider = StateProvider<EventCategory?>((ref) => null);

class EventNotifier extends AsyncNotifier<List<Event>> {

  late final EventUsecase _useCase;

  @override
  Future<List<Event>> build() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    _useCase = ref.read(eventUseCaseProvider);    
    return await _useCase.getEvents();
  }

  Future<void> fetchEvents() async {
    state = const AsyncValue.loading();
    try {
      final events = await _useCase.getEvents();
      await Future.delayed(const Duration(seconds: 1));
      state = AsyncValue.data(events);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }


  Future<void> getFilteredEvents(String category) async {
    try{
      state = const AsyncValue.loading();
      await Future.delayed(const Duration(seconds: 1));
      final events = await _useCase.getFilteredEvents(category);
      state = AsyncValue.data(events);
    }catch(e){
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }
 

  }

    
}