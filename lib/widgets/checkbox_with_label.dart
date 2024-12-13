import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_checkbox.dart';
import 'package:flutter/material.dart';

class CheckboxWithLabel extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChanged;
  final Color? bgColor;

  const CheckboxWithLabel({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    return Material(
      color: bgColor ?? colors.bgColor2,
      child: InkWell(
        splashColor: colors.activeColor1.withOpacity(0.2),
        onTap: () {
          onChanged();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                additionalStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              StyledCheckBox(
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
