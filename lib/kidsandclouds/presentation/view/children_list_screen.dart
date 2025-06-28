
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
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
            padding: ResponsiveHelper.responsivePadding(context),
            child: Text(S.of(context).error),
          ),
          data: (childrenList) => _buildChildrenList(context, childrenList),
        ),
      ],
    );
  }

  Widget _buildChildrenList(BuildContext context, List childrenList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
        Text(
          '${S.of(context).youHave} ${childrenList.length} ${S.of(context).children} ',
          style: TextStyle(
            fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
          ),
        ),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
        // Children list with responsive layout
        _buildResponsiveChildrenList(context, childrenList),
      ],
    );
  }

  Widget _buildResponsiveChildrenList(BuildContext context, List childrenList) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final gridColumns = ResponsiveHelper.getGridColumns(context);
    
    if (isDesktop && childrenList.length > 1) {
      // Desktop: Use a grid layout
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridColumns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
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
      );
    } else {
      // Mobile: Use a list layout with constrained height
      return SizedBox(
        height: ResponsiveHelper.responsiveValue(context, mobile: 400.0, desktop: 500.0), 
        child: ListView.builder(
          itemCount: childrenList.length,
          itemBuilder: (context, index) {
            final child = childrenList[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 12.0),
              ),
              child: ChildSummaryCard(
                child: child,
                onTap: () {
                  context.push('${AppRoutes.childDetail}/${child.idValue}'); 
                },
                summarize: false, 
              ),
            );
          },
        ),
      );
    }

  }
}