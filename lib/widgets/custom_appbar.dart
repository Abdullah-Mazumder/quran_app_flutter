import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomAppBar({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    return Container(
      color: colors.bgColor1,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: boldFont,
              fontSize: 22,
              color: colors.activeColor1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FaIcon(
              icon,
              color: colors.activeColor1,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
