import 'package:adhan/adhan.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime getNextSehriEndTime({required BuildContext context, DateTime? date}) {
  final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

  final myCoordinates =
      Coordinates(calenderInfoProvider.lat, calenderInfoProvider.lng);
  final params = CalculationMethod.karachi.getParameters();
  // params.method = CalculationMethod.muslim_world_league;
  params.madhab = Madhab.hanafi;
  final prayerTimes = PrayerTimes(myCoordinates,
      DateComponents.from(DateTime.now().add(const Duration(days: 1))), params,
      utcOffset:
          Duration(minutes: (calenderInfoProvider.gmtOffset * 60).toInt()));

  return prayerTimes.fajr.subtract(const Duration(minutes: 2));
}
