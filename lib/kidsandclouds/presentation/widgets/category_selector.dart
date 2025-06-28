import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';

class CategoryChip extends StatelessWidget {
  final EventCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getCategoryIcon(category),
              color: isSelected ? AppColors.white : AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              category.displayName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(EventCategory category) {
    switch (category) {
      case EventCategory.alimentacion:
        return Icons.restaurant; // Comida
      case EventCategory.siestas:
        return Icons.bedtime; // Dormir
      case EventCategory.actividades:
        return Icons.sports_esports; // Actividades/Juegos
      case EventCategory.deposiciones:
        return Icons.wc; // Baño
      case EventCategory.observaciones:
        return Icons.visibility; // Observar
      case EventCategory.salud:
        return Icons.health_and_safety; // Salud
    }
  }
}

class CategorySelector extends StatelessWidget {
  final List<EventCategory> categories;
  final EventCategory? selectedCategory;
  final Function(EventCategory) onCategorySelected;
  final Function()? onShowAll;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
    this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Botón "Todos" (opcional)
          if (onShowAll != null)
            GestureDetector(
              onTap: onShowAll,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: selectedCategory == null ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedCategory == null ? AppColors.primary : AppColors.lightGrey,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.apps,
                      color: selectedCategory == null ? AppColors.white : AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Todos',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: selectedCategory == null ? AppColors.white : AppColors.textPrimary,
                        fontWeight: selectedCategory == null ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          // Categorías
          ...categories.map((category) => CategoryChip(
            category: category,
            isSelected: selectedCategory == category,
            onTap: () => onCategorySelected(category),
          )).toList(),
        ],
      ),
    );
  }
}
