
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/menu_card.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
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
              padding: EdgeInsets.only(
                top: ResponsiveHelper.responsiveValue(context, mobile: 25.0, desktop: 20.0),
              ),
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
                  const Spacer(),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          children: ResponsiveHelper.isDesktop(context) 
              ? _buildDesktopLayout(context, user, ref)
              : _buildMobileLayout(context, user, ref),
        );
      },
    );
  }

  List<Widget> _buildMobileLayout(BuildContext context, user, WidgetRef ref) {
    return [
      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 30.0)),
      
      // Profile Card
      ProfileCard(user: user, onTap: () {}),

      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
      
      // Configuration section
      _buildSection(context, 'Configuración', [
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
      ]),

      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
      
      // Activity section
      _buildSection(context, 'Actividad', [
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
      ]),

      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),

      // General section
      _buildSection(context, 'Generales', [
        MenuCard(
          icon: Image.asset('assets/icons/icon-logout.png', width: 30, height: 30),
          label: 'Cerrar sesión',
          onTap: () async {
            context.go(AppRoutes.login);
            await ref.read(authProvider.notifier).logout();
          },
        ),
      ]),

      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
      
      _buildVersionInfo(),
      
      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
    ];
  }

  List<Widget> _buildDesktopLayout(BuildContext context, user, WidgetRef ref) {
    return [
      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 30.0)),
      
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Profile Card
          Expanded(
            flex: 1,
            child: ProfileCard(user: user, onTap: () {}),
          ),
          
          const SizedBox(width: 32),
          
          // Right side - Menu sections
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildSection(context, 'Configuración', [
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
                ]),

                const SizedBox(height: 24),
                
                _buildSection(context, 'Actividad', [
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
                ]),

                const SizedBox(height: 24),

                _buildSection(context, 'Generales', [
                  MenuCard(
                    icon: Image.asset('assets/icons/icon-logout.png', width: 30, height: 30),
                    label: 'Cerrar sesión',
                    onTap: () async {
                      context.go(AppRoutes.login);
                      await ref.read(authProvider.notifier).logout();
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
      
      const SizedBox(height: 32),
      _buildVersionInfo(),
      const SizedBox(height: 32),
    ];
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        )),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildVersionInfo() {
    return const Center(
      child: Column(
        children: [
          Text(
            'Prueba Técnica versión 1.0.0',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}