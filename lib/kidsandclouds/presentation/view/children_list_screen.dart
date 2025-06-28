
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/children_list_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_summary_card.dart';

class ChildrenListScreen extends ConsumerStatefulWidget {
  const ChildrenListScreen({super.key});

  @override
  ConsumerState<ChildrenListScreen> createState() => _ChildrenListScreen();
}

class _ChildrenListScreen extends ConsumerState<ChildrenListScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(childrenListProvider.notifier).fetchChildren();
    });
  }


  @override
  Widget build(BuildContext context) {
    final childrenListState = ref.watch(childrenListProvider);

    return PrimaryScaffold(
      appBar: AppBar(
        title:  Text(S.of(context).childrenList),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      children: [
          childrenListState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(S.of(context).error),
            ),

            data: (childrenList) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
         
                const SizedBox(height: 16),
                Text(
                  '${S.of(context).youHave} ${childrenList.length} ${S.of(context).children} ',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                
                // LISTA DE CHILDREN CARDS
                SizedBox(
                  height: 400, 
                  child: ListView.builder(
                    itemCount: childrenList.length,
                    itemBuilder: (context, index) {
                      final child = childrenList[index];
                      return ChildSummaryCard(
                        child: child,
                        onTap: () {
                          context.push('${AppRoutes.childDetail}/${child.idValue}'); 
                        },
                        summarize: false, 
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  }
}