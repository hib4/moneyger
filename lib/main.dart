import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/firebase_options.dart';
import 'package:moneyger/ui/bottom_navigation/item/budget.dart';
import 'package:moneyger/ui/splash_screen//splash_screen.dart';
import 'package:moneyger/ui/subscribe/subscribe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  statusBarStyle();
  deviceOrientation();

  runApp(const MyApp());
}

void statusBarStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

void deviceOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id');

    return MaterialApp(
      title: 'Moneyger',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.getThemeLight(),
      home: const SplashScreen(),
    );
  }
}
