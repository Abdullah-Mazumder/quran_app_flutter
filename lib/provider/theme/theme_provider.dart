// ignore_for_file: use_build_context_synchronously

import 'package:al_quran/models/theme/theme_colors_model.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/utils/colors.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  String _mode = 'dark';
  String _themeName = 'dark';
  ThemeColorsModel _colors = darkColors;

  ThemeProvider(BuildContext context) {
    setTheme(context: context);
  }

  bool get isDark => _isDark;
  String get mode => _mode;
  String get themeName => _themeName;
  ThemeColorsModel get colors => _colors;

  void setTheme({BuildContext? context}) async {
    String? theme = (await getValueFromSharedPref('theme'));

    if (theme == "dark") {
      _isDark = true;
      _colors = darkColors;
      _mode = theme!;
      _themeName = theme;
    } else if (theme == "light") {
      _isDark = false;
      _colors = lightColors;
      _mode = theme!;
      _themeName = theme;
    } else if (theme == 'system' || theme == null) {
      Brightness currentBrightness = MediaQuery.of(context!).platformBrightness;
      if (currentBrightness == Brightness.dark) {
        _isDark = true;
        _colors = darkColors;
        _themeName = 'dark';
      } else {
        _isDark = false;
        _colors = lightColors;
        _themeName = 'light';
      }
      _mode = 'system';
    } else if (theme == 'milk') {
      _isDark = false;
      _colors = milkColors;
      _mode = theme;
      _themeName = theme;
    } else if (theme == 'blue') {
      _isDark = true;
      _colors = blueColors;
      _mode = theme;
      _themeName = theme;
    } else if (theme == 'night') {
      _isDark = true;
      _colors = nightColors;
      _mode = theme;
      _themeName = theme;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: _colors.bgColor1,
        systemNavigationBarColor: _colors.bgColor1,
      ),
    );

    final appInfoProvider =
        Provider.of<AppInfoProvider>(context!, listen: false);
    if (appInfoProvider.surahWbController != null) {
      String js = """
  setTextColor("${_colors.txtColor.toCssString()}");
  setWarnBgColor("${_colors.warnBg.toCssString()}");
  setBgColor1("${_colors.bgColor1.toCssString()}");
  setActiveColor("${_colors.activeColor1.toCssString()}");
  setActiveWordColor("${_colors.activeColor1.withOpacity(0.3).toCssString()}");
  bismillahImageHandler($_isDark);
""";
      appInfoProvider.surahWbController!.evaluateJavascript(source: js);
    }

    notifyListeners();
  }
}
