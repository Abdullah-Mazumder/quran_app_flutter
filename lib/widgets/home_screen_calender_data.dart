import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/screenns/calendar/location_settings.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/calender/arabic_bangla_english_date.dart';
import 'package:al_quran/widgets/calender/prayer_and_remaing_times.dart';
import 'package:al_quran/widgets/calender/prohibited_prayer_times.dart';
import 'package:al_quran/widgets/calender/sehri_iftar_time.dart';
import 'package:al_quran/widgets/calender/sunset_sunrise.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_pressable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenCalenderData extends StatelessWidget {
  const HomeScreenCalenderData({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: StyledPressable(
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationSettings(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: calenderInfoProvider.address,
                      ),
                      CustomText(
                        text: calenderInfoProvider.country,
                        additionalStyle:
                            TextStyle(color: colors.txtColor.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 35,
                    color: colors.activeColor1,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: colors.activeColor2.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ArabicBanglaEnglishDate(),
              SunsetSunrise(),
            ],
          ),
        ),
        const PrayerAndRemaingTimes(),
        const ProhibitedPrayerTimes(),
        const SehriIftarTime(),
      ],
    );
  }
}
