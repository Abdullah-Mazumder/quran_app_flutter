import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/widgets/calender/single_prayer_time.dart';
import 'package:flutter/material.dart';

class AllPrayerTimes extends StatelessWidget {
  final String currentPrayer;
  const AllPrayerTimes({super.key, required this.currentPrayer});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);

    PrayerTimesObject prayerTimes = getPrayerTimes(context: context);

    return Column(
      children: [
        SinglePrayerTime(
          prayerName: language == 'en' ? 'Fajr' : 'ফজর',
          time:
              '${formatPrayerTime(prayerTimes.fajrStart)}  -  ${formatPrayerTime(prayerTimes.fajrEnd)}',
          isActive: currentPrayer == 'fajr',
        ),
        const SizedBox(
          height: 5,
        ),
        DateTime.now().weekday == 5
            ? SinglePrayerTime(
                prayerName: language == 'en' ? 'Jumma' : 'জুমা',
                time:
                    '${formatPrayerTime(prayerTimes.dhuhrStart)}  -  ${formatPrayerTime(prayerTimes.dhuhrEnd)}',
                isActive: currentPrayer == 'dhuhr',
              )
            : SinglePrayerTime(
                prayerName: language == 'en' ? 'Dhuhr' : 'যুহর',
                time:
                    '${formatPrayerTime(prayerTimes.dhuhrStart)}  -  ${formatPrayerTime(prayerTimes.dhuhrEnd)}',
                isActive: currentPrayer == 'dhuhr',
              ),
        const SizedBox(
          height: 5,
        ),
        SinglePrayerTime(
          prayerName: language == 'en' ? 'Asr' : 'আসর',
          time:
              '${formatPrayerTime(prayerTimes.asrStart)}  -  ${formatPrayerTime(prayerTimes.asrEnd)}',
          isActive: currentPrayer == 'asr',
          isAsrPrayer: true,
        ),
        const SizedBox(
          height: 5,
        ),
        SinglePrayerTime(
          prayerName: language == 'en' ? 'Maghrib' : 'মাগরিব',
          time:
              '${formatPrayerTime(prayerTimes.maghribStart)}  -  ${formatPrayerTime(prayerTimes.maghribEnd)}',
          isActive: currentPrayer == 'maghrib',
        ),
        const SizedBox(
          height: 5,
        ),
        SinglePrayerTime(
          prayerName: language == 'en' ? 'Isha' : 'এশা',
          time:
              '${formatPrayerTime(prayerTimes.ishaStart)}  -  ${formatPrayerTime(prayerTimes.ishaEnd)}',
          isActive: currentPrayer == 'isha',
        ),
      ],
    );
  }
}
