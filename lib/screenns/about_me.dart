import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: language == "bn" ? "প্রণেতা সম্পর্কে" : "About The Author",
              icon: FontAwesomeIcons.solidUser,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: colors.bgColor2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: language == "bn" ? "নামঃ " : "Name: ",
                          additionalStyle: TextStyle(
                            color: colors.activeColor1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        CustomText(
                          text: language == "bn"
                              ? "আব্দুল্লাহ মজুমদার"
                              : "Abdullah Mazumder",
                          additionalStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: language == "bn"
                              ? "পড়াশুনা স্নাতকঃ "
                              : "Study (BSc Hons.): ",
                          additionalStyle: TextStyle(
                            color: colors.activeColor1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        CustomText(
                          text: language == "bn"
                              ? "কুমিল্লা ভিক্টোরিয়া সরকারি কলেজ"
                              : "Cumilla Govt. Victoria College",
                          additionalStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: language == "bn" ? "বিভাগঃ " : "Department: ",
                          additionalStyle: TextStyle(
                            color: colors.activeColor1,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        CustomText(
                          text: language == "bn"
                              ? "গণিত (২৫ তম ব্যাচ)"
                              : "Mathematics (25th Batch)",
                          additionalStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
