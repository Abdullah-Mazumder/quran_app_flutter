import 'dart:io';

import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

class AppInfoProvider extends ChangeNotifier {
  int _arabicTextSize = 20;
  int _banglaTextSize = 14;
  int _englishTextSize = 14;
  bool _isShowBanglaTranslation = true;
  bool _isShowBanglaTransliteration = true;
  bool _isShowEnglishTranslation = true;
  String _language = 'bn';
  // String _arabicFont = 'noorehuda';
  String _storage = 'rom';
  String? _storagePath;
  InAppWebViewController? _surahWbController;

  AppInfoProvider() {
    loadData();
  }

  get arabicTextSize => _arabicTextSize;
  get banglaTextSize => _banglaTextSize;
  get englishTextSize => _englishTextSize;
  get isShowBanglaTranslation => _isShowBanglaTranslation;
  get isShowBanglaTransliteration => _isShowBanglaTransliteration;
  get isShowEnglishTranslation => _isShowEnglishTranslation;
  get language => _language;
  // get arabicFont => _arabicFont;
  get storage => _storage;
  get storagePath => _storagePath;
  InAppWebViewController? get surahWbController => _surahWbController;

  loadData() {
    setArabicTextSize();
    setBanglaTextSize();
    setEnglishTextSize();
    setIsShowBanglaTranslation(isFirstTimeCall: true);
    setIsShowBanglaTransliteration(isFirstTimeCall: true);
    setIsShowEnglishTranslation(isFirstTimeCall: true);
    setLanguage();
    // setArabicFont();
    setStorage();
  }

  void setWbController(InAppWebViewController? controller) {
    _surahWbController = controller;
  }

  void setArabicTextSize({int? size}) async {
    if (size != null) {
      _arabicTextSize = size;
    } else {
      dynamic textSize = await getValueFromSharedPref(arabic_text_size);

      if (textSize == null) {
        _arabicTextSize = 25;
      } else {
        try {
          int txtSize = int.parse(textSize.toString());
          _arabicTextSize = txtSize;
        } catch (e) {
          _arabicTextSize = 25;
        }
      }
    }

    if (_surahWbController != null) {
      _surahWbController!.evaluateJavascript(
          source: 'arabicTextSizeHandler($_arabicTextSize);');
    }

    notifyListeners();
  }

  void setBanglaTextSize({int? size}) async {
    if (size != null) {
      _banglaTextSize = size;
    } else {
      dynamic textSize = await getValueFromSharedPref(bangla_text_size);

      if (textSize == null) {
        _banglaTextSize = 16;
      } else {
        try {
          int txtSize = int.parse(textSize.toString());
          _banglaTextSize = txtSize;
        } catch (e) {
          _banglaTextSize = 16;
        }
      }
    }

    if (_surahWbController != null) {
      _surahWbController!.evaluateJavascript(
          source: 'banglaTextSizeHandler($_banglaTextSize);');
    }

    notifyListeners();
  }

  void setEnglishTextSize({int? size}) async {
    if (size != null) {
      _englishTextSize = size;
    } else {
      dynamic textSize = await getValueFromSharedPref(english_text_size);

      if (textSize == null) {
        _englishTextSize = 16;
      } else {
        try {
          int txtSize = int.parse(textSize.toString());
          _englishTextSize = txtSize;
        } catch (e) {
          _englishTextSize = 16;
        }
      }
    }

    if (_surahWbController != null) {
      _surahWbController!.evaluateJavascript(
          source: 'englishTextSizeHandler($_englishTextSize);');
    }

    notifyListeners();
  }

  void setIsShowBanglaTranslation({bool? isFirstTimeCall}) async {
    dynamic isShowBanglaTrans =
        await getValueFromSharedPref(is_show_bangla_translation);

    if (isFirstTimeCall == true) {
      if (isShowBanglaTrans == null) {
        _isShowBanglaTranslation = true;
      } else if (isShowBanglaTrans.toString() == '1') {
        _isShowBanglaTranslation = true;
      } else if (isShowBanglaTrans.toString() == '0') {
        _isShowBanglaTranslation = false;
      }
    } else {
      if (isShowBanglaTrans == null) {
        _isShowBanglaTranslation = false;
        setValueInSharedPref(is_show_bangla_translation, '0');
      } else if (isShowBanglaTrans.toString() == '1') {
        _isShowBanglaTranslation = false;
        setValueInSharedPref(is_show_bangla_translation, '0');
      } else if (isShowBanglaTrans.toString() == '0') {
        _isShowBanglaTranslation = true;
        setValueInSharedPref(is_show_bangla_translation, '1');
      }
    }

    if (_surahWbController != null) {
      _surahWbController!
          .evaluateJavascript(source: 'isShowBanglaTranslation();');
    }

    notifyListeners();
  }

  void setIsShowBanglaTransliteration({bool? isFirstTimeCall}) async {
    dynamic isShowBanglaTranslite =
        await getValueFromSharedPref(is_show_bangla_transliteration);

    if (isFirstTimeCall == true) {
      if (isShowBanglaTranslite == null) {
        _isShowBanglaTransliteration = true;
      } else if (isShowBanglaTranslite.toString() == '1') {
        _isShowBanglaTransliteration = true;
      } else if (isShowBanglaTranslite.toString() == '0') {
        _isShowBanglaTransliteration = false;
      }
    } else {
      if (isShowBanglaTranslite == null) {
        _isShowBanglaTransliteration = false;
        setValueInSharedPref(is_show_bangla_transliteration, '0');
      } else if (isShowBanglaTranslite.toString() == '1') {
        _isShowBanglaTransliteration = false;
        setValueInSharedPref(is_show_bangla_transliteration, '0');
      } else if (isShowBanglaTranslite.toString() == '0') {
        _isShowBanglaTransliteration = true;
        setValueInSharedPref(is_show_bangla_transliteration, '1');
      }
    }

    if (_surahWbController != null) {
      _surahWbController!
          .evaluateJavascript(source: 'isShowBanglaTransliteration();');
    }

    notifyListeners();
  }

  void setIsShowEnglishTranslation({bool? isFirstTimeCall}) async {
    dynamic isShowEnglishTrans =
        await getValueFromSharedPref(is_show_english_translation);

    if (isFirstTimeCall == true) {
      if (isShowEnglishTrans == null) {
        _isShowEnglishTranslation = true;
      } else if (isShowEnglishTrans.toString() == '1') {
        _isShowEnglishTranslation = true;
      } else if (isShowEnglishTrans.toString() == '0') {
        _isShowEnglishTranslation = false;
      }
    } else {
      if (isShowEnglishTrans == null) {
        _isShowEnglishTranslation = false;
        setValueInSharedPref(is_show_english_translation, '0');
      } else if (isShowEnglishTrans.toString() == '1') {
        _isShowEnglishTranslation = false;
        setValueInSharedPref(is_show_english_translation, '0');
      } else if (isShowEnglishTrans.toString() == '0') {
        _isShowEnglishTranslation = true;
        setValueInSharedPref(is_show_english_translation, '1');
      }
    }

    if (_surahWbController != null) {
      _surahWbController!
          .evaluateJavascript(source: 'isShowEnglishTranslation();');
    }

    notifyListeners();
  }

  void setLanguage({String? value}) async {
    if (value == null) {
      dynamic lang = await getValueFromSharedPref(current_language);

      if (lang == null) {
        _language = 'bn';
      } else {
        _language = lang.toString();
      }
    } else {
      _language = value;
      setValueInSharedPref(current_language, value);
    }

    notifyListeners();
  }

  // void setArabicFont({String? value}) async {
  //   if (value == null) {
  //     dynamic font = await getValueFromSharedPref(current_arabic_font);

  //     if (font == null) {
  //       _arabicFont = 'noorehuda';
  //     } else {
  //       _arabicFont = font.toString();
  //     }
  //   } else {
  //     _arabicFont = value;
  //     setValueInSharedPref(current_arabic_font, value);
  //   }

  //   if (_surahWbController != null) {
  //     _surahWbController!
  //         .evaluateJavascript(source: 'arabicFontHandler("$_arabicFont");');
  //   }

  //   notifyListeners();
  // }

  void setStorage({
    String? value,
    Color? bgColor,
  }) async {
    List<Directory>? externalDirs = await getExternalStorageDirectories();

    if (value == null) {
      dynamic disk = await getValueFromSharedPref(current_storage);

      if (disk == null || disk.toString() == 'rom') {
        _storage = 'rom';
        _storagePath = externalDirs![0].path;
      } else {
        if (externalDirs!.length == 1) {
          _storage = 'rom';
          _storagePath = externalDirs[0].path;
        } else if (externalDirs.length == 2) {
          _storage = disk.toString();
          _storagePath = externalDirs[1].path;
        }
      }
    } else {
      if (value == 'rom') {
        _storage = value;
        _storagePath = externalDirs![0].path;
      } else {
        if (externalDirs!.length == 1) {
          _storage = 'rom';
          _storagePath = externalDirs[0].path;

          showToast(
              _language == 'bn'
                  ? 'মেমোরি কার্ড পাওয়া যায় নি!'
                  : 'Memory Card Not Found!',
              bgColor!);
        } else if (externalDirs.length == 2) {
          _storage = value;
          _storagePath = externalDirs[1].path;
        }
      }
      setValueInSharedPref(current_storage, _storage);
    }

    notifyListeners();
  }
}
