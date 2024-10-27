import 'package:al_quran/state_helper/get_theme.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final int? lw;
  final int? lh;

  const Loader({super.key, this.lw = 30, this.lh = 30});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    return SizedBox(
      width: lw!.toDouble(),
      height: lh!.toDouble(),
      child: CircularProgressIndicator(
        color: colors.activeColor1,
      ),
    );
  }
}
