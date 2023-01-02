import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.radius});
  final double height, width, radius;
  final Color _baseColor = const Color(0xFFEEEEEE);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Shimmer.fromColors(
          baseColor: _baseColor,
          highlightColor: const Color(0xFFFFFFFF),
          child: Container(
            height: height,
            width: width,
            color: _baseColor,
          )),
    );
  }
}
