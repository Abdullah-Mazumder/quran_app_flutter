import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/calender/circular_time_countdown.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RemainingPrayerTime extends StatelessWidget {
  final String prayerName;
  final String rmtime;
  final double percentage;

  const RemainingPrayerTime({
    super.key,
    required this.prayerName,
    required this.rmtime,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);

    return Column(
      children: [
        CustomText(text: prayerName),
        CustomText(
            text: language == 'en' ? 'Remainging time' : 'ওয়াক্ত শেষ হতে বাকি'),
        const SizedBox(
          height: 15,
        ),
        CircularTimeCountdown(
          rmTime: rmtime,
          percentage: percentage,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
