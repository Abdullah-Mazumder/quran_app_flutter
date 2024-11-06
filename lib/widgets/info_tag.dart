import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  final String label;
  final bool? isActive;

  const InfoTag({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Transform.scale(
      scaleY: 0.9,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: isActive! ? colors.warnBg : colors.bgColor1,
          border: Border.all(
            width: 1.3,
            color: colors.activeColor1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: colors.activeColor1,
          ),
        ),
      ),
    );
  }
}
