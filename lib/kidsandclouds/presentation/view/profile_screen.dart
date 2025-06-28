
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/widgets/menu_card.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/profile_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/language_selection_dialog.dart';

class ProfileScreen  extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider); 

    
    return authState.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(child: Text('Error: $e')),

      data: (user) {
        // Si no hay sesión
        if (user == null) {
          return const Center(child: Text('No hay usuario logueado'));
        }

        return PrimaryScaffold(
          backgroundColor: AppColors.backgroundPrimary,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                children: [
                  Text(
                    S.of(context).profile,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    )),
                  const SizedBox(width: 8),
                  const Icon(Icons.person, size: 28, color: AppColors.circle,),
                  Spacer(),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          children: [
            const SizedBox(height: 20),
            /*────────  CARTA CON DATOS  ────────*/
            ProfileCard(user: user, onTap: () {}),

            const SizedBox(height: 16),
            Text('Configuración', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset('assets/icons/icon-settings.png', width: 30, height: 30),
              label: S.of(context).language,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const LanguageSelectionDialog(),
                );
              },
            ),

            const SizedBox(height: 24),
            Text('Actividad', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset('assets/icons/icon-fecha.png', width: 30, height: 30),
              label: S.of(context).diary,
              onTap: () => context.push(AppRoutes.dailyJournal),
            ),
            MenuCard(
              icon: Image.asset('assets/icons/icon-boxmail.png', width: 30, height: 30),
              label: S.of(context).childrenList,
              onTap: () => context.push(AppRoutes.childrenList),
            ),
            const SizedBox(height: 24),

            Text('Generales', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset('assets/icons/icon-logout.png', width: 30, height: 30),
              label: 'Cerrar sesión',
              onTap: () async {
                context.go(AppRoutes.login);
                await ref.read(authProvider.notifier).logout();
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Prueba Técnica versión 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}