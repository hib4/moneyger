import 'package:flutter/material.dart';

SnackBar _getSnackBar({required String title, Duration? duration}) {
  return SnackBar(
    content: Text(title),
    duration: duration ?? const Duration(seconds: 2),
    padding: const EdgeInsets.all(20),
  );
}

void showSnackBar(BuildContext context,
    {required String title, Duration? duration}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(
        title: title,
        duration: duration,
      ),
    );
