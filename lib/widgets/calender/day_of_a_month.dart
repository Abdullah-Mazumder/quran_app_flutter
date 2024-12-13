import 'package:al_quran/state_helper/get_hijri_date.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/bongabdo.dart';
import 'package:al_quran/utils/calender_constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/utils/get_difference_of_two_times.dart';
import 'package:al_quran/widgets/calender/single_prayer_time2.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class DayOfAMonth extends StatelessWidget {
  final DateTime date;
  const DayOfAMonth({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    PrayerTimesObject prayerTimes =
        getPrayerTimes(context: context, date: date);

    HijriCalendar todayHijriDate = getHijriDate(context, date);
    var todayBanglaDate = Bongabdo.fromDate(date, 'new');

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
      decoration: areDatesEqual(date, DateTime.now())
          ? BoxDecoration(
              border: Border.all(
                color: Colors.red[300]!,
                width: 4,
              ),
            )
          : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 320),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: colors.activeColor1.withOpacity(0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: language == 'en'
                                ? date.day.toString()
                                : convertEnglishToBanglaNumber(
                                    date.day.toString()),
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'en'
                                ? '${englishMonthsEn[date.month - 1]}, ${date.year}'
                                : '${englishMonthsBn[date.month - 1]}, ${convertEnglishToBanglaNumber(date.year)}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 13.5,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'en'
                                ? weekDaysEn[date.weekday - 1]
                                : weekDaysBn[date.weekday - 1],
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? '${convertEnglishToBanglaNumber(todayBanglaDate.hDay)} ${banglaMonthsBn[todayBanglaDate.hMonth - 1]}'
                                : '${todayBanglaDate.hDay} ${banglaMonthsEn[todayBanglaDate.hMonth - 1]}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? '${banglaSeasonBn[todayBanglaDate.hSeason - 1]}কাল, ${convertEnglishToBanglaNumber(todayBanglaDate.hYear)}'
                                : '${banglaSeasonEn[todayBanglaDate.hSeason - 1]}, ${todayBanglaDate.hYear}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? '${convertEnglishToBanglaNumber(todayHijriDate.hDay)}, ${arabicMonthsBn[todayHijriDate.hMonth - 1]}'
                                : '${todayHijriDate.hDay}, ${arabicMonthsEn[todayHijriDate.hMonth - 1]}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? convertEnglishToBanglaNumber(
                                    todayHijriDate.hYear.toString())
                                : todayHijriDate.hYear.toString(),
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: colors.activeColor1.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: language == 'bn'
                                ? 'সেহরি শেষঃ ${convertEnglishToBanglaNumber(formatPrayerTime(prayerTimes.sehriEnd))}'
                                : 'Sehri End: ${formatPrayerTime(prayerTimes.sehriEnd)}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: language == 'bn' ? 13 : 15,
                              color: Colors.white,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? 'ইফতার শেষঃ ${convertEnglishToBanglaNumber(formatPrayerTime(prayerTimes.maghribStart))}'
                                : 'Iftar End: ${formatPrayerTime(prayerTimes.maghribStart)}',
                            additionalStyle: TextStyle(
                              fontFamily: language == 'bn' ? '' : null,
                              fontSize: language == 'bn' ? 13 : 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7, // Adjust to control the proportion
              child: Container(
                color: colors.activeColor2,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 15,
                      children: [
                        SinglePrayerTime2(
                          label: language == 'en' ? 'Fajr' : 'ফজর',
                          startTime: prayerTimes.fajrStart,
                          endTime: prayerTimes.fajrEnd,
                        ),
                        SinglePrayerTime2(
                          label: language == 'en' ? 'Dhuhr' : 'যুহর',
                          startTime: prayerTimes.dhuhrStart,
                          endTime: prayerTimes.dhuhrEnd,
                        ),
                        SinglePrayerTime2(
                          label: language == 'en' ? 'Asr' : 'আসর',
                          startTime: prayerTimes.asrStart,
                          endTime: prayerTimes.asrEnd,
                        ),
                        SinglePrayerTime2(
                          label: language == 'en' ? 'Maghrib' : 'মাগরিব',
                          startTime: prayerTimes.maghribStart,
                          endTime: prayerTimes.maghribEnd,
                        ),
                        SinglePrayerTime2(
                          label: language == 'en' ? 'Isha' : 'এশা',
                          startTime: prayerTimes.ishaStart,
                          endTime: prayerTimes.ishaEnd,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: language == 'en'
                              ? 'Sunrise: ${formatPrayerTime(prayerTimes.sunrise)}'
                              : 'সূর্যোদয়ঃ ${convertEnglishToBanglaNumber(formatPrayerTime(prayerTimes.sunrise))}',
                          additionalStyle: TextStyle(
                            fontFamily: language == 'bn' ? '' : null,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          text: language == 'en'
                              ? 'Sunset: ${formatPrayerTime(prayerTimes.sunset)}'
                              : 'সূর্যাস্তঃ ${convertEnglishToBanglaNumber(formatPrayerTime(prayerTimes.sunset))}',
                          additionalStyle: TextStyle(
                            fontFamily: language == 'bn' ? '' : null,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text: language == 'en'
                          ? 'Prohibited prayer times'
                          : 'নামাজের নিষিদ্ধ সময়',
                      additionalStyle: TextStyle(
                          fontFamily: language == 'bn' ? '' : null,
                          color: Colors.red[500]),
                    ),
                    Column(
                      children: [
                        CustomText(
                          text: language == 'en'
                              ? 'Morning: ${formatPrayerTime(prayerTimes.sunrise)} - ${formatPrayerTime(prayerTimes.prohibitedTime1End)}'
                              : 'সকালঃ ${convertEnglishToBanglaNumber('${formatPrayerTime(prayerTimes.sunrise)} - ${formatPrayerTime(prayerTimes.prohibitedTime1End)}')}',
                          additionalStyle: TextStyle(
                            fontFamily: language == 'bn' ? '' : null,
                            color: Colors.white,
                          ),
                        ),
                        CustomText(
                          text: language == 'en'
                              ? 'Afternoon: ${formatPrayerTime(prayerTimes.prohibitedTime2Start)} - ${formatPrayerTime(prayerTimes.prohibitedTime2End)}'
                              : 'দুপুরঃ ${convertEnglishToBanglaNumber('${formatPrayerTime(prayerTimes.prohibitedTime2Start)} - ${formatPrayerTime(prayerTimes.prohibitedTime2End)}')}',
                          additionalStyle: TextStyle(
                            fontFamily: language == 'bn' ? '' : null,
                            color: Colors.white,
                          ),
                        ),
                        CustomText(
                          text: language == 'en'
                              ? 'Evening: ${formatPrayerTime(prayerTimes.prohibitedTime3Start)} - ${formatPrayerTime(prayerTimes.asrEnd)}'
                              : 'সন্ধ্যাঃ ${convertEnglishToBanglaNumber('${formatPrayerTime(prayerTimes.prohibitedTime3Start)} - ${formatPrayerTime(prayerTimes.asrEnd)}')}',
                          additionalStyle: TextStyle(
                            fontFamily: language == 'bn' ? '' : null,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
