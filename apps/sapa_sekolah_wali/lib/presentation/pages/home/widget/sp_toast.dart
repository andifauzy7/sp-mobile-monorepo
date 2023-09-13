import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SPToast {
  static void showToast({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 14.0,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
