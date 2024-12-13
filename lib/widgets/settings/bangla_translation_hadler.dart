import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/checkbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BanglaTranslationHandler extends StatelessWidget {
  const BanglaTranslationHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    return Selector<AppInfoProvider, bool>(
        builder: (_, value, __) {
          return CheckboxWithLabel(
            title: language == 'bn' ? "বাংলা অনুবাদ" : "Bangla Translation",
            value: value,
            onChanged: () {
              appInfoProvider.setIsShowBanglaTranslation();
            },
          );
        },
        selector: (_, provider) => provider.isShowBanglaTranslation);
  }
}
