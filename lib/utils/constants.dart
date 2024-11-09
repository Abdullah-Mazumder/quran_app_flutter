// ignore_for_file: non_constant_identifier_names

import 'package:al_quran/models/app/dropdown_item_model.dart';

String regularFont = 'regularFont';
String semiBoldFont = 'semiBoldFont';
String boldFont = 'boldFont';
String indopakFont = 'indopakFont';

String arabic_text_size = 'arabicTextSize';
String bangla_text_size = 'banglaTextSize';
String english_text_size = 'englishTextSize';
String is_show_bangla_translation = 'isShowBbanglaTranslation';
String is_show_bangla_transliteration = 'isShowBbanglaTransliteration';
String is_show_english_translation = 'isShowEnglishTranslation';
String current_language = 'language';
String current_arabic_font = 'arabicFont';
String current_storage = 'storage';

String is_enable_tajweed = 'isEnableTajweed';
String is_enable_tajweed_tags = 'isEnableTajweedTags';
String is_enable_audio_player = 'isEnableAudioPlayer';
String bangla_translator = 'banglaTranslator';
String current_reciter = 'reciter';
String bookmarked_list = 'bookmarkedList';
String favourite_surah_list = 'favourSurahList';
String last_read_surah = 'lastReadSurah';
String reading_history = 'readingHistory';
String is_play_full_surah = 'isPlayFullSurah';
String is_word_highlight = 'isWordHighlight';
String ayah_repeats = 'ayahRepeats';
String playback_speed = 'playbackSpeed';
String is_enable_word_meaning_audio = 'wordMeaningAudio';

String fajr_start = 'fajrStart';
String fajr_end = 'fajrEnd';
String is_fajr_enabled = 'fajrEnabled';

String juhr_start = 'juhrStart';
String juhr_end = 'juhrEnd';
String is_juhr_enabled = 'juhrEnabled';

String asr_start = 'asrStart';
String asr_end = 'asrEnd';
String is_asr_enabled = 'asrEnabled';

String maghrib_start = 'maghribStart';
String maghrib_end = 'maghribEnd';
String is_maghrib_enabled = 'maghribEnabled';

String esa_start = 'esaStart';
String esa_end = 'esaEnd';
String is_esa_enabled = 'esaEnabled';

String juma_start = 'jumaStart';
String juma_end = 'jumaEnd';
String is_juma_enabled = 'jumaEnabled';

final List<DropdownItem> languages = [
  DropdownItem(value: "en", labelEn: "English", labelBn: "English"),
  DropdownItem(value: "bn", labelEn: "Bangla", labelBn: "বাংলা"),
];

final List<DropdownItem> storages = [
  DropdownItem(
      value: "rom", labelBn: "Device Momory", labelEn: "Device Momory"),
  DropdownItem(value: "sdCard", labelBn: "SD Card", labelEn: "SD Card"),
];

final List<DropdownItem> bnTranslators = [
  DropdownItem(
      value: 'meaningBnTaisirul', labelBn: 'তাইসীরুল', labelEn: 'Taisirul'),
  DropdownItem(
      value: 'meaningBnAhbayan', labelBn: 'আহবায়ান', labelEn: 'Ahbayan'),
  DropdownItem(
      value: 'meaningBnMujibur', labelBn: 'মুজিবুর', labelEn: 'Mujibur'),
];

final List<DropdownItem> reciters = [
  DropdownItem(
      value: "7~ar.alafasy",
      labelEn: "Mishar Rashid Al-Afasy",
      labelBn: "Mishar Rashid Al-Afasy"),
  DropdownItem(
      value: "3~ar.abdurrahmaansudais",
      labelEn: "Abdurrahmaan As-Sudais",
      labelBn: "Abdurrahmaan As-Sudais"),
  DropdownItem(
      value: "5~ar.hanirifai", labelEn: "Hani Rifai", labelBn: "Hani Rifai"),
  DropdownItem(
      value: "4~ar.shaatree",
      labelEn: "Abu Baka Al-Shatri",
      labelBn: "Abu Baka Al-Shatri"),
  DropdownItem(
      value: "2~ar.abdulbasitmurattal",
      labelEn: "AbdulBaset AbdulSamad",
      labelBn: "AbdulBaset AbdulSamad"),
  DropdownItem(
      value: "10~ar.saoodshuraym",
      labelEn: "Saud Ash-Shuraym",
      labelBn: "Saud Ash-Shuraym"),
  DropdownItem(value: "6~ar.husary", labelEn: "Husary", labelBn: "Husary"),
];

final List<DropdownItem> ayahRepeats = [
  DropdownItem(value: '1', labelEn: '1', labelBn: '১'),
  DropdownItem(value: '2', labelEn: '2', labelBn: '২'),
  DropdownItem(value: '3', labelEn: '3', labelBn: '৩'),
  DropdownItem(value: '4', labelEn: '4', labelBn: '৪'),
  DropdownItem(value: '5', labelEn: '5', labelBn: '৫'),
  DropdownItem(value: '6', labelEn: '6', labelBn: '৬'),
  DropdownItem(value: '7', labelEn: '7', labelBn: '৭'),
  DropdownItem(value: '8', labelEn: '8', labelBn: '৮'),
  DropdownItem(value: '9', labelEn: '9', labelBn: '৯'),
  DropdownItem(value: '10', labelEn: '10', labelBn: '১০'),
  DropdownItem(value: '11', labelEn: '11', labelBn: '১১'),
  DropdownItem(value: '12', labelEn: '12', labelBn: '১২'),
  DropdownItem(value: '13', labelEn: '13', labelBn: '১৩'),
  DropdownItem(value: '14', labelEn: '14', labelBn: '১৪'),
  DropdownItem(value: '15', labelEn: '15', labelBn: '১৫'),
  DropdownItem(value: '16', labelEn: '16', labelBn: '১৬'),
  DropdownItem(value: '17', labelEn: '17', labelBn: '১৭'),
  DropdownItem(value: '18', labelEn: '18', labelBn: '১৮'),
  DropdownItem(value: '19', labelEn: '19', labelBn: '১৯'),
  DropdownItem(value: '20', labelEn: '20', labelBn: '২০'),
];

final List<DropdownItem> playbackSpeeds = [
  DropdownItem(value: '0.50', labelEn: '0.50', labelBn: '০.৫০'),
  DropdownItem(value: '0.55', labelEn: '0.55', labelBn: '০.৫৫'),
  DropdownItem(value: '0.60', labelEn: '0.60', labelBn: '০.৬০'),
  DropdownItem(value: '0.65', labelEn: '0.65', labelBn: '০.৬৫'),
  DropdownItem(value: '0.70', labelEn: '0.70', labelBn: '০.৭০'),
  DropdownItem(value: '0.75', labelEn: '0.75', labelBn: '০.৭৫'),
  DropdownItem(value: '0.80', labelEn: '0.80', labelBn: '০.৮০'),
  DropdownItem(value: '0.85', labelEn: '0.85', labelBn: '০.৮৫'),
  DropdownItem(value: '0.90', labelEn: '0.90', labelBn: '০.৯০'),
  DropdownItem(value: '0.95', labelEn: '0.95', labelBn: '০.৯৫'),
  DropdownItem(value: '1.00', labelEn: 'Normal', labelBn: 'স্বাভাবিক'),
  DropdownItem(value: '1.05', labelEn: '1.05', labelBn: '১.০৫'),
  DropdownItem(value: '1.10', labelEn: '1.10', labelBn: '১.১০'),
  DropdownItem(value: '1.15', labelEn: '1.15', labelBn: '১.১৫'),
  DropdownItem(value: '1.20', labelEn: '1.20', labelBn: '১.২০'),
  DropdownItem(value: '1.25', labelEn: '1.25', labelBn: '১.২৫'),
  DropdownItem(value: '1.30', labelEn: '1.30', labelBn: '১.৩০'),
  DropdownItem(value: '1.35', labelEn: '1.35', labelBn: '১.৩৫'),
  DropdownItem(value: '1.40', labelEn: '1.40', labelBn: '১.৪০'),
  DropdownItem(value: '1.45', labelEn: '1.45', labelBn: '১.৪৫'),
  DropdownItem(value: '1.50', labelEn: '1.50', labelBn: '১.৫০'),
];

final List<DropdownItem> themes = [
  DropdownItem(value: 'system', labelEn: 'System', labelBn: 'সিস্টেম'),
  DropdownItem(value: 'dark', labelEn: 'Dark', labelBn: 'ডার্ক'),
  DropdownItem(value: 'light', labelEn: 'Light', labelBn: 'লাইট'),
  DropdownItem(value: 'milk', labelEn: 'Milk', labelBn: 'মিল্ক'),
  DropdownItem(value: 'blue', labelEn: 'Blue', labelBn: 'ব্লু'),
  DropdownItem(value: 'night', labelEn: 'Night', labelBn: 'নাইট'),
];

final Map<String, String> reciterNames = {
  "7~ar.alafasy": "Rashid Al-Afasy",
  "5~ar.hanirifai": "Hani Rifai",
  "4~ar.shaatree": "Abu Baka Al-Shatri",
  "2~ar.abdulbasitmurattal": "AbdulBaset AbdulSamad",
  "10~ar.saoodshuraym": "Saud Ash-Shuraym",
};
