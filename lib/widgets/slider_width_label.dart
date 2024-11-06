import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_slider.dart';
import 'package:flutter/material.dart';

class SliderWithLabel extends StatelessWidget {
  final String title;
  final int value;
  final int min;
  final int max;
  final int divisions;
  final void Function(double)? onChanged;
  final void Function(double)? onChangeEnd;

  const SliderWithLabel({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.onChangeEnd,
    required this.min,
    required this.max,
    required this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                additionalStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              CustomText(
                text: language == 'bn'
                    ? convertEnglishToBanglaNumber(value)
                    : value.toString(),
                additionalStyle: const TextStyle(
                  fontFamily: "normal",
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              StyledSlider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: onChanged,
                onChangeEnd: onChangeEnd,
              )
            ],
          ),
        )
      ],
    );
  }
}
