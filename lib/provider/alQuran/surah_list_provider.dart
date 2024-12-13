import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/foundation.dart';

class SurahListProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<SingleSurahInfo> _data = [];

  bool get isLoading => _isLoading;
  List<SingleSurahInfo> get data => _data;

  void readSurahListFromDB() async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> surahList = await QuranDBHelper.getSurahList();

    _data = surahList.map((json) => SingleSurahInfo.fromJson(json)).toList();
    _isLoading = false;

    await Future.delayed(Duration.zero);

    notifyListeners();
  }
}
