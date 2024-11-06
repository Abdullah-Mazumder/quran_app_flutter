import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/quran_single_subject_data_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/info_tag.dart';
import 'package:al_quran/widgets/quran/animated_quran_settings_box.dart';
import 'package:al_quran/widgets/quran/tajweed_tags.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SingleSubjectInfo extends StatelessWidget {
  final String subject;
  final bool isLoading;
  const SingleSubjectInfo(
      {super.key, required this.isLoading, required this.subject});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    final quranSingleSubjectDataProvider =
        Provider.of<QuranSingleSubjectDataProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);

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
                  width: 2,
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
                                  spacing: -3,
                                  children: [
                                    SizedBox(
                                      width: (70 / 100) * screenWidth,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: CustomText(
                                          text: subject,
                                          additionalStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Selector<QuranSingleSubjectDataProvider,
                                        SingleSurahInfo?>(
                                      selector: (_, provider) =>
                                          provider.currentSurahInfo,
                                      builder: (_, value, __) {
                                        return CustomText(
                                          text:
                                              '${value!.nameBn} ${value.meaningBn}',
                                          additionalStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '',
                                          ),
                                        );
                                      },
                                    ),
                                    Selector<QuranSingleSubjectDataProvider,
                                        SingleSurahInfo?>(
                                      selector: (_, provider) =>
                                          provider.currentSurahInfo,
                                      builder: (_, value, __) {
                                        return CustomText(
                                          text:
                                              'সূরা -  ${convertEnglishToBanglaNumber(value!.id)} আয়াত - ${convertEnglishToBanglaNumber(value.totalAyah)}',
                                          additionalStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: '',
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 6),
                                    Selector<QuranSingleSubjectDataProvider,
                                        int>(
                                      selector: (_, provider) =>
                                          provider.currentAyahIndex,
                                      builder: (_, value, __) {
                                        final verseInView =
                                            quranSingleSubjectDataProvider
                                                .data[value];

                                        return Wrap(
                                          spacing: 1,
                                          children: [
                                            InfoTag(
                                              label:
                                                  'পৃষ্ঠা-${convertEnglishToBanglaNumber(verseInView.page)}',
                                            ),
                                            InfoTag(
                                              label:
                                                  'পারা-${convertEnglishToBanglaNumber(verseInView.juz)}',
                                            ),
                                            InfoTag(
                                              label:
                                                  'রুকু-${convertEnglishToBanglaNumber(verseInView.ruku)}',
                                            ),
                                            InfoTag(
                                              label:
                                                  'মঞ্জিল-${convertEnglishToBanglaNumber(verseInView.manzil)}',
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
