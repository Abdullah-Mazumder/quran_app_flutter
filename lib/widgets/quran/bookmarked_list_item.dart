import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/screenns/quran/single_surah.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BookmarkedListItem extends HookWidget {
  final VerseInfo verse;
  final int id;
  final int totalVerse;
  const BookmarkedListItem(
      {super.key,
      required this.verse,
      required this.id,
      required this.totalVerse});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> bnTranslators = {
      'meaningBnAhbayan': verse.meaningBnAhbayan,
      'meaningBnMujibur': verse.meaningBnMujibur,
      'meaningBnTaisirul': verse.meaningBnTaisirul,
    };

    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);

    return Container(
      margin: EdgeInsets.only(
          left: 4, right: 4, top: 4, bottom: id == totalVerse ? 4 : 0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Material(
        color: colors.bgColor1,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => SingleSurahProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => SingleSurahInfoProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => WordInfoProvider(),
                    ),
                  ],
                  child: SingleSurah(
                    surahId: verse.surahId,
                    bookmarkedVerseId: verse.verseId,
                  ),
                ),
              ),
            );
          },
          splashColor: colors.activeColor1.withOpacity(0.2),
          child: Container(
            padding:
                const EdgeInsets.only(left: 5, right: 10, bottom: 5, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    alQuranInfoProvider.updateBookmarkedList(
                      surahId: verse.surahId,
                      verseId: verse.verseId,
                      language: language,
                      bgColor: colors.activeColor1,
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.solidBookmark,
                    color: colors.activeColor1,
                    size: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: verse.verseAr,
                          direction: TextDirection.rtl,
                          additionalStyle: TextStyle(
                            fontSize: 25,
                            fontFamily: indopakFont,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        text: bnTranslators[alQuranInfoProvider.bnTranslator]!,
                        additionalStyle: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: verse.meaningEn,
                        additionalStyle: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
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
