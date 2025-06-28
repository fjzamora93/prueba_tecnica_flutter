import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class MenuCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const MenuCard({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: icon,
        ),
        title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        trailing: const Icon(Icons.arrow_forward_rounded, color: AppColors.borderFocused),
        onTap: onTap,
      ),
    );
  }
}

