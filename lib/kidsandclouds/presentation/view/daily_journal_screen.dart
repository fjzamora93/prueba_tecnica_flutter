
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
        title:  Text(S.of(context).diary),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      children: [
           

            SizedBox(height: 16),

            Text(
              'Menú horizontal de categorías (scrollable).',
              style: TextStyle(fontSize: 16),
            ),

             Text(
              'Alimentación, Siestas, Actividades, Deposiciones, Observaciones…',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              'Al seleccionar una categoría, mostrar solo los eventos correspondientes',
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