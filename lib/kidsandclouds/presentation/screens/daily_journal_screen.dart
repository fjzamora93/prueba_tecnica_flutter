
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/error_state_widget.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/category_selector.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_list.dart';

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
          loading: () => CustomLoadingIndicator(),
          error: (error, stackTrace) => ErrorStateWidget(
            errorMessage:  S.of(context).error,
            onRetry: () => ref.read(eventProvider.notifier).fetchEvents(),
            height: 200, 
          ),
          data: (events) => _buildEventsList(context, events),
        ),
      ],
    );
  }


  Widget _buildEventsList(BuildContext context, List events) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final gridColumns = ResponsiveHelper.getGridColumns(context);
    
    if (isDesktop && events.length > 1) {

      // Desktop: Usamos un Grid Layout
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridColumns,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
          mainAxisExtent: 200,
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

    // Mobile: Usamos una columna y ya (esto es consecuencia del  Mobile first)
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             EventList(eventsState: ref.watch(eventProvider)),
          ],
        );
    
    }
  }
}