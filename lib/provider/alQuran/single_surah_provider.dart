import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:flutter/foundation.dart';

class SingleSurahProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<VerseInfo> _fullSurah = [];
  SingleSurahInfo? _surahInfo;
  String _surahHtml = "";
  int _wbProgress = 0;

  bool get isLoading => _isLoading;
  List<VerseInfo> get fullSurah => _fullSurah;
  SingleSurahInfo? get surahInfo => _surahInfo;
  String get surahHtml => _surahHtml;
  int get wbProgress => _wbProgress;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void readFullSurahWithIDFromDB(
    int id,
    String language,
    Map<String, dynamic> bookmarkedList,
    Map<String, dynamic> history,
  ) async {
    isLoading = true;

    List<Map<String, dynamic>> allVerses =
        await QuranDBHelper.getAllVerseOfASurahWithSurahID(id);
    Map<String, dynamic> surahInformation =
        (await QuranDBHelper.getSurahListsWithSurahIds([id]))[0];

    _fullSurah = allVerses.map((json) => VerseInfo.fromJson(json)).toList();
    _surahInfo = SingleSurahInfo.fromJson(surahInformation);
    String html = "";

    for (var element in _fullSurah) {
      html +=
          '<div class="singleVerse verse-${element.verseId}" data-id="${element.verseId}"><div class="verseInfo verseId-${element.verseId}">';
      html +=
          '<div class="verseId info">${language == 'bn' ? 'আয়াত - ${convertEnglishToBanglaNumber(element.verseId)}' : 'Ayah - ${element.verseId}'}</div>';
      if (element.isSajdahAyat == 1) {
        html +=
            '<div class="sajdahAyat info active">${language == 'bn' ? 'সিজদাহ আয়াত' : 'Sijdah Ayah'}</div>';
      }
      if (bookmarkedList['${element.surahId}_${element.verseId}'] != null) {
        html +=
            '<div class="bookmark info active">${language == 'bn' ? 'বুকমার্ক করা' : 'Bookmarked'}</div>';
      }
      if (history[element.surahId.toString()] == element.verseId.toString()) {
        html +=
            '<div class="lastRead info active">${language == 'bn' ? 'সর্বশেষ পঠিত' : 'Last Read'}</div>';
      }
      html += '</div>';

      html += '<div class="verseText">';
      html += '<div class="arabic">${element.verseHtml}</div>';
      html += '<div class="pronunciation">${element.pronunciation}</div>';
      html +=
          '<div class="taisirul">${element.meaningBnTaisirul}</div><div class="ahbayan">${element.meaningBnAhbayan}</div><div class="mujibur">${element.meaningBnMujibur}</div><div class="english">${element.meaningEn}</div>';
      html += '</div>';

      html += '<div class="verseAction">';
      html +=
          '<div class="bookmark icon" onClick="iconButtonClickHandler(this);toggleBookmark(${element.verseId});"><i class="${bookmarkedList['${element.surahId}_${element.verseId}'] != null ? 'fa-solid solid' : 'fa-regular'} fa-bookmark bookmark-${element.verseId}"></i></div>';
      html +=
          '<div class="copy icon" onClick="iconButtonClickHandler(this);copyToClipboard(this, ${element.verseId});"><i class="fa-regular fa-copy copy-${element.verseId}"></i></div>';
      html +=
          '<div class="book icon" onClick="iconButtonClickHandler(this);bookButtonClickHandler(${element.verseId});"><i class="fa-solid fa-book-open"></i></div>';
      html +=
          '<div class="saveOrDelete icon" onClick="iconButtonClickHandler(this);toggleSaveOrDelete(${element.verseId});"><i class="${history[element.surahId.toString()] == element.verseId.toString() ? 'fa-trash saved' : 'fa-floppy-disk'} fa-solid saveOrDelete-${element.verseId}"></i></div>';
      html += '</div></div>';
    }

    _surahHtml = html;
    isLoading = false;
  }

  void setWbProgress(int progress) {
    _wbProgress = progress;
    notifyListeners();
  }
}
