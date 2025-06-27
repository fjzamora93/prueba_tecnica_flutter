
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/default_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_name.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/numeric_data_row.dart';


class ChildSummaryCard extends StatelessWidget {
  final Child child;
  final VoidCallback? onTap;
  final bool summarize;

  const ChildSummaryCard({
    super.key,
    required this.child,
    this.onTap,
    this.summarize = false,
  });

  @override
  Widget build(BuildContext context) {  

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: DefaultCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información básica
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    child.gender,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset('assets/icons/icon-origen.png', width: 20, height: 20),
                   
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChildName(
                        firstName: child.firstName,
                        lastName: child.lastName,
                        title: child.title,
                      )
                    ],
                  ),
                ),
              ],
            ),

      
            
          // FILA INFERIOR: precio y asientos
          const SizedBox(width: 8),

          if (!summarize) const Divider(height: 24, thickness: 1, color: AppColors.lightGrey),
          const SizedBox(width: 8),

          if (!summarize)
            Row(
              children: [
                Expanded(
                  child: NumericDataRow(
                    age: child.age,
                    anotherData: Random().nextInt(5) + 1
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

}
