
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/error_state_widget.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';

import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/settings.dart';

class ProfileScreen  extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider); 

    
    return authState.when(
      loading: () => CustomLoadingIndicator(),

      error: (e, _) => ErrorStateWidget(
            errorMessage: S.of(context).error,
            onRetry: () => context.go(AppRoutes.login),
            height: 200, 
          ),

      data: (user) {

        // Si no hay sesión
        if (user == null) {
          context.go(AppRoutes.login);
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

          children: [
            SettingsContent(),
          ],
        );
      },
    );
  }
}