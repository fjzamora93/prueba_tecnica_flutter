import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/widgets/logo.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/carrousel_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PageController _pageController = PageController(initialPage: 0);
    int _currentPage = 0;

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    return PrimaryScaffold(
      //hideBottonNavigationBar: true,
      children: [
        
        SizedBox(height: 25), 
        Logo(),
        SizedBox(height: 25), 

        SizedBox(
          height: 400,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              CarouselItem(
                imagePath: 'assets/img/home_illustration_1.png',
                title: S.of(context).splash1Title,
              ),
              CarouselItem(
                imagePath: 'assets/img/home_illustration_2.png',
                title: S.of(context).splash2Title,
              ),
              CarouselItem(
                imagePath: 'assets/img/home_illustration_3.png',
                title: S.of(context).splash3Title,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Los puntos de la parte inferior
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
              child: _Dot(isActive: index == _currentPage),
            ),
          ),
        ),



        const SizedBox(height: 12),

    
        PrimaryButton(
          onPressed: () => {
            if (_currentPage < 2) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            } 
            
            },
            color: AppColors.primary,
        ),

        const SizedBox(height: 12),
  
      ],
    );
  }
}

  class _Dot extends StatelessWidget {
    final bool isActive;
    const _Dot({required this.isActive});

    @override
    Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 10 : 8,
        height: isActive ? 10 : 8,
        decoration: BoxDecoration(
          color: isActive ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      );
    }
}