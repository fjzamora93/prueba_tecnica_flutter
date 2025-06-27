
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';

class DailyJournalScreen extends ConsumerStatefulWidget {
  const DailyJournalScreen({super.key});

  @override
  ConsumerState<DailyJournalScreen> createState() => _DailyJournalScreen();
}

class _DailyJournalScreen extends ConsumerState<DailyJournalScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: AppBar(
        title:  Text(S.of(context).appTitle),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: AppColors.white,
      ),
      children: [
            Text(
              S.of(context).welcome,
              style: AppTextStyles.heading2
            ),

            SizedBox(height: 16),

            Text(
              'Texto de la sección de muestra.',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 32),

      
            PrimaryButton(
              onPressed: () async {
  
                  },
              ),
          ],
       

    );
  }
}