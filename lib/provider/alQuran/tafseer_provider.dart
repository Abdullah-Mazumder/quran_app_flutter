import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/material.dart';

class TafseerProvider extends ChangeNotifier {
  bool _isLoading = true;
  Tafseer? _data;

  get isLoading => _isLoading;
  get data => _data;

  Future<void> readTafseerFromDB(
      {required int surahId, required int verseId}) async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> tafseer =
        await QuranDBHelper.getTafseerWithSurahIdAndVerseId(
            surahId: surahId, verseId: verseId);

    if (tafseer[0]['data'] == null) {
      _data = null;
    } else {
      _data = Tafseer.fromJson(tafseer[0]);
    }
    _isLoading = false;

    notifyListeners();
  }
}
