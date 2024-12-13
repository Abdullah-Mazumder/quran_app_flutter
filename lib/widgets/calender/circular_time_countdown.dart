import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CircularTimeCountdown extends StatelessWidget {
  final String rmTime;
  final double percentage;
  const CircularTimeCountdown(
      {super.key, required this.rmTime, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value: percentage,
            strokeWidth: 10,
            color: colors.activeColor1,
            backgroundColor: colors.activeColor2.withOpacity(0.6),
          ),
        ),
        CustomText(
          text:
              language == 'en' ? rmTime : convertEnglishToBanglaNumber(rmTime),
          additionalStyle: const TextStyle(fontFamily: ''),
        ),
      ],
    );
  }
}
