import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TajweedTag extends StatelessWidget {
  final String label;
  final Color color;
  const TajweedTag({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 0,
          color: color,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: CustomText(
        text: label,
        additionalStyle: const TextStyle(
          fontSize: 11,
          color: Colors.black,
        ),
      ),
    );
  }
}
