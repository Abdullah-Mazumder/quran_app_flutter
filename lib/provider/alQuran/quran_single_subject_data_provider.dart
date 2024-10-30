import 'dart:async';

import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:flutter/foundation.dart';

class QuranSingleSubjectDataProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<VersesWithSurahInfo> _data = [];
  String _htmlData = "";
  final Map<int, SingleSurahInfo> _surahLists = {};
  SingleSurahInfo? _currentSurahInfo;
  int _currentAyahIndex = 0;

  bool get isLoading => _isLoading;
  List<VersesWithSurahInfo> get data => _data;
  Map<int, SingleSurahInfo> get surahLists => _surahLists;
  int get currentAyahIndex => _currentAyahIndex;
  SingleSurahInfo? get currentSurahInfo => _currentSurahInfo;
  String get htmlData => _htmlData;

  Future<void> readAndSerializeQuranSubjectData(
    List<int> surahIds,
    List<Map<String, int>> verseConditions,
    String language,
    Map<String, dynamic> bookmarkedList,
    Map<String, dynamic> history,
  ) async {
    _isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> surahLists =
        await QuranDBHelper.getSurahListsWithSurahIds(surahIds);
    List<Map<String, dynamic>> verses =
        await QuranDBHelper.getVersesWithSurahIdAndVerseId(verseConditions);

    for (int i = 0; i < surahLists.length; i++) {
      int surahId = int.parse(surahLists[i]['id'].toString());
      _surahLists[surahId] = SingleSurahInfo.fromJson(surahLists[i]);
    }

    Map<int, dynamic> updatedVersesInObjForm = {};
    int versesLength = verses.length;
    for (int i = 0; i < versesLength; i++) {
      int surahId = verses[i]['surahId'];
      if (updatedVersesInObjForm[surahId] != null) {
        updatedVersesInObjForm[surahId].add(verses[i]);
      } else {
        updatedVersesInObjForm[surahId] = [verses[i]];
      }
    }

    final finalVerses = [];

    for (int surahId in updatedVersesInObjForm.keys) {
      final surahInfo =
          surahLists.firstWhere((surah) => surah['id'] == surahId);

      Map<String, dynamic> modifiedVerse =
          Map.from(updatedVersesInObjForm[surahId][0]);

      modifiedVerse['surahInfo'] = surahInfo;

      updatedVersesInObjForm[surahId][0] = modifiedVerse;

      finalVerses.addAll(updatedVersesInObjForm[surahId]);
    }

    _data = finalVerses.map((e) => VersesWithSurahInfo.fromJson(e)).toList();

    String html = "";
    for (int i = 0; i < versesLength; i++) {
      VersesWithSurahInfo verse = _data[i];

      html += '<div>';
      html += '<div class="verseInfo">';
      if (verse.surahInfo != null) {
        html +=
            '<div class="surahInfo"><span>${verse.surahInfo!.nameBn} ${verse.surahInfo!.meaningBn}</span></div>';
      }
      html +=
          '<div class="verseInfo2 surah_verse_${verse.surahId}_${verse.verseId}">';
      html +=
          '<div class="verseId info">${language == 'bn' ? 'আয়াত - ${convertEnglishToBanglaNumber(verse.verseId)}' : 'Ayah - ${verse.verseId}'}</div>';
      if (verse.isSajdahAyat == 1) {
        html +=
            '<div class="sajdahAyat info active">${language == 'bn' ? 'সিজদাহ আয়াত' : 'Sijdah Ayah'}</div>';
      }
      if (bookmarkedList['${verse.surahId}_${verse.verseId}'] != null) {
        html +=
            '<div class="bookmark info active">${language == 'bn' ? 'বুকমার্ক করা' : 'Bookmarked'}</div>';
      }
      if (history[verse.surahId.toString()] == verse.verseId.toString()) {
        html +=
            '<div class="lastRead info active">${language == 'bn' ? 'সর্বশেষ পঠিত' : 'Last Read'}</div>';
      }
      html += '</div></div>';

      html += '<div class="singleVerse verseText" data-id="$i">';
      html += '<div class="arabic">${verse.verseHtml}</div>';
      html += '<div class="pronunciation">${verse.pronunciation}</div>';
      html +=
          '<div class="taisirul">${verse.meaningBnTaisirul}</div><div class="ahbayan">${verse.meaningBnAhbayan}</div><div class="mujibur">${verse.meaningBnMujibur}</div><div class="english">${verse.meaningEn}</div>';
      html += '</div>';

      html += '<div class="verseAction">';
      html +=
          '<div class="bookmark icon" onClick="iconButtonClickHandler(this);toggleBookmark(this, ${verse.surahId}, ${verse.verseId})"><i class="${bookmarkedList['${verse.surahId}_${verse.verseId}'] != null ? 'fa-solid solid' : 'fa-regular'} fa-bookmark bookmark-${verse.verseId}"></i></div>';
      html +=
          '<div class="copy icon" onClick="iconButtonClickHandler(this);copy($i, this)"><i class="fa-regular fa-copy"></i></div>';
      html +=
          '<div class="book icon" onClick="iconButtonClickHandler(this);navigateToShortTafseer($i, ${verse.surahId})"><i class="fa-solid fa-book-open"></i></div>';

      html += '</div>';
    }

    _htmlData = html;
    _currentSurahInfo = _data[0].surahInfo;
    _isLoading = false;

    notifyListeners();
  }

  void setCurrentAyahIndex(int index) {
    if (index != currentAyahIndex) {
      _currentAyahIndex = index;

      final SingleSurahInfo surahInfo = _surahLists[_data[index].surahId]!;

      if (surahInfo.id != _currentSurahInfo!.id) {
        _currentSurahInfo = surahInfo;
      }

      notifyListeners();
    }
  }
}
