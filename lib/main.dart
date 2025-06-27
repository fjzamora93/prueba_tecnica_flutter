
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pruebakidsandclouds/core/navigation/router.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kids & Clouds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // IDIOMAS Y LOCALILZACIÓN
      localizationsDelegates: const [
        S.delegate,                               
        GlobalMaterialLocalizations.delegate,    
        GlobalWidgetsLocalizations.delegate,     
        GlobalCupertinoLocalizations.delegate,   
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      

      routerConfig: appRouter(),

      debugShowCheckedModeBanner: false,
    );
  }
}

