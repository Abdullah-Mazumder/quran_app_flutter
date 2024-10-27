import 'package:al_quran/db/db_helper.dart';

class QuranDBHelper {
  String _generateDynamicQuery(List<Map<String, int>> conditions) {
    return conditions
        .map(
          (condition) =>
              '(surahId = ${condition['surahId']} AND verseId = ${condition['verseId']})',
        )
        .join(' OR ');
  }

  static getSurahList() async {
    var dbClient = await DBHelper.db;

    List<Map<String, dynamic>> surahList =
        await dbClient!.rawQuery('SELECT * FROM surahList');

    return surahList;
  }

  static getSurahListsWithSurahIds(List<int> ids) async {
    var dbClient = await DBHelper.db;

    String idString = ids.join(",");

    List<Map<String, dynamic>> surahLists = await dbClient!
        .rawQuery('SELECT * FROM surahList WHERE id in ($idString)');

    return surahLists;
  }

  static getAllVerseOfASurahWithSurahID(int id) async {
    var dbClient = await DBHelper.db;

    List<Map<String, dynamic>> allVerses =
        await dbClient!.rawQuery('SELECT * FROM alQuran WHERE surahId  = $id');

    return allVerses;
  }

  static getAllWordsOfASurahWithSurahID(int id) async {
    var dbClient = await DBHelper.db;

    List<Map<String, dynamic>> allWords = await dbClient!
        .rawQuery('SELECT * FROM meaningByWord WHERE surahId  = $id');

    return allWords;
  }

  static getTafseerWithSurahIdAndVerseId(
      {required int surahId, required int verseId}) async {
    var dbClient = await DBHelper.db;

    List<Map<String, dynamic>> tafseer = await dbClient!.rawQuery(
        'SELECT * FROM tafseer WHERE surahId = $surahId AND verseId = $verseId');

    return tafseer;
  }

  static getVersesWithSurahIdAndVerseId(
      List<Map<String, int>> conditions) async {
    if (conditions.isEmpty) return [];

    var dbClient = await DBHelper.db;
    final query =
        "SELECT * FROM alQuran WHERE ${QuranDBHelper()._generateDynamicQuery(conditions)}";
    List<dynamic> verses = await dbClient!.rawQuery(query);

    return verses;
  }

  static getQuranSubjectList() async {
    var dbClient = await DBHelper.db;
    const query = "SELECT * FROM subjectWiseAlQuran";

    List<dynamic> subjects = await dbClient!.rawQuery(query);

    return subjects;
  }

  static getWordsWithSurahIdAndVerseId(
      List<Map<String, int>> conditions) async {
    var dbClient = await DBHelper.db;
    final query =
        "SELECT * FROM meaningByWord WHERE ${QuranDBHelper()._generateDynamicQuery(conditions)}";

    final words = await dbClient!.rawQuery(query);

    return words;
  }

  static getWordInfo(int surahId, int verseId, int wordId) async {
    var dbClient = await DBHelper.db;
    final query =
        "SELECT * FROM meaningByWord WHERE surahId = $surahId AND verseId = $verseId AND wordId = $wordId";
    final words = await dbClient!.rawQuery(query);

    return words[0];
  }
}
