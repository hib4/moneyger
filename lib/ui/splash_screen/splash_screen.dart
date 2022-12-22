import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/ui/auth/login/login.dart';
import 'package:moneyger/ui/auth/verification/verification.dart';
import 'package:moneyger/ui/on_boarding/on_boarding.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _checkOnBoardingStatus() async {
    String value = await SharedCode().getToken('token');
    if (value == '') {
      return false;
    } else {
      return true;
    }
  }

  Future _startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    bool status = await _checkOnBoardingStatus();
    return Timer(duration, () {
      Navigate.navigatorPushAndRemove(
        context,
        FirebaseAuth.instance.currentUser == null
            ? status
                ? const LoginPage()
                : const OnBoardingScreen()
            : const VerificationPage(),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/logo.svg',
                  width: screenWidth * 0.35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
