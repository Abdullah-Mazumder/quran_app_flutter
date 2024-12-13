import 'dart:async';

import 'package:al_quran/db/quran/quran_db_helper.dart';
import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:flutter/foundation.dart';

class MushafQuranSurahProvider extends ChangeNotifier {
  bool _isLoading = true;
  String _data = "";
  SingleSurahInfo? _surahInfo;
  int _versePositionStart = 0;
  List<dynamic> _versesPositions = [];

  bool get isLoading => _isLoading;
  String get data => _data;
  SingleSurahInfo? get surahInfo => _surahInfo;
  int get versePositionStart => _versePositionStart;
  List<dynamic> get versesPositions => _versesPositions;

  Future<void> readSurahFromDB(int surahId, String language) async {
    _isLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> surahInformation =
        await QuranDBHelper.getSurahListsWithSurahIds([surahId]);

    final List<Map<String, dynamic>> surahData =
        await QuranDBHelper.getAllVerseOfASurahWithSurahID(surahId);

    final Map<int, dynamic> surahByPage = {};

    for (int i = 0; i < surahData.length; i++) {
      var page = int.parse(surahData[i]['page'].toString());
      if (surahByPage[page] != null) {
        surahByPage[page].add(surahData[i]);
      } else {
        surahByPage[page] = [surahData[i]];
      }
    }

    String html = "";

    for (int key in surahByPage.keys) {
      final verses = surahByPage[key];

      var page = verses[0]['page'];
      var juz = verses[0]['juz'];
      var ruku = verses[0]['ruku'];
      var manzil = verses[0]['manzil'];

      html += """
                  <div class='pageInfo'>
                    <div class='info'>
                      ${language == 'bn' ? 'পৃষ্ঠা - ${convertEnglishToBanglaNumber(page)}' : 'Page - $page'}
                    </div>
                    <div class='info'>
                      ${language == 'bn' ? 'পারা - ${convertEnglishToBanglaNumber(juz)}' : 'Para - $juz'}
                    </div>
                    <div class='info'>
                      ${language == 'bn' ? 'রুকু - ${convertEnglishToBanglaNumber(ruku)}' : 'Ruku - $ruku'}
                    </div>
                    <div class='info'>
                      ${language == 'bn' ? 'মঞ্জিল - ${convertEnglishToBanglaNumber(manzil)}' : 'Manzil - $manzil'}
                    </div>
                  </div>
                  <div class='verses'>
                """;

      for (int i = 0; i < verses.length; i++) {
        html += verses[i]['verseHtml'];
        if (verses[i]['isSajdahAyat'].toString() == '1') {
          html += '<div class="sajdah">۩</div>';
        }
        html +=
            '<div class="verseId"><div class="id">${language == 'bn' ? convertEnglishToBanglaNumber(verses[i]['verseId']) : verses[i]['verseId']}</div></div>';
      }

      html += '</div>';
    }

    _versesPositions = surahData.map((i) => i['versePosition']).toList();
    _data = html;
    _surahInfo = SingleSurahInfo.fromJson(surahInformation[0]);
    _versePositionStart = int.parse(surahData[0]['versePosition'].toString());
    _isLoading = false;

    notifyListeners();
  }
}
