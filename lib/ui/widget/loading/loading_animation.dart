import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Lottie.asset(
          'assets/lottie/loading.json',
          width: size.width * 0.5,
        ),
      ),
    );
  }
}
