
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Publicar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
        
      ],
      onTap: (i) {
        switch (i) {
          case 0:
            context.push(AppRoutes.childDetail);
            break;
          case 1:
            context.push(AppRoutes.childrenList);
            break;
          case 2:
            context.push(AppRoutes.profile);
            break;
       
        }
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.borderFilled,
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/search')) return 0;
    if (location.startsWith('/publish')) return 1;
    if (location.startsWith('/profile')) return 2;

    return 0; // valor por defecto
  }

}