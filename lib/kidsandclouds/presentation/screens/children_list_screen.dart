import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_subtitle.dart';
import 'package:pruebakidsandclouds/core/widgets/error_state_widget.dart';
import 'package:pruebakidsandclouds/core/widgets/search_bar.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';
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
    final filteredChildrenState = ref.watch(filteredChildrenProvider);

    return PrimaryScaffold(
      appBar: AppBar(
        title:  Text(S.of(context).childrenList),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      children: [
        filteredChildrenState.when(
          loading: () => CustomLoadingIndicator(),
          error: (error, _) => ErrorStateWidget(
            errorMessage: S.of(context).error,
            onRetry: () => ref.read(childrenListProvider.notifier).fetchChildren(),
            height: 200, 
          ),
          data: (childrenList) => _buildChildrenList(context, childrenList),
        ),
      ],
    );
  }

  Widget _buildChildrenList(BuildContext context, List childrenList) {
    final allChildren = ref.watch(childrenListProvider).value ?? [];
    final searchQuery = ref.watch(searchQueryProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
        Text(
          '${S.of(context).youHave} ${allChildren.length} ${S.of(context).children} ',
          style: AppTextStyles.caption
        ),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),

        CustomSearchBar(
          hintText: S.of(context).findChildrenByName,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
          onClear: () {
            ref.read(searchQueryProvider.notifier).state = '';
          },
        ),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
        // Mostrar resultados de búsqueda
        if (searchQuery.isNotEmpty)
            CustomSubtitle(S.of(context).noResultsFound),
   
        // Children list with responsive layout
        _buildResponsiveChildrenList(context, childrenList),
      ],
    );
  }


  // WIDGET QUE REPRESENTA EL LISTADO DE NIÑOS
  Widget _buildResponsiveChildrenList(BuildContext context, List childrenList) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final gridColumns = ResponsiveHelper.getGridColumns(context);
    
    if (isDesktop && childrenList.length > 1) {

      // DESKTOP: USAMOS UN GRID LAYOUT
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridColumns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 300,
        ),
        itemCount: childrenList.length,
        itemBuilder: (context, index) {
          final child = childrenList[index];
          return ChildSummaryCard(
            child: child,
            onTap: () =>   {
              ref.read(childDetailProvider.notifier).setChild(child),
              context.push('${AppRoutes.childDetail}/${child.idValue}')
              },
            summarize: false, 
          );
        },
      );
    } else {

      //  MOBILE: USAMOS UNA COLUMNA (recuerda que nuestro primary Scaffold ya tiene un list view)
      return Column(
        children: [
          ...childrenList.map((child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ChildSummaryCard(
                child: child,
                onTap: () => {
                  ref.read(childDetailProvider.notifier).setChild(child),
                  context.push('${AppRoutes.childDetail}/${child.idValue}')
                },
                summarize: false,
              ),
            );
          }).toList(),
        ],
      );


    }
  }
}