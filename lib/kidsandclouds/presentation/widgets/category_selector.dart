import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
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
        margin: EdgeInsets.only(
          right: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0),
          vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0)),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
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
              size: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 22.0),
            ),
            SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
            Text(
              category.displayName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 15.0),
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
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return Container(
      height: ResponsiveHelper.responsiveValue(context, mobile: 50.0, desktop: 60.0),
      child: isDesktop ? _buildDesktopLayout(context) : _buildMobileLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0),
      ),
      children: _buildCategoryItems(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0),
      ),
      child: Row(
        children: _buildCategoryItems(context),
      ),
    );
  }

  List<Widget> _buildCategoryItems(BuildContext context) {
    List<Widget> items = [];
    
    // Botón "Todos" (opcional)
    if (onShowAll != null) {
      items.add(
        GestureDetector(
          onTap: onShowAll,
          child: Container(
            margin: EdgeInsets.only(
              right: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0),
              vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
            ),
            decoration: BoxDecoration(
              color: selectedCategory == null ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
              ),
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
                  size: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 22.0),
                ),
                SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
                Text(
                  'Todos',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selectedCategory == null ? AppColors.white : AppColors.textPrimary,
                    fontWeight: selectedCategory == null ? FontWeight.w600 : FontWeight.w500,
                    fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    // Categorías
    items.addAll(
      categories.map((category) => CategoryChip(
        category: category,
        isSelected: selectedCategory == category,
        onTap: () => onCategorySelected(category),
      )).toList(),
    );
    
    return items;
  }
}
