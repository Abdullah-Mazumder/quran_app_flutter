import 'package:al_quran/provider/app/prayer_time_provider.dart';
import 'package:al_quran/screenns/features/auto_silent_prayer_time.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/home_topic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      HomeTopic(
                        title: language == 'en' ? "Silent" : "সাইলেন্ট",
                        nextScreen: MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => PrayerTimeProvider(),
                            ),
                          ],
                          child: const AutoSilentPrayerTime(),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.volumeXmark,
                          size: 32,
                          color: colors.activeColor1,
                        ),
                      ),
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
