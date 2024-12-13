import 'dart:async';

import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/foundation.dart';

class WordInfoProvider extends ChangeNotifier {
  WordInfo? _wordInfo;

  WordInfo? get wordInfo => _wordInfo;

  Future<void> readWordInfoFromDB(String position) async {
    int surahId = int.parse(position.split('_')[0].toString());
    int verseId = int.parse(position.split('_')[1].toString());
    int wordId = int.parse(position.split('_')[2].toString());

    final word = await QuranDBHelper.getWordInfo(surahId, verseId, wordId);
    _wordInfo = WordInfo.fromJson(word);

    notifyListeners();

    Timer(const Duration(seconds: 5), () {
      _wordInfo = null;
      notifyListeners();
    });
  }

  void deleteWordInfo() {
    _wordInfo = null;
    notifyListeners();
  }
}
