import 'package:coffee_app/constants/string_const.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/presentation/screens/welcome_screen.dart';
import 'package:coffee_app/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
          brightness: .light,
          scaffoldBackgroundColor: AppColors.scaffoldBgColor,
          fontFamily: StringConst.appFontFamily
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  /*  return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        scaffoldBackgroundColor: AppColors.scaffoldBgColor,
        fontFamily: StringConst.appFontFamily,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: const ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      // home: WelcomeScreen(),
      builder: (ctx, child) => child!,
      routerConfig: router,
    );*/
  }
}