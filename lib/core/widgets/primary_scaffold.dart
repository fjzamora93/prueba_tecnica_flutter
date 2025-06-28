/// PrimaryScaffold: used for screens with BottomNavBar and primary styling.
library;
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/bottom_nav_bar.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/responsive_wrapper.dart';

class PrimaryScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final bool hideBottonNavigationBar;
  final bool useResponsiveWrapper;

  const PrimaryScaffold({
    super.key,
    this.appBar,
    required this.children,
    this.floatingActionButton,
    this.hideBottonNavigationBar = false,
    this.backgroundColor = AppColors.backgroundInput,
    this.useResponsiveWrapper = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget body;
    
    if (useResponsiveWrapper) {
      body = ResponsiveWrapper(
        child: Column(children: children),
      );
    } else {
      body = ListView(
        padding: ResponsiveHelper.responsivePadding(context),
        children: children,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: body),
      backgroundColor: backgroundColor,
      bottomNavigationBar: hideBottonNavigationBar ? null : const BottomNavBar(),
      floatingActionButton: floatingActionButton,
    );
  }
}