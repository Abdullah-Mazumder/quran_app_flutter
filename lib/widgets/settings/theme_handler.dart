import 'package:al_quran/provider/theme/theme_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeHandler extends StatelessWidget {
  const ThemeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Selector<ThemeProvider, String>(
        builder: (_, value, __) {
          return SelectBoxWithLabel(
            items: themes,
            onChanged: (newValue) {
              setValueInSharedPref('theme', newValue!);
              themeProvider.setTheme(context: context);
            },
            value: value,
            label: language == 'bn' ? "থিম" : 'Theme',
            width: 115,
          );
        },
        selector: (_, provider) => provider.mode);
  }
}
