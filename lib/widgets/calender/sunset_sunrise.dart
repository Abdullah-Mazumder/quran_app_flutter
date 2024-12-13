// import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SunsetSunrise extends StatelessWidget {
  const SunsetSunrise({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    PrayerTimesObject times = getPrayerTimes(context: context);

    return Row(
      children: [
        const Icon(
          Icons.sunny,
          color: Colors.white,
          size: 40,
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          children: [
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: language == 'en' ? -5 : -3,
              children: [
                CustomText(
                  text: language == 'en'
                      ? formatPrayerTime(times.sunrise)
                      : convertEnglishToBanglaNumber(
                          formatPrayerTime(times.sunrise)),
                  additionalStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: language == 'bn' ? '' : null),
                ),
                CustomText(
                  text: language == 'en' ? 'Sunrise' : 'সূর্যোদয়',
                  additionalStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: language == 'en' ? -5 : -3,
              children: [
                CustomText(
                  text: language == 'en'
                      ? formatPrayerTime(times.sunset)
                      : convertEnglishToBanglaNumber(
                          formatPrayerTime(times.sunset)),
                  additionalStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: language == 'bn' ? '' : null),
                ),
                CustomText(
                  text: language == 'en' ? 'Sunset' : 'সূর্যাস্ত',
                  additionalStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
