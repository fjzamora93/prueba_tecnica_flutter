import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/carrousel_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends ConsumerState<HomeScreen> {
  // ✅ MOVER ESTAS VARIABLES FUERA DEL BUILD
  late PageController _pageController;
  int _currentPage = 0;

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
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return PrimaryScaffold(
      backgroundColor: AppColors.white,
      children: [
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 30.0, desktop: 50.0)),

        SizedBox(
          height: ResponsiveHelper.responsiveValue(context, mobile: 350.0, desktop: 500.0),
          child: isDesktop ? _buildDesktopCarousel() : _buildMobileCarousel(),
        ),

        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 30.0)),

        // Navigation dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: _Dot(
                isActive: index == _currentPage,
                isDesktop: isDesktop,
              ),
            ),
          ),
        ),

        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 20.0)),
      ],
    );
  }

  Widget _buildMobileCarousel() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index; 
        });
      },
      children: _buildCarouselItems(),
    );
  }

  Widget _buildDesktopCarousel() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index; 
        });
      },
      children: _buildCarouselItems(),
    );
  }

  List<Widget> _buildCarouselItems() {
    return [
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
    ];
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  final bool isDesktop;
  
  const _Dot({
    required this.isActive,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeSize = isDesktop ? 16.0 : 12.0;
    final inactiveSize = isDesktop ? 12.0 : 8.0;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 6 : 4),
      width: isActive ? activeSize : inactiveSize,
      height: isActive ? activeSize : inactiveSize,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}