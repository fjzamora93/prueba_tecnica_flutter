
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_name.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/image_thumbnail.dart';

class ChildSummaryCard extends StatelessWidget {
  final Child child;
  final VoidCallback? onTap;
  final bool summarize;

  const ChildSummaryCard({
    super.key,
    required this.child,
    this.onTap,
    this.summarize = false,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data para simular información del niño
    final int todayActivities = Random().nextInt(8) + 3; 
    final int weeklyEvents = Random().nextInt(25) + 15; 
    final String lastActivity = _getRandomActivity();
    final String mood = _getRandomMood();
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.responsiveValue(context, mobile: 10.0, desktop: 12.0),
        horizontal: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 12.0),
      ),
      child: DefaultCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0)),

            // Información principal del niño
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar del niño
                Column(
                  children: [
                    ImageThumbnail(
                      imageUrl: child.picture.thumbnail,
                      size: ResponsiveHelper.responsiveValue(context, mobile: 60.0, desktop: 80.0),
                      isCircular: true,
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
                    // Estado de ánimo
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.responsiveValue(context, mobile: 6.0, desktop: 8.0),
                        vertical: ResponsiveHelper.responsiveValue(context, mobile: 2.0, desktop: 4.0),
                      ),
                      decoration: BoxDecoration(
                        color: _getMoodColor(mood).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        mood,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getMoodColor(mood),
                          fontSize: ResponsiveHelper.responsiveValue(context, mobile: 10.0, desktop: 11.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
                
                // Información del niño
                Expanded(
                  child: _buildChildInfo(context, isDesktop, todayActivities, weeklyEvents, lastActivity),
                ),
              ],
            ),
            
            if (summarize) ...[
              SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
              _buildSummarySection(context, isDesktop, todayActivities, weeklyEvents, lastActivity),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChildInfo(BuildContext context, bool isDesktop, int todayActivities, int weeklyEvents, String lastActivity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nombre del niño
        ChildName(
          firstName: child.firstName,
          lastName: child.lastName,
          title: "",
        ),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 10.0)),
        
        // Edad
        Row(
          children: [
            Icon(
              Icons.cake_outlined,
              size: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
              color: AppColors.textSecondary,
            ),
            SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 4.0, desktop: 6.0)),
            Text(
              '${child.age} años',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
              ),
            ),
          ],
        ),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 4.0, desktop: 6.0)),
        
        // Última actividad
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
              color: AppColors.textSecondary,
            ),
            SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 4.0, desktop: 6.0)),
            Expanded(
              child: Text(
                'Última: $lastActivity',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
                ),
                overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Estadísticas resumidas
            if (!summarize) ...[
              const SizedBox(height: 16),
              const Divider(height: 24, thickness: 1, color: AppColors.lightGrey),
              
              Row(
                children: [
                  // Actividades de hoy
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Icons.today_outlined,
                      label: 'Hoy',
                      value: '$todayActivities',
                      subtitle: 'actividades',
                      color: AppColors.primary,
                    ),
                  ),
                  
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.lightGrey,
                  ),
                  
                  // Eventos esta semana
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Icons.calendar_month_outlined,
                      label: 'Semana',
                      value: '$weeklyEvents',
                      subtitle: 'eventos',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  String _getRandomActivity() {
    final activities = [
      'Almuerzo',
      'Siesta',
      'Juegos',
      'Lectura',
      'Pintura',
      'Música',
      'Ejercicio',
      'Merienda',
    ];
    return activities[Random().nextInt(activities.length)];
  }

  String _getRandomMood() {
    final moods = ['😊 Feliz', '😌 Tranquilo', '😴 Cansado', '🤗 Cariñoso', '😆 Juguetón'];
    return moods[Random().nextInt(moods.length)];
  }

  Color _getMoodColor(String mood) {
    if (mood.contains('Feliz') || mood.contains('Juguetón')) return Colors.orange;
    if (mood.contains('Tranquilo') || mood.contains('Cariñoso')) return Colors.green;
    if (mood.contains('Cansado')) return Colors.blue;
    return AppColors.primary;
  }
}
