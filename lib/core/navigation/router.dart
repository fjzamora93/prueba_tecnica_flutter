

import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/pages/child_detail.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/pages/home_screen.dart';

GoRouter appRouter() => GoRouter(
  initialLocation: AppRoutes.root,  
  
  routes: [
    // AUTENTIFICACIÓN Y HOME
    GoRoute(
      path: AppRoutes.root,
      redirect: (_, __) => AppRoutes.login,
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomeScreen(),
    ),
 
    GoRoute(
      path: '${AppRoutes.childDetail}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChildDetailScreen(childId: id);
      },
    ),
  ]
);
    