import 'package:flutter/material.dart';

class Navigate {
  static void navigatorPush(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => widget));
  }

  static void navigatorReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => widget));
  }

  static void navigatorPushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => widget), (route) => false);
  }
}