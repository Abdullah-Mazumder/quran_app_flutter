import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordInfoBox extends StatelessWidget {
  const WordInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final wordInfoProvider =
        Provider.of<WordInfoProvider>(context, listen: false);
    return Selector<WordInfoProvider, WordInfo?>(
      selector: (_, provider) => provider.wordInfo,
      builder: (_, value, __) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          top: value == null ? -100 : 20,
          left: ((MediaQuery.of(context).size.width) / 2) - 100,
          child: GestureDetector(
            onTap: () {
              wordInfoProvider.deleteWordInfo();
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.activeColor1,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: value == null ? '' : value.meaningBn,
                    additionalStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  CustomText(
                    text: value == null ? '' : value.meaningEn,
                    additionalStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
