import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/core/widgets/carrousel_item.dart';
import 'package:pruebakidsandclouds/core/widgets/carousel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      
    return PrimaryScaffold(
      backgroundColor: AppColors.white,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 30.0, desktop: 50.0)),

        Carousel(
          carouselItems: [
            CarouselItem(
              imagePath: 'assets/img/home_illustration_1.png',
              title: S.of(context).splash1Title,
              description: S.of(context).splash1Subtitle,
            ),
            CarouselItem(
              imagePath: 'assets/img/home_illustration_2.png',
              title: S.of(context).splash2Title,
              description: S.of(context).splash2Subtitle,
            ),
            CarouselItem(
              imagePath: 'assets/img/home_illustration_3.png',
              title: S.of(context).splash3Title,
              description: S.of(context).splash3Subtitle,
            ),
          ],
        ),

        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 20.0)),
      ],
    );
  }

}