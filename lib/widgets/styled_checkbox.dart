import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class StyledCheckBox extends StatelessWidget {
  final bool value;
  final Function onChanged;

  const StyledCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return CheckboxTheme(
      data: CheckboxTheme.of(context).copyWith(
        side: BorderSide(color: colors.activeColor1, width: 3),
        splashRadius: 20,
      ),
      child: Checkbox(
        activeColor: colors.activeColor1,
        onChanged: (newValue) => onChanged(newValue),
        value: value,
      ),
    );
  }
}
