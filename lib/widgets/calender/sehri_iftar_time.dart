import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/widgets/calender/sehri_and_iftar_time_countdown.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SehriIftarTime extends StatelessWidget {
  const SehriIftarTime({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    PrayerTimesObject times = getPrayerTimes(context: context);
    PrayerTimesObject times2 = getPrayerTimes(
        context: context, date: DateTime.now().add(const Duration(days: 1)));
    DateTime sehriEndTime = times2.sehriEnd;

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.bgColor1,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: -5,
                children: [
                  CustomText(
                    text: language == 'en'
                        ? formatPrayerTime(sehriEndTime)
                        : convertEnglishToBanglaNumber(
                            formatPrayerTime(sehriEndTime)),
                    additionalStyle: const TextStyle(fontFamily: ''),
                  ),
                  CustomText(
                      text: language == 'en'
                          ? 'Next sehri end'
                          : 'পরবর্তী সেহরি শেষ')
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: -5,
                children: [
                  CustomText(
                    text: language == 'en'
                        ? formatPrayerTime(times.maghribStart)
                        : convertEnglishToBanglaNumber(
                            formatPrayerTime(times.maghribStart)),
                    additionalStyle: const TextStyle(fontFamily: ''),
                  ),
                  CustomText(
                    text: language == 'en'
                        ? 'Today iftar start'
                        : 'আজ ইফতার শুরু',
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SehriAndIftarTimeCountdown(),
        ],
      ),
    );
  }
}
