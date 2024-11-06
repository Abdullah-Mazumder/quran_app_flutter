import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecitersHandler extends StatelessWidget {
  const RecitersHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);

    return Selector<AlQuranInfoProvider, String>(
      builder: (_, value, __) {
        return SelectBoxWithLabel(
          items: reciters,
          onChanged: (newValue) {
            alQuranInfoProvider.setReciter(value: newValue);
          },
          value: value,
          label: language == 'bn' ? "আবৃত্তিকারী" : 'Reciter',
          width: 230,
        );
      },
      selector: (_, provider) => provider.reciter,
    );
  }
}
