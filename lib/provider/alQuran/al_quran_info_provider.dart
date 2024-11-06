import 'dart:convert';

import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:just_audio/just_audio.dart';

class AlQuranInfoProvider extends ChangeNotifier {
  bool _isQuranSettingsBoxOpen = false;
  bool _isEnableTajweed = true;
  bool _isEnableTajweedTags = true;
  bool _isEnableAudioPlayer = true;
  bool _isPlayFullSurah = true;
  bool _isWordHighLight = true;
  bool _isEnableWordMeaningAudio = true;
  String _playbackSpeed = '1.00';
  String _ayahRepeats = '1';
  String _bnTranslator = "meaningBnAhbayan";
  String _reciter = "7~ar.alafasy";
  int _lastReadSurah = 1;
  InAppWebViewController? _surahWbController;
  Map<String, dynamic> _bookmarkedList = {};
  Map<String, dynamic> _favouriteSurahList = {};
  Map<String, dynamic> _history = {};

  bool get isQuranSettingsBoxOpen => _isQuranSettingsBoxOpen;
  bool get isEnableTajweed => _isEnableTajweed;
  bool get isEnableTajweedTags => _isEnableTajweedTags;
  bool get isEnableAudioPlayer => _isEnableAudioPlayer;
  bool get isWordHighLight => _isWordHighLight;
  bool get isEnableWordMeaningAudio => _isEnableWordMeaningAudio;
  String get bnTranslator => _bnTranslator;
  String get reciter => _reciter;
  String get playbackSpeed => _playbackSpeed;
  Map<String, dynamic> get bookmarkedList => _bookmarkedList;
  Map<String, dynamic> get favouriteSurahList => _favouriteSurahList;
  Map<String, dynamic> get history => _history;
  int get lastReadSurah => _lastReadSurah;
  bool get isPlayFullSurah => _isPlayFullSurah;
  String get ayahRepeats => _ayahRepeats;
  InAppWebViewController? get surahWbController => _surahWbController;

  AlQuranInfoProvider() {
    loadData();
  }

  loadData() {
    setIsEnableTajweed(isFirstTimeCall: true);
    setIsEnableTajweedTags(isFirstTimeCall: true);
    setIsEnableAudioPlayer(isFirstTimeCall: true);
    setBnTranslator();
    setReciter();
    updateBookmarkedList();
    updateHistoryAndLastReadSurah();
    setIsPlayFullSurah(isFirstTimeCall: true);
    setAyahRepeats();
    setPlaybackSpeed();
    updateFavouriteSurahList();
    setIsHighlightWord(isFirstTimeCall: true);
    setIsEnableWordMeaningAudio(isFirstTimeCall: true);
  }

  void quranSettingsBoxHandler({bool? value}) {
    if (value != null) {
      _isQuranSettingsBoxOpen = value;
      notifyListeners();
      return;
    }

    _isQuranSettingsBoxOpen = !_isQuranSettingsBoxOpen;
    notifyListeners();
  }

  void setWbController(InAppWebViewController? controller) {
    _surahWbController = controller;
  }

  void setIsEnableTajweed({bool? isFirstTimeCall}) async {
    dynamic isTajweedEnable = await getValueFromSharedPref(is_enable_tajweed);

    if (isFirstTimeCall == true) {
      if (isTajweedEnable == null) {
        _isEnableTajweed = true;
      } else if (isTajweedEnable.toString() == '1') {
        _isEnableTajweed = true;
      } else if (isTajweedEnable.toString() == '0') {
        _isEnableTajweed = false;
      }
    } else {
      if (isTajweedEnable == null) {
        _isEnableTajweed = false;
        setValueInSharedPref(is_enable_tajweed, '0');
      } else if (isTajweedEnable.toString() == '1') {
        _isEnableTajweed = false;
        setValueInSharedPref(is_enable_tajweed, '0');
      } else if (isTajweedEnable.toString() == '0') {
        _isEnableTajweed = true;
        setValueInSharedPref(is_enable_tajweed, '1');
      }
    }

    if (_surahWbController != null) {
      _surahWbController!
          .evaluateJavascript(source: 'toggleTajweed($_isEnableTajweed)');
    }

    notifyListeners();
  }

  void setIsEnableTajweedTags({bool? isFirstTimeCall}) async {
    dynamic isTajweedTagsEnable =
        await getValueFromSharedPref(is_enable_tajweed_tags);

    if (isFirstTimeCall == true) {
      if (isTajweedTagsEnable == null) {
        _isEnableTajweedTags = true;
      } else if (isTajweedTagsEnable.toString() == '1') {
        _isEnableTajweedTags = true;
      } else if (isTajweedTagsEnable.toString() == '0') {
        _isEnableTajweedTags = false;
      }
    } else {
      if (isTajweedTagsEnable == null) {
        _isEnableTajweedTags = false;
        setValueInSharedPref(is_enable_tajweed_tags, '0');
      } else if (isTajweedTagsEnable.toString() == '1') {
        _isEnableTajweedTags = false;
        setValueInSharedPref(is_enable_tajweed_tags, '0');
      } else if (isTajweedTagsEnable.toString() == '0') {
        _isEnableTajweedTags = true;
        setValueInSharedPref(is_enable_tajweed_tags, '1');
      }
    }

    notifyListeners();
  }

  void setIsPlayFullSurah({bool? isFirstTimeCall}) async {
    dynamic isFullSurahPlay = await getValueFromSharedPref(is_play_full_surah);

    if (isFirstTimeCall == true) {
      if (isFullSurahPlay == null) {
        _isPlayFullSurah = true;
      } else if (isFullSurahPlay.toString() == '1') {
        _isPlayFullSurah = true;
      } else if (isFullSurahPlay.toString() == '0') {
        _isPlayFullSurah = false;
      }
    } else {
      if (isFullSurahPlay == null) {
        _isPlayFullSurah = false;
        setValueInSharedPref(is_play_full_surah, '0');
      } else if (isFullSurahPlay.toString() == '1') {
        _isPlayFullSurah = false;
        setValueInSharedPref(is_play_full_surah, '0');
      } else if (isFullSurahPlay.toString() == '0') {
        _isPlayFullSurah = true;
        setValueInSharedPref(is_play_full_surah, '1');
      }
    }

    notifyListeners();
  }

  void setIsHighlightWord({bool? isFirstTimeCall}) async {
    dynamic wrdhighlight = await getValueFromSharedPref(is_word_highlight);

    if (isFirstTimeCall == true) {
      if (wrdhighlight == null) {
        _isWordHighLight = true;
      } else if (wrdhighlight.toString() == '1') {
        _isWordHighLight = true;
      } else if (wrdhighlight.toString() == '0') {
        _isWordHighLight = false;
      }
    } else {
      if (wrdhighlight == null) {
        _isWordHighLight = false;
        setValueInSharedPref(is_word_highlight, '0');
      } else if (wrdhighlight.toString() == '1') {
        _isWordHighLight = false;
        setValueInSharedPref(is_word_highlight, '0');
      } else if (wrdhighlight.toString() == '0') {
        _isWordHighLight = true;
        setValueInSharedPref(is_word_highlight, '1');
      }
    }

    notifyListeners();
  }

  void setIsEnableWordMeaningAudio({bool? isFirstTimeCall}) async {
    dynamic wordMeaningAudio =
        await getValueFromSharedPref(is_enable_word_meaning_audio);

    if (isFirstTimeCall == true) {
      if (wordMeaningAudio == null) {
        _isEnableWordMeaningAudio = true;
      } else if (wordMeaningAudio.toString() == '1') {
        _isEnableWordMeaningAudio = true;
      } else if (wordMeaningAudio.toString() == '0') {
        _isEnableWordMeaningAudio = false;
      }
    } else {
      if (wordMeaningAudio == null) {
        _isEnableWordMeaningAudio = false;
        setValueInSharedPref(is_enable_word_meaning_audio, '0');
      } else if (wordMeaningAudio.toString() == '1') {
        _isEnableWordMeaningAudio = false;
        setValueInSharedPref(is_enable_word_meaning_audio, '0');
      } else if (wordMeaningAudio.toString() == '0') {
        _isEnableWordMeaningAudio = true;
        setValueInSharedPref(is_enable_word_meaning_audio, '1');
      }
    }

    notifyListeners();
  }

  void setIsEnableAudioPlayer({bool? isFirstTimeCall}) async {
    dynamic isAudioPlEn = await getValueFromSharedPref(is_enable_audio_player);

    if (isFirstTimeCall == true) {
      if (isAudioPlEn == null) {
        _isEnableAudioPlayer = true;
      } else if (isAudioPlEn.toString() == '1') {
        _isEnableAudioPlayer = true;
      } else if (isAudioPlEn.toString() == '0') {
        _isEnableAudioPlayer = false;
      }
    } else {
      if (isAudioPlEn == null) {
        _isEnableAudioPlayer = false;
        setValueInSharedPref(is_enable_audio_player, '0');
      } else if (isAudioPlEn.toString() == '1') {
        _isEnableAudioPlayer = false;
        setValueInSharedPref(is_enable_audio_player, '0');
      } else if (isAudioPlEn.toString() == '0') {
        _isEnableAudioPlayer = true;
        setValueInSharedPref(is_enable_audio_player, '1');
      }
    }

    notifyListeners();
  }

  void setAyahRepeats({String? value}) async {
    if (value == null) {
      dynamic repeats = await getValueFromSharedPref(ayah_repeats);

      if (repeats == null) {
        _ayahRepeats = '1';
      } else {
        _ayahRepeats = repeats.toString();
      }
    } else {
      _ayahRepeats = value;
      setValueInSharedPref(ayah_repeats, value);
    }

    notifyListeners();
  }

  void setBnTranslator({String? value}) async {
    if (value == null) {
      dynamic translator = await getValueFromSharedPref(bangla_translator);

      if (translator == null) {
        _bnTranslator = 'meaningBnAhbayan';
      } else {
        _bnTranslator = translator.toString();
      }
    } else {
      _bnTranslator = value;
      setValueInSharedPref(bangla_translator, value);
    }

    if (_surahWbController != null) {
      _surahWbController!
          .evaluateJavascript(source: 'bnTranslatorHandler("$_bnTranslator")');
    }

    notifyListeners();
  }

  void setReciter({String? value}) async {
    if (value == null) {
      dynamic reciter = await getValueFromSharedPref(current_reciter);

      if (reciter == null) {
        _reciter = '7~ar.alafasy';
      } else {
        _reciter = reciter.toString();
      }
    } else {
      _reciter = value;
      setValueInSharedPref(current_reciter, value);
    }

    notifyListeners();
  }

  void setPlaybackSpeed({String? value, AudioPlayer? audioPlayer}) async {
    if (value == null) {
      dynamic speed = await getValueFromSharedPref(playback_speed);

      if (speed == null) {
        _playbackSpeed = '1.00';
      } else {
        _playbackSpeed = speed.toString();
      }
    } else {
      _playbackSpeed = value;

      if (audioPlayer != null) {
        await audioPlayer.setSpeed(double.parse(_playbackSpeed));
      }

      setValueInSharedPref(playback_speed, value);
    }

    notifyListeners();
  }

  void updateBookmarkedList(
      {int? surahId, int? verseId, String? language, Color? bgColor}) async {
    if (surahId == null) {
      dynamic str = await getValueFromSharedPref(bookmarked_list);

      if (str == null) {
        _bookmarkedList = {};
      } else {
        _bookmarkedList = json.decode(str.toString());
      }

      return;
    }

    String key = '${surahId}_$verseId';

    if (_bookmarkedList[key] == true) {
      _bookmarkedList.remove(key);
      if (language == "bn") {
        showToast("বুকমার্ক থেকে সরানো হয়েছে!", bgColor!);
      } else {
        showToast("Removed from bookmark!", bgColor!);
      }
    } else {
      _bookmarkedList[key] = true;
      if (language == "bn") {
        showToast("বুকমার্ক করা হয়েছে!", bgColor!);
      } else {
        showToast("Bookmarked!", bgColor!);
      }
    }

    notifyListeners();

    setValueInSharedPref(bookmarked_list, json.encode(_bookmarkedList));
  }

  void updateFavouriteSurahList(
      {int? surahId, String? language, Color? bgColor}) async {
    if (surahId == null) {
      dynamic str = await getValueFromSharedPref(favourite_surah_list);

      if (str == null) {
        _favouriteSurahList = {};
      } else {
        _favouriteSurahList = json.decode(str.toString());
      }

      return;
    }

    String key = '$surahId';

    if (_favouriteSurahList[key] == true) {
      _favouriteSurahList.remove(key);
      if (language == "bn") {
        showToast("প্রিয় সূরা তালিকা থেকে মুছে ফেলা হয়েছে!", bgColor!);
      } else {
        showToast("Removed from favorite surah list!", bgColor!);
      }
    } else {
      _favouriteSurahList[key] = true;
      if (language == "bn") {
        showToast("প্রিয় সূরা তালিকায় যোগ করা হয়েছে!", bgColor!);
      } else {
        showToast("Added to favorite surah list!", bgColor!);
      }
    }

    notifyListeners();

    setValueInSharedPref(
        favourite_surah_list, json.encode(_favouriteSurahList));
  }

  void updateHistoryAndLastReadSurah(
      {String? surahId,
      String? verseId,
      String? language,
      Color? bgColor}) async {
    if (surahId == null) {
      dynamic str1 = await getValueFromSharedPref(reading_history);
      dynamic str2 = await getValueFromSharedPref(last_read_surah);

      if (str2 == null) {
        _lastReadSurah = 1;
      } else {
        _lastReadSurah = int.parse(str2.toString());
      }

      if (str1 == null) {
        _history = {};
      } else {
        _history = json.decode(str1.toString());
      }

      return;
    }

    if (_history[surahId] != null &&
        int.parse(_history[surahId]) == int.parse(verseId!)) {
      _history.remove(surahId);

      Iterable<String> keys = _history.keys;

      if (keys.isNotEmpty) {
        _lastReadSurah = int.parse(keys.last);
      } else {
        _lastReadSurah = 1;
      }

      if (language == "bn") {
        showToast("হিসটোরি থেকে বাদ দেয়া হয়েছে!", bgColor!);
      } else {
        showToast("Removed From History!", bgColor!);
      }
    } else {
      _history[surahId] = verseId;
      _lastReadSurah = int.parse(surahId);

      if (language == "bn") {
        showToast("হিসটোরিতে সেভ করা হয়েছে!", bgColor!);
      } else {
        showToast("Saved In History!", bgColor!);
      }
    }

    notifyListeners();
    setValueInSharedPref(reading_history, json.encode(_history));
    setValueInSharedPref(last_read_surah, json.encode(_lastReadSurah));
  }
}
