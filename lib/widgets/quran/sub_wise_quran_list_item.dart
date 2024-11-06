import 'dart:async';

import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/quran_single_subject_data_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/screenns/quran/single_subject.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SubWiseQuranListItem extends StatelessWidget {
  final QuranSubject subject;
  final int id;
  const SubWiseQuranListItem(
      {super.key, required this.subject, required this.id});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Container(
      margin: EdgeInsets.only(
        top: 3,
        left: 5,
        right: 5,
        bottom: id == 124 ? 3 : 0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: colors.bgColor1,
        child: InkWell(
          onTap: () {
            Timer(const Duration(milliseconds: 300), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => QuranSingleSubjectDataProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => WordInfoProvider(),
                      ),
                    ],
                    child: SingleSubject(
                      locations: subject.location,
                      subject: subject.subject,
                    ),
                  ),
                ),
              );
            });
          },
          splashColor: colors.activeColor1.withOpacity(0.3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/surah_logo.png'),
                      CustomText(
                        text: convertEnglishToBanglaNumber(id),
                        additionalStyle: const TextStyle(
                          fontFamily: '',
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: subject.subject,
                        additionalStyle: TextStyle(
                          color: colors.activeColor1,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'আয়াত সংখ্যা - ',
                            additionalStyle: TextStyle(
                              color: colors.activeColor1,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          CustomText(
                            text: convertEnglishToBanglaNumber(
                              subject.location.split(', ').length,
                            ),
                            additionalStyle: TextStyle(
                              color: colors.activeColor1,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 41,
                  height: 41,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors.bgColor2,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.bookOpenReader,
                        size: 20,
                        color: colors.activeColor1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
