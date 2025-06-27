

import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/child_detail_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/children_list_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/daily_journal_screen.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/home_screen.dart';

GoRouter appRouter() => GoRouter(
  initialLocation: AppRoutes.home,  
  
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
      path: AppRoutes.childrenList,
      builder: (_, __) => const ChildrenListScreen(),
    ),
    GoRoute(
      path: AppRoutes.dailyJournal,
      builder: (_, __) => const DailyJournalScreen(),
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
    