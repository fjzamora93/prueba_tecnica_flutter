
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: AppBar(
        title:  Text(S.of(context).profile),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      children: [
       

            SizedBox(height: 16),

            Text(
              'Texto de la sección de muestra.',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 32),

      
            PrimaryButton(
              text: S.of(context).logout,
              color: AppColors.primary,
              onPressed: () async {
  
                  },
              ),
          ],
       

    );
  }
}