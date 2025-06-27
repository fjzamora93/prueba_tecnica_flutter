
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/children_list_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/image_thumbnail.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String childId;
  const ChildDetailScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreen();
}


class _ChildDetailScreen extends ConsumerState<ChildDetailScreen> {
  Child? childDetail;
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      childDetail = await ref.read(childrenListProvider.notifier).getChildById(widget.childId);
      
      if (childDetail != null) {
        ref.read(childDetailProvider.notifier).setChild(childDetail!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).error)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childDetailProvider);

    return PrimaryScaffold(
      appBar: AppBar(
        title: Text(S.of(context).childDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      children: [
        // LLamamos a los datos locales
        childDetail != null 
          ? _buildChildDetail(childDetail!)
          : childState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(S.of(context).error),
              ),
              data: (child) => _buildChildDetail(child),
            ),
      ],
    );
  }

  Widget _buildChildDetail(Child child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // MOSTRAR DETALLES
        ImageThumbnail(
          imageUrl: child.picture.large, 
          size: 120,
          isCircular: true,
        ),
        const SizedBox(height: 16),
        Text(
          '${child.name['first']} ${child.name['last']}',
          style: AppTextStyles.heading1,
        ),
        const SizedBox(height: 8),
        Text(
          'Género: ${child.gender}',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 8),
        Text(
          'Email: ${child.email}',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 8),
        Text(
          'Teléfono: ${child.phone}',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          onPressed: () async {
            // Tu lógica aquí
          },
        ),
      ],
    );
  }
}