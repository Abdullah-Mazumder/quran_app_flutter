import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerTimeCalMathodHandler extends StatelessWidget {
  const PrayerTimeCalMathodHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;
    final screenSize = MediaQuery.of(context).size;

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    final methods = [
      {"method": "Muslim World League", "methodId": '1'},
      {"method": "University Of Islamic Sciences, Karachi", "methodId": '2'},
      {"method": "Islamic Society of North America", "methodId": '3'},
      {"method": "Umm Al-Qura", "methodId": '4'},
      {"method": "Egyptian General Authority of Survey", "methodId": '5'},
      {
        "method": "Union des Organisations Islamiques de France",
        "methodId": '6'
      },
      {"method": "Majlis Ugama Islam Singapura", "methodId": '7'},
      {
        "method": "Spiritual Administration of Muslims of Russia",
        "methodId": '8'
      },
      {"method": "Jabatan Kemajuan Islam Malaysia", "methodId": '9'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: language == 'en'
              ? 'Select prayer time calculation method'
              : 'নামাজের সময় গণনা পদ্ধতি নির্বাচন করুন',
          additionalStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5),
        SearchableSelectbox(
          isSearchable: false,
          width: screenSize.width.toInt() - 28,
          height: 300,
          onChanged: (value) {
            calenderInfoProvider.setPrayerTimeCalMethod(value: value);
          },
          value: calenderInfoProvider.prayerTimeMethod,
          items: methods.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item['methodId'],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: item['method']!,
                      additionalStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'normal',
                        fontSize: 13.5,
                        color: colors.txtColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
