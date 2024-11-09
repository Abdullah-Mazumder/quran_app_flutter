// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

int timeofday_to_mill(TimeOfDay time) {
  final now = DateTime.now();

  // Convert TimeOfDay to DateTime
  final datetime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);

  return datetime.millisecondsSinceEpoch;
}
