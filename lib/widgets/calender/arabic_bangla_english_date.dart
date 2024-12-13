import 'package:al_quran/state_helper/get_hijri_date.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/bongabdo.dart';
import 'package:al_quran/utils/calender_constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class ArabicBanglaEnglishDate extends StatelessWidget {
  const ArabicBanglaEnglishDate({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    HijriCalendar todayHijriDate = getHijriDate(context, DateTime.now());
    var todayBanglaDate = Bongabdo.now('new');

    DateTime today = DateTime.now();

    String hijriDate = "";
    if (language == 'en') {
      hijriDate =
          '${todayHijriDate.hDay} ${arabicMonthsEn[todayHijriDate.hMonth - 1]}';
    } else {
      hijriDate =
          '${convertEnglishToBanglaNumber(todayHijriDate.hDay)} ${arabicMonthsBn[todayHijriDate.hMonth - 1]}';
    }

    String englishDate = "";
    if (language == 'bn') {
      englishDate =
          '${weekDaysBn[today.weekday - 1]} - ${convertEnglishToBanglaNumber(today.day)} ${englishMonthsBn[today.month - 1]}';
    } else {
      englishDate =
          '${weekDaysEn[today.weekday - 1]} - ${today.day} ${englishMonthsEn[today.month - 1]}';
    }

    String banglaDate = "";
    if (language == 'bn') {
      banglaDate =
          '${convertEnglishToBanglaNumber(todayBanglaDate.hDay)} ${banglaMonthsBn[todayBanglaDate.hMonth - 1]} - ${banglaSeasonBn[todayBanglaDate.hSeason - 1]}কাল';
    } else {
      banglaDate =
          '${todayBanglaDate.hDay} ${banglaMonthsEn[todayBanglaDate.hMonth - 1]} - ${banglaSeasonEn[todayBanglaDate.hSeason - 1]}';
    }

    return Column(
      children: [
        CustomText(
          text: hijriDate,
          additionalStyle: TextStyle(
              color: Colors.white, fontFamily: language == 'bn' ? '' : null),
        ),
        CustomText(
          text: englishDate,
          additionalStyle: TextStyle(
              color: Colors.white, fontFamily: language == 'bn' ? '' : null),
        ),
        CustomText(
          text: banglaDate,
          additionalStyle: TextStyle(
              color: Colors.white, fontFamily: language == 'bn' ? '' : null),
        ),
      ],
    );
  }
}
