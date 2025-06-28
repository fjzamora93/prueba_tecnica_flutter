
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
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
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
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
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 32.0)),
        
        // Lista de eventos
        eventsState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => _buildErrorState(context),
          data: (events) => _buildEventsList(context, events),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: ResponsiveHelper.responsiveValue(context, mobile: 64.0, desktop: 80.0),
            color: AppColors.error,
          ),
          SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
          Text(
            'Error al cargar eventos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
          ElevatedButton(
            onPressed: () {
              ref.read(eventProvider.notifier).fetchEvents();
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(BuildContext context, List events) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final gridColumns = ResponsiveHelper.getGridColumns(context);
    
    if (isDesktop && events.length > 1) {
      // Desktop: Use a grid layout for better space utilization
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridColumns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3.5,
        ),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCard(
            event: event,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Evento: ${event.displayTitle}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
      );
    } else {
      // Mobile: Use a column layout
      return Column(
        children: events.map<Widget>((event) => 
          Padding(
            padding: EdgeInsets.only(
              bottom: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
            ),
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
    }
  }
}