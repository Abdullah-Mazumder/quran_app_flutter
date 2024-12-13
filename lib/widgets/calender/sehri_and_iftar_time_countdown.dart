import 'dart:async';

import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/get_difference_of_two_times.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SehriAndIftarTimeCountdown extends StatefulWidget {
  const SehriAndIftarTimeCountdown({super.key});

  @override
  State<SehriAndIftarTimeCountdown> createState() =>
      _SehriAndIftarTimeCountdownState();
}

class _SehriAndIftarTimeCountdownState
    extends State<SehriAndIftarTimeCountdown> {
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
    final language = getLanguage(context);

    PrayerTimesObject prayerTimes = getPrayerTimes(context: context);
    PrayerTimesObject prayerTimes2 = getPrayerTimes(
        context: context, date: DateTime.now().add(const Duration(days: 1)));

    String topic;
    String rmTime;

    if (isCurrentTimeBetween(prayerTimes.sehriEnd, prayerTimes.maghribStart)) {
      topic = language == 'en' ? 'Remaining of iftar' : 'ইফতারের বাকি';
      rmTime =
          getDifferenceOfTwoTimes(DateTime.now(), prayerTimes.maghribStart);
    } else {
      topic = language == 'en' ? 'Remaining of sehri' : 'সেহরির বাকি';
      rmTime = getDifferenceOfTwoTimes(DateTime.now(), prayerTimes2.sehriEnd);
    }

    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: -5,
      children: [
        CustomText(
          text:
              language == 'en' ? rmTime : convertEnglishToBanglaNumber(rmTime),
          additionalStyle: const TextStyle(fontFamily: ''),
        ),
        CustomText(
          text: topic,
        )
      ],
    );
  }
}
