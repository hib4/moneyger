import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/splash_screen//splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneyger',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.getThemeLight(),
      home: const SplashScreen(),
    );
  }
}

