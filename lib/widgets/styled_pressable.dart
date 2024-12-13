import 'dart:async';

import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class StyledPressable extends StatelessWidget {
  final Widget child;
  final void Function() onPress;
  const StyledPressable(
      {super.key, required this.onPress, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Material(
      color: colors.bgColor1,
      child: InkWell(
        splashColor: colors.activeColor1.withOpacity(0.2),
        onTap: () {
          Timer(const Duration(milliseconds: 200), () {
            onPress();
          });
        },
        child: child,
      ),
    );
  }
}
