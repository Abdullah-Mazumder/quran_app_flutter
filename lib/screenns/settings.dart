import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/settings/arabic_text_size_handler.dart';
import 'package:al_quran/widgets/settings/audio_player_handler.dart';
import 'package:al_quran/widgets/settings/bangla_text_size_handler.dart';
import 'package:al_quran/widgets/settings/bangla_translation_hadler.dart';
import 'package:al_quran/widgets/settings/bangla_translator_handler.dart';
import 'package:al_quran/widgets/settings/english_text_size_handler.dart';
import 'package:al_quran/widgets/settings/english_translation_handler.dart';
import 'package:al_quran/widgets/settings/language_handler.dart';
import 'package:al_quran/widgets/settings/reciters_handler.dart';
import 'package:al_quran/widgets/settings/storage_hadler.dart';
import 'package:al_quran/widgets/settings/tajweed_handler.dart';
import 'package:al_quran/widgets/settings/theme_handler.dart';
import 'package:al_quran/widgets/settings/word_highlighter_handler.dart';
import 'package:al_quran/widgets/settings/word_meaning_audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Selector<AppInfoProvider, String>(
              builder: (context, value, child) {
                return CustomAppBar(
                  icon: FontAwesomeIcons.gear,
                  title: value == 'bn' ? "সেটিংস" : "Settings",
                );
              },
              selector: (context, provider) => provider.language,
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ArabicTextSizeHandler(),
                      SizedBox(
                        height: 20,
                      ),
                      BanglaTextSizeHandler(),
                      SizedBox(
                        height: 20,
                      ),
                      EnglishTextSizeHandler(),
                      SizedBox(
                        height: 10,
                      ),
                      BanglaTranslationHandler(),
                      EnglishTranslationHandler(),
                      TajweedHandler(),
                      AudioPlayerHandler(),
                      WordHighlighterHandler(),
                      WordMeaningAudioHandler(),
                      SizedBox(
                        height: 5,
                      ),
                      ThemeHandler(),
                      SizedBox(
                        height: 10,
                      ),
                      BnTranslatorHandler(),
                      SizedBox(
                        height: 10,
                      ),
                      RecitersHandler(),
                      SizedBox(
                        height: 10,
                      ),
                      LanguageHandler(),
                      SizedBox(
                        height: 10,
                      ),
                      StorageHandler(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
