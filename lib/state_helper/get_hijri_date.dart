import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/utils/get_difference_of_two_times.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

HijriCalendar getHijriDate(BuildContext context, DateTime date) {
  final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);
  PrayerTimesObject prayerTimes = getPrayerTimes(context: context, date: date);

  if (calenderInfoProvider.hijriChange == 'midnight') {
    return HijriCalendar.fromDate(
        date.add(Duration(days: calenderInfoProvider.hijriDateAdjustment)));
  }

  if (isCurrentTimeBetween(prayerTimes.sunset,
      DateTime(date.year, date.month, date.day, 23, 59, 59))) {
    return HijriCalendar.fromDate(
        date.add(Duration(days: calenderInfoProvider.hijriDateAdjustment + 1)));
  }

  return HijriCalendar.fromDate(
      date.add(Duration(days: calenderInfoProvider.hijriDateAdjustment)));
}
