

import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/child_detail_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/children_list_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/daily_journal_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/home_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/login_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/profile_screen.dart';

GoRouter appRouter() => GoRouter(
  initialLocation: AppRoutes.login,
  errorBuilder: (context, state) {
    // Manejo de errores de navegación
    return LoginScreen(); // Redirigir a login si hay error
  },
  
  routes: [
    // AUTENTIFICACIÓN Y HOME
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.childrenList,
      builder: (_, __) => const ChildrenListScreen(),
    ),
    GoRoute(
      path: AppRoutes.dailyJournal,
      builder: (_, __) => const DailyJournalScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (_, __) => const ProfileScreen(),
    ),

    GoRoute(
      path: '${AppRoutes.childDetail}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        if (id == null || id.isEmpty) {
          // Si no hay ID válido, redirigir a la lista de niños
          return const ChildrenListScreen();
        }
        return ChildDetailScreen(childId: id);
      },
    ),
  ]
);
    