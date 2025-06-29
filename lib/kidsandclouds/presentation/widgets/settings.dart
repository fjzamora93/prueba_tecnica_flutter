import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_subtitle.dart';
import 'package:pruebakidsandclouds/core/widgets/menu_card.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/language_selection_dialog.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/profile_card.dart';
// Asegúrate de importar tus recursos de localización y rutas

class SettingsContent extends ConsumerWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(authProvider);

    return asyncUser.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Ocurrió un error: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (user) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /*────────  CARTA CON DATOS  ────────*/
            ProfileCard(user: user!, onTap: () {}),

            const SizedBox(height: 16),
            CustomSubtitle(S.of(context).configuration),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset(
                'assets/icons/icon-settings.png',
                width: 30,
                height: 30,
              ),
              label: S.of(context).language,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const LanguageSelectionDialog(),
                );
              },
            ),
            const SizedBox(height: 24),
            CustomSubtitle(S.of(context).activity),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset(
                'assets/icons/icon-fecha.png',
                width: 30,
                height: 30,
              ),
              label: S.of(context).diary,
              onTap: () => context.push(AppRoutes.dailyJournal),
            ),
            MenuCard(
              icon: Image.asset(
                'assets/icons/icon-boxmail.png',
                width: 30,
                height: 30,
              ),
              label: S.of(context).childrenList,
              onTap: () => context.push(AppRoutes.childrenList),
            ),
            const SizedBox(height: 24),
            CustomSubtitle(S.of(context).general),
            const SizedBox(height: 8),
            MenuCard(
              icon: Image.asset(
                'assets/icons/icon-logout.png',
                width: 30,
                height: 30,
              ),
              label: S.of(context).logout,
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
