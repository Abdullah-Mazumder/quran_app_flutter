import 'package:al_quran/models/calender/calender_data_model.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/calender_constants.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountrySelection extends StatelessWidget {
  const CountrySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    List<Country> countriesData =
        countries.map((json) => Country.fromJson(json)).toList();
    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: language == 'en' ? 'Select Your Country' : 'দেশ নির্বাচন করুন',
          additionalStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5),
        SearchableSelectbox(
          width: screenSize.width.toInt() - 20,
          height: 500,
          onChanged: (value) {
            calenderInfoProvider.setCountry(cntry: value);
          },
          value: calenderInfoProvider.country,
          items: countriesData.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item.country,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: item.country,
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
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            border:
                Border(left: BorderSide(color: colors.activeColor2, width: 3)),
          ),
          child: CustomText(
            text: language == 'en'
                ? 'Default City: ${calenderInfoProvider.defaultCity}'
                : 'ডিফল্ট শহরঃ ${calenderInfoProvider.defaultCity}',
            additionalStyle: TextStyle(color: colors.txtColor.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }
}
