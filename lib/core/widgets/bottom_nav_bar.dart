
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
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Diario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Niños',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
        
      ],
      onTap: (i) {
        switch (i) {
          case 0:
            context.go(AppRoutes.home);
            break;
          case 1:
            context.go(AppRoutes.dailyJournal);
            break;
          case 2:
            context.go(AppRoutes.childrenList);
            break;
          case 3:
            context.go(AppRoutes.profile);
            break;
       
        }
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.borderFilled,
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/daily-journal')) return 1;
    if (location.startsWith('/children')) return 2;
    if (location.startsWith('/profile')) return 3;

    return 0; 
  }

}