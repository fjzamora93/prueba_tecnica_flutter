import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return DefaultCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con categoría y fecha
          Row(
            children: [
              // Icono de categoría
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getCategoryColor(event.category),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event.categoryIcon,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 12),
              
              // Información de categoría y fecha
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.category.displayName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getCategoryColor(event.category),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event.date,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Título del evento
          if (event.hasTitle) ...[
            Text(
              event.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Descripción del evento
          Text(
            event.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(EventCategory category) {
    switch (category) {
      case EventCategory.alimentacion:
        return const Color(0xFF4CAF50); // Verde
      case EventCategory.siestas:
        return const Color(0xFF9C27B0); // Morado
      case EventCategory.actividades:
        return const Color(0xFFFF9800); // Naranja
      case EventCategory.deposiciones:
        return const Color(0xFF795548); // Marrón
      case EventCategory.observaciones:
        return const Color(0xFF2196F3); // Azul
      case EventCategory.salud:
        return const Color(0xFFF44336); // Rojo
    }
  }
}
