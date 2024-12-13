import 'package:al_quran/screenns/doa/doa.dart';
import 'package:al_quran/screenns/features/auto_silent_prayer_time.dart';
import 'package:al_quran/screenns/features/qiblah/qiblah.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/home_topic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturesHome extends StatelessWidget {
  const FeaturesHome({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.icons,
              title: language == 'bn' ? 'ফিচারস' : 'Features',
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 15,
                        children: [
                          HomeTopic(
                            title: language == 'bn' ? "দোয়া" : "Doa",
                            nextScreen: const Doa(),
                            icon: FaIcon(
                              FontAwesomeIcons.handsPraying,
                              size: 20,
                              color: colors.activeColor1,
                            ),
                          ),
                          HomeTopic(
                            title: language == 'en' ? "Silent" : "সাইলেন্ট",
                            nextScreen: const AutoSilentPrayerTime(),
                            icon: FaIcon(
                              FontAwesomeIcons.volumeXmark,
                              size: 20,
                              color: colors.activeColor1,
                            ),
                          ),
                          HomeTopic(
                            title: language == 'bn' ? "কিবলাহ" : "Qiblah",
                            nextScreen: const Qiblah(),
                            icon: FaIcon(
                              FontAwesomeIcons.kaaba,
                              size: 20,
                              color: colors.activeColor1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
