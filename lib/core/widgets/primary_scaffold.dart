/// PrimaryScaffold: used for screens with BottomNavBar and primary styling.
library;
import 'package:cari/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';


class PrimaryScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final hideBottonNavigationBar;
  final Color? backgroundColor;

  const PrimaryScaffold({
    super.key,
    this.appBar,
    required this.children,
    this.floatingActionButton,
    this.hideBottonNavigationBar = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: children,
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: hideBottonNavigationBar ? null : const BottomNavBar() ,
      floatingActionButton: floatingActionButton,
    );
  }
}