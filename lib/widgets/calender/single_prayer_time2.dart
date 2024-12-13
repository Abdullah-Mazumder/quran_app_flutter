import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SinglePrayerTime2 extends StatelessWidget {
  final String label;
  final DateTime startTime;
  final DateTime endTime;
  const SinglePrayerTime2({
    super.key,
    required this.label,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);

    return Column(
      children: [
        CustomText(
          text: label,
          additionalStyle: TextStyle(
            fontFamily: language == 'bn' ? '' : null,
            color: Colors.white,
          ),
        ),
        CustomText(
          text: language == 'en'
              ? formatPrayerTime(startTime)
              : convertEnglishToBanglaNumber(formatPrayerTime(startTime)),
          additionalStyle: TextStyle(
            fontFamily: language == 'bn' ? '' : null,
            color: Colors.white,
          ),
        ),
        CustomText(
          text: language == 'en'
              ? formatPrayerTime(endTime)
              : convertEnglishToBanglaNumber(formatPrayerTime(endTime)),
          additionalStyle: TextStyle(
            fontFamily: language == 'bn' ? '' : null,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
