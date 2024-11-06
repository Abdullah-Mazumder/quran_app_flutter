import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/slider_width_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnglishTextSizeHandler extends StatelessWidget {
  const EnglishTextSizeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    return Selector<AppInfoProvider, int>(
        builder: (_, value, __) {
          return SliderWithLabel(
            title: language == 'bn' ? "ইংরেজি লেখার সাইজ" : "English Text Size",
            value: value,
            min: 14,
            max: 40,
            divisions: 5000,
            onChanged: (newValue) {
              appInfoProvider.setEnglishTextSize(size: newValue.toInt());
            },
            onChangeEnd: (newValue) {
              setValueInSharedPref(
                  english_text_size, newValue.toInt().toString());
              appInfoProvider.setEnglishTextSize();
            },
          );
        },
        selector: (_, provider) => provider.englishTextSize);
  }
}
