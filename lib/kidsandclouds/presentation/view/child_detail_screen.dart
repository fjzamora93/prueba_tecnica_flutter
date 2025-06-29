
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/error_state_widget.dart';
import 'package:pruebakidsandclouds/core/widgets/confirmation_dialogue.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/child_detail.provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/children_list_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_header.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/child_info_card.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_list.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String childId;
  const ChildDetailScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreen();
}


class _ChildDetailScreen extends ConsumerState<ChildDetailScreen> {
  Child? childDetail;
  bool _hasError = false;
  bool _isInitialized = false;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChildData();
    });
  }


  Future<void> _loadChildData() async {
    if (_isInitialized && !_hasError) return;
    
    try {
      setState(() {
        _hasError = false;
      });
      
      childDetail = await ref.read(childrenListProvider.notifier).getChildById(widget.childId);
      
      if (mounted) {
        if (childDetail != null) {
          ref.read(childDetailProvider.notifier).setChild(childDetail!);
          // Cargar eventos
          await ref.read(eventProvider.notifier).fetchEvents();
          setState(() {
            _isInitialized = true;
          });
        } else {
          // El niño no existe
          setState(() {
            _hasError = true;
          });
          _showChildNotFoundDialog();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
        _showChildNotFoundDialog();
      }
    }
  }

  void _showChildNotFoundDialog() {
    if (!mounted) return;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmationDialog(
          title: '😢 Niño no encontrado',
          body: 'El niño que quiere consultar no existe o no se pudo cargar. Por favor, regrese a la lista de niños y seleccione otro distinto.',
          onAccept: () {
            context.pushReplacement(AppRoutes.childrenList);
          },
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return PrimaryScaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          title: Text(S.of(context).childDetails),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: context.pop,
          ),
        ),
        children: [
          ErrorStateWidget(
            errorMessage: 'No se pudo cargar la información del niño',
            onRetry: () {
              setState(() {
                _hasError = false;
                _isInitialized = false;
              });
              _loadChildData();
            },
          ),
        ],
      );
    }

    final childState = ref.watch(childDetailProvider);
    final eventsState = ref.watch(eventProvider);

    return PrimaryScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(S.of(context).childDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.pop,
        ),
      ),
      children: [
        // Datos del niño
        childDetail != null 
          ? _buildChildDetail(childDetail!, eventsState)
          : childState.when(
              loading: () => const CustomLoadingIndicator(),
              error: (error, _) => ErrorStateWidget(
                errorMessage: 'Error al cargar los datos del niño: ${error.toString()}',
                onRetry: () {
                  setState(() {
                    _hasError = false;
                    _isInitialized = false;
                  });
                  _loadChildData();
                },
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
        EventList(eventsState: eventsState),
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
              child: EventList(eventsState: eventsState),
            ),
          ],
        ),
      ],
    );
  }
}