import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/firebase_options.dart';
import 'package:moneyger/ui/splash_screen//splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

