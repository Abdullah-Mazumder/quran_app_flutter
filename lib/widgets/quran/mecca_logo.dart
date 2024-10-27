import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class MeccaLogo extends StatelessWidget {
  const MeccaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = getTheme(context).isDark;
    return SizedBox(
      width: 17,
      height: 17,
      child: Image.asset(
        isDark
            ? 'assets/images/mecca_dark.png'
            : 'assets/images/mecca_light.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
