class SingleSurahInfo {
  final int id;
  final String locationAr;
  final String locationEn;
  final String meaningBn;
  final String meaningEn;
  final String nameAr;
  final String nameBn;
  final String nameEn;
  final int totalAyah;

  SingleSurahInfo({
    required this.id,
    required this.locationAr,
    required this.locationEn,
    required this.meaningBn,
    required this.meaningEn,
    required this.nameAr,
    required this.nameBn,
    required this.nameEn,
    required this.totalAyah,
  });

  factory SingleSurahInfo.fromJson(Map<String, dynamic> json) {
    return SingleSurahInfo(
      id: json['id'],
      locationAr: json['locationAr'],
      locationEn: json['locationEn'],
      meaningBn: json['meaningBn'],
      meaningEn: json['meaningEn'],
      nameAr: json['nameAr'],
      nameBn: json['nameBn'],
      nameEn: json['nameEn'],
      totalAyah: json['totalAyah'],
    );
  }
}

class VerseInfo {
  final String meaningEn;
  final int page;
  final int ruku;
  final int manzil;
  final int isSajdahAyat;
  final int juz;
  final int surahId;
  final int verseId;
  final String meaningBnTaisirul;
  final String meaningBnAhbayan;
  final String meaningBnMujibur;
  final int versePosition;
  final String verseHtml;
  final String verseAr;
  final String pronunciation;

  VerseInfo(
      {required this.meaningEn,
      required this.page,
      required this.ruku,
      required this.manzil,
      required this.isSajdahAyat,
      required this.juz,
      required this.surahId,
      required this.verseId,
      required this.meaningBnTaisirul,
      required this.meaningBnAhbayan,
      required this.meaningBnMujibur,
      required this.versePosition,
      required this.verseHtml,
      required this.verseAr,
      required this.pronunciation});

  factory VerseInfo.fromJson(Map<String, dynamic> json) {
    return VerseInfo(
      meaningEn: json['meaningEn'],
      page: json['page'],
      ruku: json['ruku'],
      manzil: json['manzil'],
      isSajdahAyat: json['isSajdahAyat'],
      juz: json['juz'],
      surahId: json['surahId'],
      verseId: json['verseId'],
      meaningBnTaisirul: json['meaningBnTaisirul'],
      meaningBnAhbayan: json['meaningBnAhbayan'],
      meaningBnMujibur: json['meaningBnMujibur'],
      versePosition: json['versePosition'],
      verseHtml: json['verseHtml'],
      verseAr: json['verseAr'],
      pronunciation: json['pronunciation'],
    );
  }
}

class WordInfo {
  final int surahId;
  final int verseId;
  final int wordId;
  final String meaningBn;
  final String meaningEn;

  WordInfo({
    required this.surahId,
    required this.verseId,
    required this.wordId,
    required this.meaningBn,
    required this.meaningEn,
  });

  factory WordInfo.fromJson(Map<String, dynamic> json) {
    return WordInfo(
      surahId: json['surahId'],
      verseId: json['verseId'],
      wordId: json['wordId'],
      meaningBn: json['meaningBn'],
      meaningEn: json['meaningEn'],
    );
  }
}

class Tafseer {
  final int surahId;
  final int verseId;
  final String data;

  Tafseer({
    required this.surahId,
    required this.verseId,
    required this.data,
  });

  factory Tafseer.fromJson(Map<String, dynamic> json) {
    return Tafseer(
      surahId: json['surahId'],
      verseId: json['verseId'],
      data: json['data'],
    );
  }
}

class QuranSubject {
  final String subject;
  final String location;

  QuranSubject({required this.location, required this.subject});

  factory QuranSubject.fromJson(Map<String, dynamic> json) {
    return QuranSubject(
      subject: json['subject'],
      location: json['location'],
    );
  }
}

class VersesWithSurahInfo extends VerseInfo {
  final SingleSurahInfo? surahInfo;

  VersesWithSurahInfo({
    required String meaningEn,
    required int page,
    required int ruku,
    required int manzil,
    required int isSajdahAyat,
    required int juz,
    required int surahId,
    required int verseId,
    required String meaningBnTaisirul,
    required String meaningBnAhbayan,
    required String meaningBnMujibur,
    required int versePosition,
    required String verseHtml,
    required String verseAr,
    required String pronunciation,
    this.surahInfo,
  }) : super(
          meaningEn: meaningEn,
          page: page,
          ruku: ruku,
          manzil: manzil,
          isSajdahAyat: isSajdahAyat,
          juz: juz,
          surahId: surahId,
          verseId: verseId,
          meaningBnTaisirul: meaningBnTaisirul,
          meaningBnAhbayan: meaningBnAhbayan,
          meaningBnMujibur: meaningBnMujibur,
          versePosition: versePosition,
          verseHtml: verseHtml,
          verseAr: verseAr,
          pronunciation: pronunciation,
        );

  factory VersesWithSurahInfo.fromJson(Map<String, dynamic> json) {
    dynamic surahInfoJson = json['surahInfo'];
    SingleSurahInfo? parsedSurahInfo;
    if (surahInfoJson == null) {
      parsedSurahInfo = null;
    } else {
      parsedSurahInfo = SingleSurahInfo.fromJson(surahInfoJson);
    }

    return VersesWithSurahInfo(
      meaningEn: json['meaningEn'],
      page: json['page'],
      ruku: json['ruku'],
      manzil: json['manzil'],
      isSajdahAyat: json['isSajdahAyat'],
      juz: json['juz'],
      surahId: json['surahId'],
      verseId: json['verseId'],
      meaningBnTaisirul: json['meaningBnTaisirul'],
      meaningBnAhbayan: json['meaningBnAhbayan'],
      meaningBnMujibur: json['meaningBnMujibur'],
      versePosition: json['versePosition'],
      verseHtml: json['verseHtml'],
      verseAr: json['verseAr'],
      pronunciation: json['pronunciation'],
      surahInfo: parsedSurahInfo,
    );
  }
}
