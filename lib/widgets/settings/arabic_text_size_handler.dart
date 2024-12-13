import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/slider_width_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArabicTextSizeHandler extends StatelessWidget {
  const ArabicTextSizeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    return Selector<AppInfoProvider, int>(
      builder: (context, value, child) {
        return SliderWithLabel(
          title: language == "bn" ? "আরবি লেখার সাইজ" : "Arabic Text Size",
          value: value,
          min: 20,
          max: 60,
          divisions: 5000,
          onChanged: (newValue) {
            appInfoProvider.setArabicTextSize(size: newValue.toInt());
          },
          onChangeEnd: (newValue) {
            setValueInSharedPref(arabic_text_size, newValue.toInt().toString());
            appInfoProvider.setArabicTextSize();
          },
        );
      },
      selector: (context, provider) => provider.arabicTextSize,
    );
  }
}
