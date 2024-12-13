import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/screenns/calendar/location_settings.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/settings/hijri_date_adjust_handler.dart';
import 'package:al_quran/widgets/settings/hijri_date_cal_method_handler.dart';
import 'package:al_quran/widgets/settings/madhab_handler.dart';
import 'package:al_quran/widgets/settings/prayer_time_cal_mathod_handler.dart';
import 'package:al_quran/widgets/settings/warning_time_handler.dart';
import 'package:al_quran/widgets/styled_pressable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CalenderSettings extends StatelessWidget {
  const CalenderSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.gear,
              title: language == 'bn' ? "সেটিংস" : "Settings",
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
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
                                      text: language == 'en'
                                          ? 'Set your location'
                                          : 'লোকেশন সেট করুন',
                                    ),
                                    CustomText(
                                      text:
                                          '${calenderInfoProvider.address}, ${calenderInfoProvider.country}',
                                      additionalStyle: TextStyle(
                                          color:
                                              colors.txtColor.withOpacity(0.6)),
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
                      const MadhabHandler(),
                      const SizedBox(height: 10),
                      const PrayerTimeCalMathodHandler(),
                      const SizedBox(height: 20),
                      const WarningTimeHandler(),
                      const SizedBox(height: 20),
                      const HijriDateCalMethodHandler(),
                      const SizedBox(height: 20),
                      const HijriDateAdjustHandler(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
