import 'package:flutter/material.dart';

String formatTimeWithAmPm(TimeOfDay time) {
  final int hour = time.hourOfPeriod;
  final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

  final String formattedTime =
      '$hour:${time.minute.toString().padLeft(2, '0')} $period';

  return formattedTime;
}

String formatPrayerTime(DateTime time) {
  int hour = time.hour;
  int minute = time.minute;

  hour = hour > 12 ? hour - 12 : hour;
  if (hour == 0) {
    hour = 12;
  }

  String formattedMinute = minute.toString().padLeft(2, '0');

  return '$hour:$formattedMinute';
}
