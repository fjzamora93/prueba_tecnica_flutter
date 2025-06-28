import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
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
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
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
                padding: EdgeInsets.all(ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
                decoration: BoxDecoration(
                  color: _getCategoryColor(event.category),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event.categoryIcon,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0)),
              
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
                        fontSize: isDesktop ? 14 : null,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 2.0, desktop: 4.0)),
                    Text(
                      event.date,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 13.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0)),
          
          // Título del evento
          if (event.hasTitle) ...[
            Text(
              event.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
              ),
            ),
            SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
          ],
          
          // Descripción del evento
          Text(
            event.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
              fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 15.0),
            ),
            maxLines: ResponsiveHelper.responsiveValue(context, mobile: 3, desktop: 4),
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
