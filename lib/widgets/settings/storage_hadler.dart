import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorageHandler extends StatelessWidget {
  const StorageHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    return Selector<AppInfoProvider, String>(
      builder: (_, value, __) {
        return SelectBoxWithLabel(
          items: storages,
          onChanged: (newValue) {
            appInfoProvider.setStorage(
                value: newValue, bgColor: colors.activeColor1);
          },
          value: appInfoProvider.storage,
          label: language == 'bn' ? "স্টোরেজ" : 'Storage',
          width: 170,
        );
      },
      selector: (_, provider) => provider.storage,
    );
  }
}
