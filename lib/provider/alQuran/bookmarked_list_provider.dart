import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/material.dart';

class BookmarkedListProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<VerseInfo> _data = [];

  bool get isLoading => _isLoading;
  List<VerseInfo> get data => _data;

  Future<void> readVersesWithSurahIdAndVerseId(
      List<Map<String, int>> conditions) async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> verses =
        await QuranDBHelper.getVersesWithSurahIdAndVerseId(conditions);

    _data = verses.map((e) => VerseInfo.fromJson(e)).toList();
    _isLoading = false;

    notifyListeners();
  }
}
