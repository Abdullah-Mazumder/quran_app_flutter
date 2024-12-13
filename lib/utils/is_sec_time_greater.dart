import 'package:flutter/material.dart';

bool isSecTimeGreater(TimeOfDay time1, TimeOfDay time2) {
  // Convert both times to minutes since midnight
  final int minutes1 = time1.hour * 60 + time1.minute;
  final int minutes2 = time2.hour * 60 + time2.minute;

  // Check if the second time is after the first
  return minutes2 > minutes1;
}
