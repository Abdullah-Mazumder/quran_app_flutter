import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarningTimeHandler extends StatelessWidget {
  const WarningTimeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    final times = [
      0,
      1,
      2,
      3,
      4,
      5,
    ];

    return SearchableSelectboxWithLabel(
      width: 100,
      pl: 15,
      pr: 15,
      label: language == 'en'
          ? 'Warning Time (Before Maghrib)'
          : 'সতর্কতামূলক সময় (মাগরিবের আগে)',
      isSearchable: false,
      height: 300,
      onChanged: (value) {
        calenderInfoProvider.setWarningTime(value: int.parse(value!));
      },
      value: calenderInfoProvider.warningTimeBeforeMag.toString(),
      items: times.map(
        (item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: item.toString(),
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
