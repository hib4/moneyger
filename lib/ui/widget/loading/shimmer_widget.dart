import 'package:flutter/material.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.radius});

  final double height, width, radius;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Shimmer.fromColors(
        baseColor: provider.isDarkMode
            ? const Color(0xFF3B3D43)
            : const Color(0xFFEEEEEE),
        highlightColor: provider.isDarkMode
            ? const Color(0xFF4A4C52)
            : const Color(0xFFFFFFFF),
        child: Container(
          height: height,
          width: width,
          color: provider.isDarkMode
              ? const Color(0xFF3B3D43)
              : const Color(0xFFEEEEEE),
        ),
      ),
    );
  }
}
