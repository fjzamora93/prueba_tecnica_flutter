
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/category_selector.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_card.dart';

class DailyJournalScreen extends ConsumerStatefulWidget {
  const DailyJournalScreen({super.key});

  @override
  ConsumerState<DailyJournalScreen> createState() => _DailyJournalScreen();
}

class _DailyJournalScreen extends ConsumerState<DailyJournalScreen> {
  
  @override
  void initState() {
    super.initState();
    // Cargar eventos al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventProvider.notifier).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(eventProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return PrimaryScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(S.of(context).diary),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      children: [
        const SizedBox(height: 16),
        
        // Selector horizontal de categorías
        CategorySelector(
          categories: EventCategory.allCategories,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            // Actualizar categoría seleccionada
            ref.read(selectedCategoryProvider.notifier).state = category;
            ref.read(eventProvider.notifier).getFilteredEvents(category.value);
          },
          onShowAll: () {
            ref.read(selectedCategoryProvider.notifier).state = null;
            ref.read(eventProvider.notifier).fetchEvents();
          },
        ),
        
        const SizedBox(height: 20),
        
        // Lista de eventos
        eventsState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error al cargar eventos',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(eventProvider.notifier).fetchEvents();
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
          data: (events) {
            return Column(
              children: events.map((event) => 
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
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
}