import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/searchable_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:provider/provider.dart';

final List months = [
  {
    "value": "1",
    "labelEn": "January",
    "labelBn": "জানুয়ারি",
  },
  {
    "value": "2",
    "labelEn": "February",
    "labelBn": "ফেব্রুয়ারি",
  },
  {
    "value": "3",
    "labelEn": "March",
    "labelBn": "মার্চ",
  },
  {
    "value": "4",
    "labelEn": "April",
    "labelBn": "এপ্রিল",
  },
  {
    "value": "5",
    "labelEn": "May",
    "labelBn": "মে",
  },
  {
    "value": "6",
    "labelEn": "June",
    "labelBn": "জুন",
  },
  {
    "value": "7",
    "labelEn": "July",
    "labelBn": "জুলাই",
  },
  {
    "value": "8",
    "labelEn": "August",
    "labelBn": "অগাস্ট",
  },
  {
    "value": "9",
    "labelEn": "September",
    "labelBn": "সেপ্টেম্বর",
  },
  {
    "value": "10",
    "labelEn": "October",
    "labelBn": "অক্টোবর",
  },
  {
    "value": "11",
    "labelEn": "November",
    "labelBn": "নভেম্বর",
  },
  {
    "value": "12",
    "labelEn": "December",
    "labelBn": "ডিসেম্বর",
  }
];

final List years = [
  2021,
  2022,
  2023,
  2024,
  2025,
  2026,
  2027,
  2028,
  2029,
  2030,
  2031,
];

class MonthAndYearHadler extends StatelessWidget {
  const MonthAndYearHadler({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SearchableSelectbox(
          isSearchable: false,
          items: months.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: language == 'bn'
                          ? item['labelBn']!
                          : item['labelEn']!,
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
          onChanged: (value) {
            calenderInfoProvider.setMonth(int.parse(value!));
          },
          value: calenderInfoProvider.month.toString(),
        ),
        const SizedBox(width: 20),
        SearchableSelectbox(
          isSearchable: false,
          items: years.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item.toString(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: language == 'bn'
                          ? convertEnglishToBanglaNumber(item!)
                          : item.toString(),
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
          onChanged: (value) {
            calenderInfoProvider.setYear(int.parse(value!));
          },
          value: calenderInfoProvider.year.toString(),
        )
      ],
    );
  }
}
