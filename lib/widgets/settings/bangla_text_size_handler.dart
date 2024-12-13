import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/slider_width_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BanglaTextSizeHandler extends StatelessWidget {
  const BanglaTextSizeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    return Selector<AppInfoProvider, int>(
        builder: (_, value, child) {
          return SliderWithLabel(
            title: language == 'bn' ? "বাংলা লেখার সাইজ" : "Bangla Text Size",
            value: value,
            min: 14,
            max: 40,
            divisions: 5000,
            onChanged: (newValue) {
              appInfoProvider.setBanglaTextSize(size: newValue.toInt());
            },
            onChangeEnd: (newValue) {
              setValueInSharedPref(
                  bangla_text_size, newValue.toInt().toString());
              appInfoProvider.setBanglaTextSize();
            },
          );
        },
        selector: (_, provider) => provider.banglaTextSize);
  }
}
