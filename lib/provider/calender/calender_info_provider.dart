// ignore_for_file: non_constant_identifier_names

import 'package:al_quran/models/calender/calender_data_model.dart';
import 'package:al_quran/utils/calender_constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CalenderInfoProvider extends ChangeNotifier {
  String _country = "Bangladesh";
  String _district = "Dhaka";
  String _defaultCity = "Dhaka";
  String _address = "Dhaka, Bangladesh";
  String _locationMethod = 'district';
  double _lat = 0.0;
  double _lng = 0.0;
  double _gmtOffset = 0.0;

  String _madhab = "hanafi";
  String _prayerTimeMethod = '2';
  int _warningTimeBeforeMag = 3;
  String _hijriChange = 'midnight';
  int _hijriDateAdjustment = -1;

  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  late GoogleMapController _googleMapController;

  String get country => _country;
  String get district => _district;
  String get defaultCity => _defaultCity;
  String get address => _address;
  String get locationMethod => _locationMethod;
  double get lat => _lat;
  double get lng => _lng;
  double get gmtOffset => _gmtOffset;

  String get madhab => _madhab;
  String get prayerTimeMethod => _prayerTimeMethod;
  int get warningTimeBeforeMag => _warningTimeBeforeMag;
  String get hijriChange => _hijriChange;
  int get hijriDateAdjustment => _hijriDateAdjustment;

  int get month => _month;
  int get year => _year;

  GoogleMapController get googleMapController => _googleMapController;

  CalenderInfoProvider() {
    setCountry();
    setDistrict();
    setAddressLatAndLng();
    setMadhab();
    setPrayerTimeCalMethod();
    setWarningTime();
    setHijriChange();
    setHijriDateAdjustment();
  }

  void updateGoogleMap() {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_lat, _lng),
          zoom: 10,
        ),
      ),
    );
  }

  void setCountry({String? cntry}) async {
    if (cntry == null) {
      dynamic v = await getValueFromSharedPref(current_country);
      if (v != null) {
        _country = v;
      }
    } else {
      _country = cntry;
    }

    if (_country == 'Bangladesh') {
      _locationMethod = 'district';
    } else {
      _locationMethod = 'gps';
    }

    Country countryDetails = getCountryDetails(_country);
    _lat = countryDetails.lat;
    _lng = countryDetails.lng;
    _defaultCity = countryDetails.city;
    _district = countryDetails.city;
    _address = countryDetails.city;
    _gmtOffset = countryDetails.timezone;
    _prayerTimeMethod = countryDetails.methodId.toString();

    if (cntry != null) {
      updateGoogleMap();
      await deleteValueFromSharedPref(current_address);
    }

    notifyListeners();
    setValueInSharedPref(current_country, _country);
  }

  void setDistrict({String? dis}) async {
    if (dis == null) {
      dynamic v = await getValueFromSharedPref(current_district);
      if (v != null) {
        _district = v;
      }
    } else {
      _district = dis;
    }

    if (_country == 'Bangladesh') {
      District districtDetails = getDistrictDetails(_district);
      _lat = districtDetails.lat;
      _lng = districtDetails.lng;
      _address = _district;
    } else {
      Country countryDetails = getCountryDetails(_country);
      _lat = countryDetails.lat;
      _lng = countryDetails.lng;
      _address = countryDetails.city;
    }

    if (dis != null) {
      updateGoogleMap();
    }

    notifyListeners();
    setValueInSharedPref(current_district, _district);
    if (dis != null) {
      await deleteValueFromSharedPref(current_address);
    }
  }

  void setLocationMethod(String locationMethod) {
    _locationMethod = locationMethod;
    notifyListeners();
  }

  void setAddressLatAndLng({String? address, double? lat, double? lng}) async {
    if (address == null) {
      dynamic v1 = await getValueFromSharedPref(current_address);
      dynamic v2 = await getValueFromSharedPref(current_latitude);
      dynamic v3 = await getValueFromSharedPref(current_longitude);

      if (v1 != null) {
        _address = v1;
        _lat = double.parse(v2);
        _lng = double.parse(v3);
        _locationMethod = 'gps';
      }
    } else {
      _address = address;
      _lat = lat!;
      _lng = lng!;
    }

    if (address != null) {
      updateGoogleMap();
    }

    notifyListeners();
    setValueInSharedPref(current_address, _address);
    setValueInSharedPref(current_latitude, _lat.toString());
    setValueInSharedPref(current_longitude, _lng.toString());
  }

  void setMapController(GoogleMapController controller) {
    _googleMapController = controller;
    updateGoogleMap();
  }

  void setMadhab({String? madhab}) async {
    if (madhab == null) {
      dynamic v = await getValueFromSharedPref(current_madhab);
      if (v != null) {
        _madhab = v;
      }
    } else {
      _madhab = madhab;
    }

    notifyListeners();
    setValueInSharedPref(current_madhab, _madhab);
  }

  void setPrayerTimeCalMethod({String? value}) async {
    if (value == null) {
      dynamic v = await getValueFromSharedPref(prayer_time_method);
      if (v != null) {
        _prayerTimeMethod = v;
      }
    } else {
      _prayerTimeMethod = value;
    }

    notifyListeners();
    setValueInSharedPref(prayer_time_method, _prayerTimeMethod);
  }

  void setWarningTime({int? value}) async {
    if (value == null) {
      dynamic v = await getValueFromSharedPref(warning_time_be_mag);
      if (v != null) {
        _warningTimeBeforeMag = int.parse(v);
      }
    } else {
      _warningTimeBeforeMag = value;
    }

    notifyListeners();
    setValueInSharedPref(warning_time_be_mag, _warningTimeBeforeMag.toString());
  }

  void setHijriChange({String? value}) async {
    if (value == null) {
      dynamic v = await getValueFromSharedPref(hijri_change);
      if (v != null) {
        _hijriChange = v;
      }
    } else {
      _hijriChange = value;
    }

    notifyListeners();
    setValueInSharedPref(hijri_change, _hijriChange);
  }

  void setHijriDateAdjustment({int? value}) async {
    if (value == null) {
      dynamic v = await getValueFromSharedPref(hijri_adjust);
      if (v != null) {
        _hijriDateAdjustment = int.parse(v);
      }
    } else {
      _hijriDateAdjustment = value;
    }

    notifyListeners();
    setValueInSharedPref(hijri_adjust, _hijriDateAdjustment.toString());
  }

  void setMonth(int value) {
    _month = value;
    notifyListeners();
  }

  void setYear(int value) {
    _year = value;
    notifyListeners();
  }
}

Country getCountryDetails(String country) {
  List<Country> countriesData =
      countries.map((json) => Country.fromJson(json)).toList();

  return countriesData.firstWhere((item) => item.country == country);
}

District getDistrictDetails(String district) {
  List<District> districtsData =
      districts.map((json) => District.fromJson(json)).toList();

  return districtsData.firstWhere((item) => item.nameEn == district);
}
