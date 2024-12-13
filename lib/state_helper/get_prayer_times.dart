import 'package:adhan/adhan.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerTimesObject {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime fajrStart;
  final DateTime fajrEnd;
  final DateTime dhuhrStart;
  final DateTime dhuhrEnd;
  final DateTime asrStart;
  final DateTime asrEnd;
  final DateTime maghribStart;
  final DateTime maghribEnd;
  final DateTime ishaStart;
  final DateTime ishaEnd;
  // final DateTime midNight;
  final DateTime sehriEnd;
  final DateTime prohibitedTime1End;
  final DateTime prohibitedTime2Start;
  final DateTime prohibitedTime2End;
  final DateTime prohibitedTime3Start;

  PrayerTimesObject({
    required this.sunrise,
    required this.sunset,
    required this.fajrStart,
    required this.fajrEnd,
    required this.dhuhrStart,
    required this.dhuhrEnd,
    required this.asrStart,
    required this.asrEnd,
    required this.maghribStart,
    required this.maghribEnd,
    required this.ishaStart,
    required this.ishaEnd,
    // required this.midNight,
    required this.sehriEnd,
    required this.prohibitedTime1End,
    required this.prohibitedTime2Start,
    required this.prohibitedTime2End,
    required this.prohibitedTime3Start,
  });
}

dynamic getPrayerTimes({required BuildContext context, DateTime? date}) {
  date ??= DateTime.now();

  final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

  final myCoordinates =
      Coordinates(calenderInfoProvider.lat, calenderInfoProvider.lng);

  final CalculationParameters params;
  if (calenderInfoProvider.prayerTimeMethod == '1') {
    params = CalculationMethod.muslim_world_league.getParameters();
  } else if (calenderInfoProvider.prayerTimeMethod == '2') {
    params = CalculationMethod.karachi.getParameters();
  } else if (calenderInfoProvider.prayerTimeMethod == '3') {
    params = CalculationMethod.north_america.getParameters();
  } else if (calenderInfoProvider.prayerTimeMethod == '4') {
    params = CalculationMethod.umm_al_qura.getParameters();
  } else if (calenderInfoProvider.prayerTimeMethod == '5') {
    params = CalculationMethod.egyptian.getParameters();
  } else if (calenderInfoProvider.prayerTimeMethod == '6') {
    params = CalculationParameters(fajrAngle: 12, ishaAngle: 12);
  } else if (calenderInfoProvider.prayerTimeMethod == '7') {
    params = CalculationParameters(
        fajrAngle: 20, ishaAngle: 18, adjustments: PrayerAdjustments(fajr: 9));
  } else if (calenderInfoProvider.prayerTimeMethod == '8') {
    params = CalculationParameters(fajrAngle: 16, ishaAngle: 15);
  } else {
    params = CalculationMethod.karachi.getParameters();
  }

  if (calenderInfoProvider.madhab == 'hanafi') {
    params.madhab = Madhab.hanafi;
  } else {
    params.madhab = Madhab.shafi;
  }

  final prayerTimes = PrayerTimes(
      myCoordinates, DateComponents.from(date), params,
      utcOffset:
          Duration(minutes: (calenderInfoProvider.gmtOffset * 60).toInt()));

  final sunnahTimes = SunnahTimes(prayerTimes);

  return PrayerTimesObject(
    sunrise: prayerTimes.sunrise,
    sunset: prayerTimes.maghrib,
    fajrStart: prayerTimes.fajr,
    fajrEnd: prayerTimes.sunrise.subtract(const Duration(minutes: 1)),
    dhuhrStart: prayerTimes.dhuhr.add(const Duration(seconds: 240)),
    dhuhrEnd: prayerTimes.asr.subtract(const Duration(minutes: 1)),
    asrStart: prayerTimes.asr,
    asrEnd: prayerTimes.maghrib.subtract(const Duration(minutes: 1)),
    maghribStart: prayerTimes.maghrib
        .add(Duration(minutes: calenderInfoProvider.warningTimeBeforeMag)),
    maghribEnd: prayerTimes.isha.subtract(const Duration(minutes: 1)),
    ishaStart: prayerTimes.isha,
    ishaEnd: calenderInfoProvider.madhab == 'hanafi'
        ? prayerTimes.fajr.subtract(
            Duration(minutes: calenderInfoProvider.warningTimeBeforeMag))
        : sunnahTimes.middleOfTheNight,
    sehriEnd: prayerTimes.fajr
        .subtract(Duration(minutes: calenderInfoProvider.warningTimeBeforeMag)),
    // midNight: sunnahTimes.middleOfTheNight,
    prohibitedTime1End: prayerTimes.sunrise.add(const Duration(minutes: 15)),
    prohibitedTime2Start: prayerTimes.dhuhr
        .add(const Duration(seconds: 240))
        .subtract(const Duration(minutes: 9)),
    prohibitedTime2End: prayerTimes.dhuhr
        .add(const Duration(seconds: 240))
        .subtract(const Duration(minutes: 1)),
    prohibitedTime3Start:
        prayerTimes.maghrib.subtract(const Duration(minutes: 16)),
  );
}
