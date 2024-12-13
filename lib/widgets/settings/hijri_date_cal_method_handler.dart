import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HijriDateCalMethodHandler extends StatelessWidget {
  const HijriDateCalMethodHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    final times = [
      {"value": "midnight", "labelEn": "At 12am", "labelBn": "রাত ১২টায়"},
      {
        "value": "sunset",
        "labelEn": "At Sunset Time",
        "labelBn": "সূর্যাস্তের সময়"
      },
    ];

    return SearchableSelectboxWithLabel(
      pl: 15,
      pr: 15,
      label: language == 'en'
          ? 'Hijri Date Will Change'
          : 'হিজরী তারিখ পরিবর্তন হবে',
      isSearchable: false,
      width: 170,
      height: 300,
      onChanged: (value) {
        calenderInfoProvider.setHijriChange(value: value);
      },
      value: calenderInfoProvider.hijriChange,
      items: times.map(
        (item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: language == 'en' ? item['labelEn']! : item['labelBn']!,
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
    );
  }
}
