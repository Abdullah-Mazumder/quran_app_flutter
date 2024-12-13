import 'package:flutter/material.dart';
import 'package:al_quran/state_helper/get_theme.dart';

class AllahLogo extends StatelessWidget {
  const AllahLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeName = getTheme(context).themeName;
    return SizedBox(
      width: 38,
      child: Image.asset('assets/images/$themeName/muhammad.png'),
    );
  }
}