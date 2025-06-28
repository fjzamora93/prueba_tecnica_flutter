
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/children_list_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_header.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_info_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_events_section.dart';

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
      
      // Cargar eventos
      ref.read(eventProvider.notifier).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childDetailProvider);
    final eventsState = ref.watch(eventProvider);

    return PrimaryScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(S.of(context).childDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      children: [
        // Datos del niño
        childDetail != null 
          ? _buildChildDetail(childDetail!, eventsState)
          : childState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Padding(
                padding: ResponsiveHelper.responsivePadding(context),
                child: Text(
                  S.of(context).error,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              data: (child) => _buildChildDetail(child, eventsState),
            ),
      ],
    );
  }

  Widget _buildChildDetail(Child child, AsyncValue<List<Event>> eventsState) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    if (isDesktop) {
      return _buildDesktopLayout(child, eventsState);
    } else {
      return _buildMobileLayout(child, eventsState);
    }
  }

  Widget _buildMobileLayout(Child child, AsyncValue<List<Event>> eventsState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        ChildHeader(child: child),
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
        ChildInfoCard(child: child),
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 32.0, desktop: 40.0)),
        ChildEventsSection(eventsState: eventsState),
      ],
    );
  }

  Widget _buildDesktopLayout(Child child, AsyncValue<List<Event>> eventsState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0)),
        
        // Header - full width on desktop
        ChildHeader(child: child),
        
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
        
        // Info and Events side by side on desktop
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ChildInfoCard(child: child),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 2,
              child: ChildEventsSection(eventsState: eventsState),
            ),
          ],
        ),
      ],
    );
  }
}