import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArabicFontHandler extends StatelessWidget {
  const ArabicFontHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    return Selector<AppInfoProvider, String>(
        builder: (context, value, child) {
          return SelectBoxWithLabel(
            items: fonts,
            onChanged: (newValue) {
              appInfoProvider.setArabicFont(value: newValue);
            },
            value: value,
            label: language == 'bn' ? "আরবি ফন্ট" : 'Arabic Font',
            width: 150,
          );
        },
        selector: (context, provider) => provider.arabicFont);
  }
}
