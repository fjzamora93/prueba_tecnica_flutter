
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // La línea separadora arriba
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.withOpacity(0.3), // Ajusta el color si quieres
        ),
        // La barra de navegación
        BottomNavigationBar(
          currentIndex: _getCurrentIndex(context),
          elevation: 0, // Le quitamos la sombra extra
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          iconSize: 32,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: S.of(context).diary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: S.of(context).list,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: S.of(context).profile,
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
          unselectedItemColor: AppColors.borderFilled.withOpacity(0.6),
        ),
      ],
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
