import 'dart:async';

import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/mushaf_quran_surah_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/screenns/quran/mushaf_quran_surah.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/quran/madina_logo.dart';
import 'package:al_quran/widgets/quran/mecca_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MushafQuranListItem extends StatefulWidget {
  final SingleSurahInfo surah;
  const MushafQuranListItem({
    super.key,
    required this.surah,
  });

  @override
  State<MushafQuranListItem> createState() => _MushafQuranListItemState();
}

class _MushafQuranListItemState extends State<MushafQuranListItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);

    final surah = widget.surah;

    String txt1 = language == 'bn'
        ? '${surah.nameBn} - ${surah.meaningBn}'
        : '${surah.nameEn} - ${surah.meaningEn}';

    String txt2 = language == 'bn' ? 'আয়াত সংখ্যা - ' : 'Total Ayah - ';

    return Container(
      margin: EdgeInsets.only(
        top: 3,
        left: 5,
        right: 5,
        bottom: widget.surah.id == 114 ? 3 : 0,
      ),
      decoration: BoxDecoration(
        color: colors.bgColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: colors.bgColor1,
        child: InkWell(
          splashColor: colors.activeColor1.withOpacity(0.2),
          onTap: () {
            Timer(const Duration(milliseconds: 200), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => MushafQuranSurahProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => SingleSurahInfoProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => WordInfoProvider(),
                      ),
                    ],
                    child: MushafQuranSurah(
                      surahId: surah.id,
                    ),
                  ),
                ),
              );
            });
          },
          child: Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 0),
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
                        text: language == 'en'
                            ? surah.id.toString()
                            : convertEnglishToBanglaNumber(surah.id),
                        additionalStyle: const TextStyle(
                          fontFamily: '',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: surah.nameAr,
                        additionalStyle: TextStyle(
                          color: colors.activeColor1,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: indopakFont,
                        ),
                      ),
                      CustomText(
                        text: txt1,
                        additionalStyle: TextStyle(
                          color: colors.activeColor1,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: txt2,
                            additionalStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomText(
                            text: language == 'bn'
                                ? convertEnglishToBanglaNumber(surah.totalAyah)
                                : surah.totalAyah.toString(),
                            additionalStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "",
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: surah.locationEn == "Makkih"
                                ? (language == 'bn' ? "মাক্কী" : "Makki")
                                : (language == 'bn' ? "মাদানী" : "Madani"),
                            additionalStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Selector<AlQuranInfoProvider, dynamic>(
                  selector: (_, provider) =>
                      provider.history[surah.id.toString()],
                  builder: (_, value, __) {
                    if (value == null) {
                      return const SizedBox();
                    }

                    return FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      size: 16,
                      color: colors.activeColor1,
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                surah.locationEn == 'Makkih'
                    ? const MeccaLogo()
                    : const MadinaLogo(),
                const SizedBox(
                  width: 7,
                ),
                IconButton(
                  onPressed: () {
                    alQuranInfoProvider.updateFavouriteSurahList(
                      surahId: surah.id,
                      language: language,
                      bgColor: colors.activeColor1,
                    );
                  },
                  icon: FaIcon(
                    alQuranInfoProvider
                                .favouriteSurahList[surah.id.toString()] ==
                            true
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    size: 18,
                    color: colors.activeColor1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
