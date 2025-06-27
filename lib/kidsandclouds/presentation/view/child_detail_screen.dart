
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String childId;
  const ChildDetailScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreen();
}

class _ChildDetailScreen extends ConsumerState<ChildDetailScreen> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(childDetailProvider.notifier).getChildById(widget.childId);
    });
  }
  


  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childDetailProvider);

    return PrimaryScaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: AppColors.white,
      ),
      children: [
        childState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text(S.of(context).error),
          ),
          data: (child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).welcome,
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 16),
              const Text(
                'Texto de la sección de muestra.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                onPressed: () async {
                  // Tu lógica aquí
                },
              ),
            ],
          ),
          
        ),
      ],
    );
  }

   
}