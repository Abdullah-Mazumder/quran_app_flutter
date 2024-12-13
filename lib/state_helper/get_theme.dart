import 'package:al_quran/models/theme/theme_colors_model.dart';
import 'package:al_quran/provider/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModel {
  final bool isDark;
  final ThemeColorsModel colors;
  final String mode;
  final String themeName;

  ThemeModel({
    required this.isDark,
    required this.colors,
    required this.mode,
    required this.themeName,
  });
}

ThemeModel getTheme(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return ThemeModel(
    isDark: themeProvider.isDark,
    colors: themeProvider.colors,
    mode: themeProvider.mode,
    themeName: themeProvider.themeName,
  );
}
