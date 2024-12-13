import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/styled_pressable.dart';
import 'package:flutter/material.dart';

class HomeTopic extends StatelessWidget {
  final String title;
  final String? imagePath;
  final Widget nextScreen;
  final int width;
  final Widget? icon;

  const HomeTopic({
    super.key,
    this.imagePath,
    required this.title,
    required this.nextScreen,
    this.width = 30,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: StyledPressable(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextScreen,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              imagePath != null
                  ? Center(
                      child: Image.asset(
                        imagePath!,
                        width: width.toDouble(),
                      ),
                    )
                  : Center(
                      child: icon,
                    ),
              CustomText(
                text: title,
                additionalStyle: TextStyle(
                  color: colors.txtColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
