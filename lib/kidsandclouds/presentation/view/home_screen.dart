import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
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

    return PrimaryScaffold(
      backgroundColor: AppColors.white,
      children: [
        const SizedBox(height: 30),

        SizedBox(
          height: 350,
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
              const SizedBox(height: 30),

            ],
          ),
        ),


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
      width: isActive ? 12 : 8, // ✅ OPCIONAL: hacer más visible la diferencia
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}