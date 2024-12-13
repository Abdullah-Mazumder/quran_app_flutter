import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/checkbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordHighlighterHandler extends StatelessWidget {
  const WordHighlighterHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);

    return Selector<AlQuranInfoProvider, bool>(
      builder: (_, value, __) {
        return CheckboxWithLabel(
          title: language == 'bn' ? "শব্দ হাইলাইট" : "Highlight Word",
          value: value,
          onChanged: () {
            alQuranInfoProvider.setIsHighlightWord();
          },
        );
      },
      selector: (_, provider) => provider.isWordHighLight,
    );
  }
}
