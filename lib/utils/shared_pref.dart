import 'package:shared_preferences/shared_preferences.dart';

void setValueInSharedPref(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getValueFromSharedPref(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? value = prefs.getString(key);

  return value;
}

Future<void> deleteValueFromSharedPref(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
