import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageHandler extends StatelessWidget {
  const LanguageHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    return Selector<AppInfoProvider, String>(
        builder: (_, value, __) {
          return SelectBoxWithLabel(
            items: languages,
            onChanged: (newValue) {
              appInfoProvider.setLanguage(value: newValue);
            },
            value: appInfoProvider.language,
            label: language == 'bn' ? "ভাষা" : 'Language',
            width: 110,
          );
        },
        selector: (_, provider) => provider.language);
  }
}
