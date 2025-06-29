import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_card.dart';

class EventList extends StatelessWidget {
  final AsyncValue<List<Event>> eventsState;

  const EventList({
    super.key,
    required this.eventsState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.event_note,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Eventos Recientes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Lista de eventos
        eventsState.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultCard(
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Error al cargar eventos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          data: (events) {
            if (events.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: DefaultCard(
                  child: Column(
                    children: [
                      Icon(
                        Icons.event_busy,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No hay eventos disponibles',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            // Seleccionar 3 eventos aleatorios
            final randomEvents = _getRandomEvents(events, 3);
            
            return Column(
              children: randomEvents.map((event) => 
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EventCard(
                    event: event,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Evento: ${event.displayTitle}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                )
              ).toList(),
            );
          },
        ),
      ],
    );
  }

  List<Event> _getRandomEvents(List<Event> events, int count) {
    if (events.length <= count) return events;
    
    final random = Random();
    final shuffled = List<Event>.from(events)..shuffle(random);
    return shuffled.take(count).toList();
  }
}
