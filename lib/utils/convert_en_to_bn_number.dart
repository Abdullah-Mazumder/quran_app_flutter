String convertEnglishToBanglaNumber(dynamic englishNumber) {
  if (englishNumber == null || englishNumber.toString().isEmpty) return "";

  Map<String, String> englishToBanglaDigits = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯'
  };

  String result = englishNumber.toString().split('').map((char) {
    return englishToBanglaDigits[char] ?? char;
  }).join('');

  return result;
}
