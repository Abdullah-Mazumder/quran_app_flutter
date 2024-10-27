import 'package:flutter/material.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextDirection? direction;
  final TextStyle? additionalStyle;

  const CustomText({
    Key? key,
    required this.text,
    this.additionalStyle,
    this.direction = TextDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    // Merge the additional style with the default style
    final mergedTextStyle = TextStyle(
      color: colors.txtColor,
      fontFamily: regularFont,
      fontSize: 14,
    ).merge(additionalStyle);

    return Text(
      text,
      textDirection: direction,
      style: mergedTextStyle,
    );
  }
}
