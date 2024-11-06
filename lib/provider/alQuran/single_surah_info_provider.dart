import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SingleSurahInfoProvider extends ChangeNotifier {
  int _ayahInViewIndex = 0;
  bool _isAudioPlayerOpen = false;
  int _currentVerse = 1;
  int _secodaryCurrentVerse = 1;
  bool _isDownloadedSurah = false;

  AudioPlayer? _audioPlayer;
  bool _isAudioLoading = false;
  bool _isAudioPlaying = false;
  Map<String, dynamic>? _audioTimingInfo;

  int get ayahInViewIndex => _ayahInViewIndex;
  bool get isAudioPlayerOpen => _isAudioPlayerOpen;
  int get currentVerse => _currentVerse;
  int get secondaryCurrentVerse => _secodaryCurrentVerse;
  bool get isDownloadedSurah => _isDownloadedSurah;

  AudioPlayer? get audioPlayer => _audioPlayer;
  bool get isAudioLoading => _isAudioLoading;
  bool get isAudioPlayeing => _isAudioPlaying;
  Map<String, dynamic>? get audioTimingInfo => _audioTimingInfo;

  Future<void> clearAudioCach() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.stop();
      await _audioPlayer!.dispose();
    }
    _audioPlayer = null;
    _isAudioLoading = false;
    _isAudioPlaying = false;
    notifyListeners();
  }

  void setIndexOfAyahInView(int index) {
    if (index >= 0) {
      if (index != _ayahInViewIndex) {
        _ayahInViewIndex = index;
        notifyListeners();
      }
    } else {
      _ayahInViewIndex = 0;
      notifyListeners();
    }
  }

  void audioPlayerHandler({bool? value}) {
    if (value == false && value != null) {
      _isAudioPlayerOpen = false;
    } else {
      _isAudioPlayerOpen = !_isAudioPlayerOpen;
    }

    notifyListeners();
  }

  void setCurrentVers(int id) {
    _currentVerse = id;
    notifyListeners();
  }

  void setSecondaryCurrentVerse(int id) {
    _secodaryCurrentVerse = id;
    notifyListeners();
  }

  void setIsDownloadedSurah(bool value) {
    _isDownloadedSurah = value;
    notifyListeners();
  }

  void setAudioPlayer({AudioPlayer? player}) {
    _audioPlayer = player;
    notifyListeners();
  }

  void audioLoadingHandler(bool value) {
    if (value != _isAudioLoading) {
      _isAudioLoading = value;
      notifyListeners();
    }
  }

  void audioPlayingHandler(bool value) {
    if (value != _isAudioPlaying) {
      _isAudioPlaying = value;
      notifyListeners();
    }
  }

  void setAudioTimingInfo({Map<String, dynamic>? value}) {
    _audioTimingInfo = value;
    notifyListeners();
  }
}
