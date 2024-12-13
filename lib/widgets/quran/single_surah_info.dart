import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/info_tag.dart';
import 'package:al_quran/widgets/quran/animated_quran_settings_box.dart';
import 'package:al_quran/widgets/quran/tajweed_tags.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SingleSurahInformation extends StatelessWidget {
  final SingleSurahInfo? surahInfo;
  final bool isLoading;
  final List<VerseInfo> fullSurah;

  const SingleSurahInformation({
    super.key,
    required this.surahInfo,
    required this.isLoading,
    required this.fullSurah,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);

    String text1_1 = '';
    String text1_2 = '';
    String txt2 = '';

    if (isLoading == false && surahInfo != null) {
      text1_1 = language == 'bn' ? surahInfo!.nameBn : surahInfo!.nameEn;
      text1_2 = language == 'bn' ? surahInfo!.meaningBn : surahInfo!.meaningEn;

      txt2 = language == 'en'
          ? 'Surah - ${surahInfo!.id} Ayah - ${surahInfo!.totalAyah}'
          : 'সূরা - ${convertEnglishToBanglaNumber(surahInfo!.id)} আয়াত - ${convertEnglishToBanglaNumber(surahInfo!.totalAyah)}';
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: colors.bgColor1,
      child: Column(
        children: [
          const AnimatedQuranSettingsBox(),
          Container(
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colors.activeColor1,
                  width: 1.5,
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (12 / 100) * screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              appInfoProvider.surahWbController!
                                  .evaluateJavascript(source: 'clearBody();');
                              Navigator.pop(context);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 22,
                              color: colors.txtColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: (70 / 100) * screenWidth,
                      child: isLoading == true
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: language == 'en' ? -1 : -4,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: (70 / 100) * screenWidth),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 5,
                                        children: [
                                          CustomText(
                                            text: text1_1,
                                            additionalStyle: const TextStyle(
                                              fontFamily: '',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1.5),
                                            child: CustomText(
                                              text: text1_2,
                                              additionalStyle: const TextStyle(
                                                fontFamily: '',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomText(
                                      text: txt2,
                                      additionalStyle: const TextStyle(
                                        fontFamily: '',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: language == 'en' ? 5 : 10,
                                    ),
                                    Selector<SingleSurahInfoProvider, int>(
                                      selector: (_, provider) =>
                                          provider.ayahInViewIndex,
                                      builder: (_, value, __) {
                                        final verseInView = fullSurah[value];

                                        return Wrap(
                                          spacing: 1,
                                          children: [
                                            InfoTag(
                                              label: language == 'bn'
                                                  ? 'পৃষ্ঠা-${convertEnglishToBanglaNumber(verseInView.page)}'
                                                  : 'Page-${verseInView.page}',
                                            ),
                                            InfoTag(
                                              label: language == 'bn'
                                                  ? 'পারা-${convertEnglishToBanglaNumber(verseInView.juz)}'
                                                  : 'Para-${verseInView.juz}',
                                            ),
                                            InfoTag(
                                              label: language == 'bn'
                                                  ? 'রুকু-${convertEnglishToBanglaNumber(verseInView.ruku)}'
                                                  : 'Ruku-${verseInView.ruku}',
                                            ),
                                            InfoTag(
                                              label: language == 'bn'
                                                  ? 'মঞ্জিল-${convertEnglishToBanglaNumber(verseInView.manzil)}'
                                                  : 'Manzil-${verseInView.manzil}',
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      width: (12 / 100) * screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              alQuranInfoProvider.quranSettingsBoxHandler();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.sliders,
                              size: 22,
                              color: colors.txtColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: (90 / 100) * screenWidth,
                  child: isLoading == true ? Container() : const TajweedTags(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
