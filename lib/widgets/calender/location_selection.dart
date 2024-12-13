import 'package:al_quran/models/calender/calender_data_model.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/calender_constants.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/searchable_selectbox_with_label.dart';
import 'package:al_quran/widgets/styled_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationSelection extends StatelessWidget {
  const LocationSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    List<District> districtsData =
        districts.map((json) => District.fromJson(json)).toList();

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.vertical,
          spacing: calenderInfoProvider.country == 'Bangladesh' ? -12 : -5,
          children: [
            calenderInfoProvider.country == 'Bangladesh'
                ? Row(
                    children: [
                      StyledCheckBox(
                        value:
                            calenderInfoProvider.locationMethod == 'district',
                        onChanged: () {},
                      ),
                      GestureDetector(
                        onTap: () {
                          calenderInfoProvider.setLocationMethod('district');
                        },
                        child: CustomText(
                            text: language == 'en'
                                ? 'District wise (Islamic Foundation)'
                                : 'জেলা ভিত্তিক (ইসলামিক ফাউন্ডেশন)'),
                      ),
                    ],
                  )
                : const SizedBox(),
            Row(
              children: [
                StyledCheckBox(
                  value: calenderInfoProvider.locationMethod == 'gps',
                  onChanged: () {},
                ),
                GestureDetector(
                  onTap: () {
                    calenderInfoProvider.setLocationMethod('gps');
                  },
                  child: CustomText(
                      text: language == 'en'
                          ? 'GPS location wise (Relatively accurate)'
                          : 'GPS লোকেশন ভিত্তিক (অপেক্ষাকৃত নির্ভুল)'),
                ),
              ],
            ),
          ],
        ),
        calenderInfoProvider.country == 'Bangladesh' &&
                calenderInfoProvider.locationMethod == 'district'
            ? SearchableSelectboxWithLabel(
                label: language == 'en'
                    ? 'Select Your District'
                    : 'জেলা নির্বাচন করুন',
                width: 170,
                height: 300,
                onChanged: (value) {
                  calenderInfoProvider.setDistrict(dis: value);
                },
                value: calenderInfoProvider.district,
                items: districtsData.map(
                  (item) {
                    return DropdownMenuItem<String>(
                      value: item.nameEn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: language == 'en' ? item.nameEn : item.nameBn,
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
              )
            : const SizedBox(),
        calenderInfoProvider.country == 'Bangladesh' &&
                calenderInfoProvider.locationMethod == 'gps'
            ? Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: colors.activeColor2, width: 3)),
                ),
                child: CustomText(
                  text: language == 'en'
                      ? 'First, you must have to select your country. Otherwise, the time calculation will not be correct.!'
                      : 'প্রথমত, আপনাকে অবশ্যই আপনার দেশ নির্বাচন করতে হবে। অন্যথায়, সময়ের হিসাব সঠিক হবে না।!',
                  additionalStyle: TextStyle(
                    color: colors.activeColor1,
                    fontFamily: '',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
