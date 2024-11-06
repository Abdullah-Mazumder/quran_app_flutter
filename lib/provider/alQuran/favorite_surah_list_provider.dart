import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/material.dart';

class FavouriteSurahListProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<SingleSurahInfo> _data = [];

  get isLoading => _isLoading;
  get data => _data;

  Future<void> readSurahInfoWithSurahIds(List<int> ids) async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> surahLists =
        await QuranDBHelper.getSurahListsWithSurahIds(ids);

    _data = surahLists.map((e) => SingleSurahInfo.fromJson(e)).toList();
    _isLoading = false;

    notifyListeners();
  }
}
