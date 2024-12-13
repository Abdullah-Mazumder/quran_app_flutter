import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/foundation.dart';

class SubjectWiseQuranListProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<QuranSubject> _data = [];

  bool get isLoading => _isLoading;
  List<QuranSubject> get data => _data;

  Future<void> readQuranSubjectList() async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> subjects = await QuranDBHelper.getQuranSubjectList();

    _data = subjects.map((e) => QuranSubject.fromJson(e)).toList();
    _isLoading = false;

    notifyListeners();
  }
}
