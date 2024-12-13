import 'dart:async';

import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/get_difference_of_two_times.dart';
import 'package:al_quran/widgets/calender/all_prayer_times.dart';
import 'package:al_quran/widgets/calender/remaining_prayer_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerAndRemaingTimes extends StatefulWidget {
  const PrayerAndRemaingTimes({super.key});

  @override
  State<PrayerAndRemaingTimes> createState() => _PrayerAndRemaingTimesState();
}

class _PrayerAndRemaingTimesState extends State<PrayerAndRemaingTimes> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Ensure that context is available after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCountdown();

      // Set up a periodic timer to update every second
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateCountdown();
      });
    });
  }

  // Method to update the countdown value
  void _updateCountdown() {
    setState(() {});
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    PrayerTimesObject prayerTimes = getPrayerTimes(context: context);
    PrayerTimesObject prayerTimes2 = getPrayerTimes(
        context: context, date: DateTime.now().add(const Duration(days: 1)));
    DateTime sehriEndTime = prayerTimes2.sehriEnd;

    String prayerName;
    String rmtime;
    double percentage;
    String currentPrayer;

    if (isCurrentTimeBetween(prayerTimes.fajrStart, prayerTimes.sunrise)) {
      prayerName = language == 'en' ? 'Fajr' : 'ফজর';
      currentPrayer = 'fajr';
      rmtime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.sunrise);

      percentage = getDifferenceInSeconds(DateTime.now(), prayerTimes.sunrise) /
          getDifferenceInSeconds(prayerTimes.fajrStart, prayerTimes.sunrise);
    } else if (isCurrentTimeBetween(
        prayerTimes.sunrise, prayerTimes.prohibitedTime1End)) {
      prayerName = language == 'en' ? 'Prohibited time' : 'নিষিদ্ধ সময়';
      currentPrayer = 'none';
      rmtime = getDifferenceOfTwoTimes(
          DateTime.now(), prayerTimes.prohibitedTime1End);

      percentage = getDifferenceInSeconds(
              DateTime.now(), prayerTimes.prohibitedTime1End) /
          getDifferenceInSeconds(
              prayerTimes.sunrise, prayerTimes.prohibitedTime1End);
    } else if (isCurrentTimeBetween(
        prayerTimes.prohibitedTime1End, prayerTimes.prohibitedTime2Start)) {
      prayerName = language == 'en' ? 'Salatud Doha' : 'সালাতুদ দোহা';
      currentPrayer = 'none';
      rmtime = getDifferenceOfTwoTimes(
          DateTime.now(), prayerTimes.prohibitedTime2Start);

      percentage = getDifferenceInSeconds(
              DateTime.now(), prayerTimes.prohibitedTime2Start) /
          getDifferenceInSeconds(
              prayerTimes.prohibitedTime1End, prayerTimes.prohibitedTime2Start);
    } else if (isCurrentTimeBetween(
        prayerTimes.prohibitedTime2Start, prayerTimes.dhuhrStart)) {
      prayerName = language == 'en' ? 'Prohibited time' : 'নিষিদ্ধ সময়';
      currentPrayer = 'none';
      rmtime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.dhuhrStart);

      percentage =
          getDifferenceInSeconds(DateTime.now(), prayerTimes.dhuhrStart) /
              getDifferenceInSeconds(
                  prayerTimes.prohibitedTime2Start, prayerTimes.dhuhrStart);
    } else if (isCurrentTimeBetween(
        prayerTimes.dhuhrStart, prayerTimes.asrStart)) {
      prayerName = language == 'en' ? 'Dhuhr' : 'যুহর';
      currentPrayer = 'dhuhr';
      rmtime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.asrStart);

      percentage = getDifferenceInSeconds(
              DateTime.now(), prayerTimes.asrStart) /
          getDifferenceInSeconds(prayerTimes.dhuhrStart, prayerTimes.asrStart);
    } else if (isCurrentTimeBetween(prayerTimes.asrStart, prayerTimes.sunset)) {
      prayerName = language == 'en' ? 'Asr' : 'আসর';
      currentPrayer = 'asr';
      rmtime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.sunset);

      percentage = getDifferenceInSeconds(DateTime.now(), prayerTimes.sunset) /
          getDifferenceInSeconds(prayerTimes.asrStart, prayerTimes.sunset);
    } else if (isCurrentTimeBetween(
        prayerTimes.sunset, prayerTimes.ishaStart)) {
      prayerName = language == 'en' ? 'Maghrib' : 'মাগরিব';
      currentPrayer = 'maghrib';
      rmtime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.ishaStart);

      percentage =
          getDifferenceInSeconds(DateTime.now(), prayerTimes.ishaStart) /
              getDifferenceInSeconds(prayerTimes.sunset, prayerTimes.ishaStart);
    } else {
      if (calenderInfoProvider.madhab == 'hanafi') {
        prayerName = language == 'en' ? 'Isha & Tahajjud' : 'এশা এবং তাহাজ্জুদ';
        currentPrayer = 'isha';
        rmtime = getDifferenceOfTwoTimes(
          DateTime.now(),
          sehriEndTime,
        );

        percentage = getDifferenceInSeconds(DateTime.now(), sehriEndTime) /
            getDifferenceInSeconds(prayerTimes.ishaStart, sehriEndTime);
      } else {
        if (isCurrentTimeBetween(prayerTimes.ishaStart, prayerTimes.ishaEnd)) {
          prayerName = language == 'en' ? 'Isha' : 'এশা';
          currentPrayer = 'isha';
          rmtime = getDifferenceOfTwoTimes(
            DateTime.now(),
            prayerTimes.ishaEnd,
          );

          percentage =
              getDifferenceInSeconds(DateTime.now(), prayerTimes.ishaEnd) /
                  getDifferenceInSeconds(
                      prayerTimes.ishaStart, prayerTimes.ishaEnd);
        } else {
          prayerName = language == 'en' ? 'Tahajjud' : 'তাহাজ্জুদ';
          currentPrayer = 'tahajjud';
          rmtime = getDifferenceOfTwoTimes(
            DateTime.now(),
            sehriEndTime,
          );

          percentage = getDifferenceInSeconds(DateTime.now(), sehriEndTime) /
              getDifferenceInSeconds(prayerTimes.ishaEnd, sehriEndTime);
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.bgColor1,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: RemainingPrayerTime(
            prayerName: prayerName,
            rmtime: rmtime,
            percentage: percentage,
          )),
          Expanded(
              child: AllPrayerTimes(
            currentPrayer: currentPrayer,
          )),
        ],
      ),
    );
  }
}
