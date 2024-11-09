import 'package:flutter/material.dart';

String timeOfDayToString(TimeOfDay time) {
  final String hour = time.hour.toString();
  final String minute = time.minute.toString().padLeft(2, '0');

  return '$hour:$minute';
}
