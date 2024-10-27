String convertEnglishToBanglaNumber(dynamic input) {
  if (input == null || input.toString().isEmpty) return "";

  // Define arrays for mapping English numerals to Bangla numerals
  List<String> banglaNumerals = [
    "০",
    "১",
    "২",
    "৩",
    "৪",
    "৫",
    "৬",
    "৭",
    "৮",
    "৯"
  ];
  List<String> englishNumerals = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ];

  // Convert input to String
  String inputString = input is num ? input.toString() : input;

  // Initialize an empty string to store the converted Bangla numerals
  String banglaNumber = "";

  // Loop through each character in the input string
  for (int i = 0; i < inputString.length; i++) {
    // Get the current digit at the current position
    String digit = inputString[i];

    // Find the index of the digit in the English numerals array
    int englishIndex = englishNumerals.indexOf(digit);

    // Check if the digit is found in the English numerals array
    if (englishIndex != -1) {
      // Append the corresponding Bangla numeral to the result string
      banglaNumber += banglaNumerals[englishIndex];
    } else {
      // If the digit is not found in the English numerals array, keep it unchanged
      banglaNumber += digit;
    }
  }

  // Return the final string with Bangla numerals
  return banglaNumber;
}
