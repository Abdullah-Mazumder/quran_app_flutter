import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/utils/time_to_string.dart';
import 'package:flutter/material.dart';

class SilentPrayerTimeProvider extends ChangeNotifier {
  TimeOfDay _fajrStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _fajrEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isFajrEnabled = false;

  TimeOfDay _juhrStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _juhrEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isJuhrEnabled = false;

  TimeOfDay _asrStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _asrEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isAsrEnabled = false;

  TimeOfDay _maghribStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _maghribEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isMaghribEnabled = false;

  TimeOfDay _esaStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _esaEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isEsaEnabled = false;

  TimeOfDay _jumaStart = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _jumaEnd = const TimeOfDay(hour: 12, minute: 0);
  bool _isJumaEnabled = false;

  SilentPrayerTimeProvider() {
    loadData();
  }

  TimeOfDay get fajrStart => _fajrStart;
  TimeOfDay get fajrEnd => _fajrEnd;
  bool get isFajrEnabled => _isFajrEnabled;

  TimeOfDay get juhrStart => _juhrStart;
  TimeOfDay get juhrEnd => _juhrEnd;
  bool get isJuhrEnabled => _isJuhrEnabled;

  TimeOfDay get asrStart => _asrStart;
  TimeOfDay get asrEnd => _asrEnd;
  bool get isAsrEnabled => _isAsrEnabled;

  TimeOfDay get maghribStart => _maghribStart;
  TimeOfDay get maghribEnd => _maghribEnd;
  bool get isMaghribEnabled => _isMaghribEnabled;

  TimeOfDay get esaStart => _esaStart;
  TimeOfDay get esaEnd => _esaEnd;
  bool get isEsaEnabled => _isEsaEnabled;

  TimeOfDay get jumaStart => _jumaStart;
  TimeOfDay get jumaEnd => _jumaEnd;
  bool get isJumaEnabled => _isJumaEnabled;

  loadData() {
    setFajrStartTime();
    setFajrEndTime();
    setIsFajrEnabled();

    setJuhrStartTime();
    setJuhrEndTime();
    setIsJuhrEnabled();

    setAsrStartTime();
    setAsrEndTime();
    setIsAsrEnabled();

    setMaghribStartTime();
    setMaghribEndTime();
    setIsMaghribEnabled();

    setEsaStartTime();
    setEsaEndTime();
    setIsEsaEnabled();

    setJumaStartTime();
    setJumaEndTime();
    setIsJumaEnabled();
  }

  // Fajr start and end time handling
  void setFajrStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic fajrS = await getValueFromSharedPref(fajr_start);
      dynamic t = fajrS.toString().split(':');
      if (fajrS != null) {
        _fajrStart = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _fajrStart = time;
      setValueInSharedPref(fajr_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setFajrEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic fajrS = await getValueFromSharedPref(fajr_end);
      dynamic t = fajrS.toString().split(':');
      if (fajrS != null) {
        _fajrEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _fajrEnd = time;
      setValueInSharedPref(fajr_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsFajrEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_fajr_enabled);
      if (isE.toString() == 'true') {
        _isFajrEnabled = true;
      } else {
        _isFajrEnabled = false;
      }
    } else {
      _isFajrEnabled = value;
      setValueInSharedPref(is_fajr_enabled, value.toString());
    }

    notifyListeners();
  }

  // Juhr start and end time handling
  void setJuhrStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(juhr_start);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _juhrStart = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _juhrStart = time;
      setValueInSharedPref(juhr_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setJuhrEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(juhr_end);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _juhrEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _juhrEnd = time;
      setValueInSharedPref(juhr_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsJuhrEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_juhr_enabled);
      if (isE.toString() == 'true') {
        _isJuhrEnabled = true;
      } else {
        _isJuhrEnabled = false;
      }
    } else {
      _isJuhrEnabled = value;
      setValueInSharedPref(is_juhr_enabled, value.toString());
    }

    notifyListeners();
  }

  // Asr start and end time handling
  void setAsrStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(asr_start);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _asrStart = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _asrStart = time;
      setValueInSharedPref(asr_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setAsrEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(asr_end);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _asrEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _asrEnd = time;
      setValueInSharedPref(asr_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsAsrEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_asr_enabled);
      if (isE.toString() == 'true') {
        _isAsrEnabled = true;
      } else {
        _isAsrEnabled = false;
      }
    } else {
      _isAsrEnabled = value;
      setValueInSharedPref(is_asr_enabled, value.toString());
    }

    notifyListeners();
  }

  // Maghrib start and end time handling
  void setMaghribStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(maghrib_start);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _maghribStart =
            TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _maghribStart = time;
      setValueInSharedPref(maghrib_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setMaghribEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(maghrib_end);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _maghribEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _maghribEnd = time;
      setValueInSharedPref(maghrib_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsMaghribEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_maghrib_enabled);
      if (isE.toString() == 'true') {
        _isMaghribEnabled = true;
      } else {
        _isMaghribEnabled = false;
      }
    } else {
      _isMaghribEnabled = value;
      setValueInSharedPref(is_maghrib_enabled, value.toString());
    }

    notifyListeners();
  }

  // Esa start and end time handling
  void setEsaStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(esa_start);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _esaStart = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _esaStart = time;
      setValueInSharedPref(esa_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setEsaEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(esa_end);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _esaEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _esaEnd = time;
      setValueInSharedPref(esa_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsEsaEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_esa_enabled);
      if (isE.toString() == 'true') {
        _isEsaEnabled = true;
      } else {
        _isEsaEnabled = false;
      }
    } else {
      _isEsaEnabled = value;
      setValueInSharedPref(is_esa_enabled, value.toString());
    }

    notifyListeners();
  }

  // Juma start and end time handling
  void setJumaStartTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(juma_start);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _jumaStart = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _jumaStart = time;
      setValueInSharedPref(juma_start, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setJumaEndTime({TimeOfDay? time}) async {
    if (time == null) {
      dynamic tt = await getValueFromSharedPref(juma_end);
      dynamic t = tt.toString().split(':');
      if (tt != null) {
        _jumaEnd = TimeOfDay(hour: int.parse(t[0]), minute: int.parse(t[1]));
      }
    } else {
      _jumaEnd = time;
      setValueInSharedPref(juma_end, timeOfDayToString(time));
    }

    notifyListeners();
  }

  void setIsJumaEnabled({bool? value}) async {
    if (value == null) {
      dynamic isE = await getValueFromSharedPref(is_juma_enabled);
      if (isE.toString() == 'true') {
        _isJumaEnabled = true;
      } else {
        _isJumaEnabled = false;
      }
    } else {
      _isJumaEnabled = value;
      setValueInSharedPref(is_juma_enabled, value.toString());
    }

    notifyListeners();
  }
}
