class Country {
  final String country;
  final String city;
  final String method;
  final double lat;
  final double lng;
  final double timezone;
  final int methodId;

  Country({
    required this.country,
    required this.city,
    required this.method,
    required this.lat,
    required this.lng,
    required this.timezone,
    required this.methodId,
  });

  factory Country.fromJson(Map<String, dynamic> map) {
    return Country(
      country: map['country'],
      city: map['city'],
      method: map['method'],
      lat: map['lat'].toDouble(),
      lng: map['lng'].toDouble(),
      timezone: map['timezone'].toDouble(),
      methodId: map['methodId'],
    );
  }
}

class CalculationMethod {
  final String method;
  final int methodId;

  CalculationMethod({
    required this.method,
    required this.methodId,
  });

  factory CalculationMethod.fromJson(Map<String, dynamic> map) {
    return CalculationMethod(
      method: map['method'],
      methodId: map['methodId'],
    );
  }
}

class District {
  final String nameEn;
  final String nameBn;
  final double lat;
  final double lng;

  District({
    required this.nameEn,
    required this.nameBn,
    required this.lat,
    required this.lng,
  });

  factory District.fromJson(Map<String, dynamic> map) {
    return District(
      nameEn: map['name_en'],
      nameBn: map['name_bn'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}
