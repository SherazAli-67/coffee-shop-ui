import 'package:coffee_app/constants/string_const.dart';
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
        scaffoldBackgroundColor: Colors.white
      ),
      builder: (ctx, child) => child!,
      routerConfig: router,
    );
  }
}