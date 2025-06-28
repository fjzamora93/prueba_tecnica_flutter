/// ResponsiveWrapper: Widget that provides responsive layout capabilities
library;

import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool centerContent;
  final double? maxWidth;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.padding,
    this.centerContent = true,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final contentWidth = maxWidth ?? ResponsiveHelper.getContentWidth(context);
    final effectivePadding = padding ?? ResponsiveHelper.responsivePadding(context);
    
    Widget content = Container(
      width: contentWidth,
      padding: effectivePadding,
      child: child,
    );

    if (centerContent && ResponsiveHelper.isDesktop(context)) {
      content = Center(child: content);
    }

    return content;
  }
}

/// ResponsiveRow: Row that stacks vertically on mobile and horizontally on desktop
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      // Stack vertically on mobile
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .expand((child) => [child, SizedBox(height: spacing)])
            .take(children.length * 2 - 1)
            .toList(),
      );
    } else {
      // Row on desktop
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children
            .expand((child) => [child, SizedBox(width: spacing)])
            .take(children.length * 2 - 1)
            .toList(),
      );
    }
  }
}

/// ResponsiveGrid: Grid that adapts based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double aspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.aspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveHelper.getGridColumns(context);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
