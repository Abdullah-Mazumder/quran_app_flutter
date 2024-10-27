import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String title, Color bgColor) {
  return Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: bgColor,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
