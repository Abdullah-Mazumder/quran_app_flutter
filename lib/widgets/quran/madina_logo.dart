import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class MadinaLogo extends StatelessWidget {
  const MadinaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = getTheme(context).isDark;
    return SizedBox(
      width: 18,
      height: 18,
      child: Image.asset(
        isDark
            ? 'assets/images/madina_dark.png'
            : 'assets/images/madina_light.png',
      ),
    );
  }
}
