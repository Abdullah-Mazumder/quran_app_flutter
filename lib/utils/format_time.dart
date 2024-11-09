import 'package:flutter/material.dart';

String formatTimeWithAmPm(TimeOfDay time) {
  final int hour = time.hourOfPeriod;
  final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

  final String formattedTime =
      '$hour:${time.minute.toString().padLeft(2, '0')} $period';

  return formattedTime;
}
