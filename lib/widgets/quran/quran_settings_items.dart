import 'package:al_quran/widgets/settings/audio_player_handler.dart';
import 'package:al_quran/widgets/settings/bangla_translator_handler.dart';
import 'package:al_quran/widgets/settings/bangla_transliteration_handler.dart';
import 'package:al_quran/widgets/settings/reciters_handler.dart';
import 'package:al_quran/widgets/settings/tajweed_handler.dart';
import 'package:al_quran/widgets/settings/tajweed_tags_handler.dart';
import 'package:al_quran/widgets/settings/theme_handler.dart';
import 'package:al_quran/widgets/settings/word_highlighter_handler.dart';
import 'package:al_quran/widgets/settings/arabic_text_size_handler.dart';
import 'package:al_quran/widgets/settings/bangla_text_size_handler.dart';
import 'package:al_quran/widgets/settings/bangla_translation_hadler.dart';
import 'package:al_quran/widgets/settings/english_text_size_handler.dart';
import 'package:al_quran/widgets/settings/english_translation_handler.dart';
import 'package:al_quran/widgets/settings/word_meaning_audio_handler.dart';
import 'package:flutter/material.dart';

class QuranSettings extends StatelessWidget {
  const QuranSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
        TajweedHandler(),
        TajweedTagsHandler(),
        BanglaTranslationHandler(),
        BanglaTransliterationHandler(),
        EnglishTranslationHandler(),
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
          height: 20,
        ),
      ],
    );
  }
}
