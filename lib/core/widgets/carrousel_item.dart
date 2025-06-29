import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const CarouselItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Cálculo del tamaño de la imagen basado en el ancho de pantalla
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final imageWidth = screenSize.width * 0.8; // 80% del ancho de pantalla
    final imageHeight = isDesktop 
        ? screenSize.height * 0.5  
        : screenSize.height * 0.3; 
    
    // Limitar tamaño máximo de la imagen
    final maxImageWidth = isDesktop ? 900.0 : 300.0;
    final maxImageHeight = isDesktop ? 600.0 : 200.0;
    
      
    final finalImageWidth = imageWidth > maxImageWidth ? maxImageWidth : imageWidth;
    final finalImageHeight = imageHeight > maxImageHeight ? maxImageHeight : imageHeight;

    


    return Column(
      children: [
        
         Center(
          child: Container(
            width: finalImageWidth,
            height: finalImageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
              ),
              child: Image.asset(
                imagePath,
                width: finalImageWidth,
                height: finalImageHeight,
                fit: BoxFit.contain,
              
              ),
            ),
          ),
        ),
        
        // TÍTULO Y DESCRIPCIONES DE LA APLICACIÓN
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),


        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0),
          ),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveHelper.responsiveValue(context, mobile: 22.0, desktop: 28.0),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),


        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 32.0),
            ),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSubtitle,
                fontSize: ResponsiveHelper.responsiveValue(context, mobile: 15.0, desktop: 17.0), 
                height: 1.4, 
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
       
      ],
    );
  }
}