
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/children_list_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/image_thumbnail.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_card.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String childId;
  const ChildDetailScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreen();
}


class _ChildDetailScreen extends ConsumerState<ChildDetailScreen> {
  Child? childDetail;
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      childDetail = await ref.read(childrenListProvider.notifier).getChildById(widget.childId);
      
      if (childDetail != null) {
        ref.read(childDetailProvider.notifier).setChild(childDetail!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).error)),
        );
      }
      
      // Cargar eventos
      ref.read(eventProvider.notifier).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childDetailProvider);
    final eventsState = ref.watch(eventProvider);

    return PrimaryScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(S.of(context).childDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      children: [
        // Datos del niño
        childDetail != null 
          ? _buildChildDetail(childDetail!, eventsState)
          : childState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  S.of(context).error,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              data: (child) => _buildChildDetail(child, eventsState),
            ),
      ],
    );
  }

  Widget _buildChildDetail(Child child, AsyncValue<List<Event>> eventsState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Header del niño
        _buildChildHeader(child),
        
        const SizedBox(height: 24),
        
        // Información del niño
        _buildChildInfo(child),
        
        const SizedBox(height: 32),
        
        // Sección de eventos
        _buildEventsSection(eventsState),
      ],
    );
  }

  Widget _buildChildHeader(Child child) {
    return Center(
      child: Column(
        children: [
          // Avatar del niño
          Stack(
            children: [
              ImageThumbnail(
                imageUrl: child.picture.large, 
                size: 120,
                isCircular: true,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: child.gender.toLowerCase() == 'male' 
                        ? Colors.blue 
                        : Colors.pink,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Icon(
                    child.gender.toLowerCase() == 'male' 
                        ? Icons.boy 
                        : Icons.girl,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Nombre del niño
          Text(
            '${child.name['first']} ${child.name['last']}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),
          
          // Edad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cake_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${child.age} años',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildInfo(Child child) {
    return DefaultCard(
      title: 'Información Personal',
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: child.email,
            color: Colors.blue,
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Teléfono',
            value: child.phone,
            color: Colors.green,
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoRow(
            icon: child.gender.toLowerCase() == 'male' ? Icons.boy : Icons.girl,
            label: 'Género',
            value: child.gender.toLowerCase() == 'male' ? 'Niño' : 'Niña',
            color: child.gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        
        const SizedBox(width: 12),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventsSection(AsyncValue<List<Event>> eventsState) {
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