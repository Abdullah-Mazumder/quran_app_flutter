import 'dart:async';
import 'dart:io';

import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:flutter/foundation.dart';

class DownloadedSurahProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<String> _surahNames = [];
  List<SingleSurahInfo> _surahList = [];

  bool get isLoadinng => _isLoading;
  List<String> get surahNames => _surahNames;
  List<SingleSurahInfo> get surahList => _surahList;

  Future<void> getDownloadedSurahNames(String storagePath) async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> surahLists = await QuranDBHelper.getSurahList();
    _surahList =
        surahLists.map((surah) => SingleSurahInfo.fromJson(surah)).toList();

    Directory directory = Directory(storagePath);
    List<String> nonEmptyFolders = [];

    if (await directory.exists()) {
      List<FileSystemEntity> entities = directory.listSync();
      for (FileSystemEntity entity in entities) {
        if (entity is Directory) {
          String folderName = entity.path.split('/').last;
          int surahId = int.parse(folderName.split('_')[1].toString());

          if (await _isDirectoryNotEmpty(entity, surahId)) {
            nonEmptyFolders.add(entity.path.split('/').last);
          }
        }
      }
    }

    _surahNames = nonEmptyFolders;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> _isDirectoryNotEmpty(Directory directory, int surahId) async {
    List<FileSystemEntity> entities = directory.listSync();
    int diff = _surahList[surahId - 1].totalAyah - entities.length;

    return diff == 0;
  }
}
