import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class StyledSlider extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final int divisions;
  final void Function(double)? onChanged;
  final void Function(double)? onChangeEnd;

  const StyledSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeEnd,
    required this.min,
    required this.max,
    required this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 7,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 10,
        ),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Expanded(
        child: Slider(
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: divisions,
          value: value.toDouble(),
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
          inactiveColor: colors.activeColor2,
          activeColor: colors.activeColor1,
          label: value.toString(),
        ),
      ),
    );
  }
}
