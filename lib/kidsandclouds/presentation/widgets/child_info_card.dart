import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';

class ChildInfoCard extends StatelessWidget {
  final Child child;

  const ChildInfoCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      title: S.of(context).personalInfo,
      child: Column(
        children: [
       
          
          _buildInfoRow(
            context: context,
            icon: Icons.phone_outlined,
            label: S.of(context).telephone,
            value: child.phone,
            color: Colors.green,
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoRow(
            context: context,
            icon: child.gender.toLowerCase() == 'male' ? Icons.boy : Icons.girl,
            label: S.of(context).gender,
            value: child.gender.toLowerCase() == 'male' ? 'Niño' : 'Niña',
            color: child.gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
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
}
