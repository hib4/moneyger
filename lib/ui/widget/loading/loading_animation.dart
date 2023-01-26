import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:provider/provider.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ThemeProvider>(context);

    return Container(
      width: size.width,
      height: size.height,
      color: provider.isDarkMode
          ? ColorValueDark.backgroundColor.withOpacity(0.5)
          : Colors.white.withOpacity(0.5),
      child: Center(
        child: Lottie.asset(
          'assets/lottie/loading.json',
          width: size.width * 0.5,
        ),
      ),
    );
  }
}
