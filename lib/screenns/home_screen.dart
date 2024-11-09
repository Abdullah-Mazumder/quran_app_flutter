// import 'package:al_quran/screenns/about_me.dart';

import 'package:al_quran/screenns/features/features_home.dart';
import 'package:al_quran/screenns/quran/downloaded_surah.dart';
import 'package:al_quran/screenns/quran/quran_bottom_tab.dart';
import 'package:al_quran/screenns/settings.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/allah_logo.dart';
import 'package:al_quran/widgets/home_topic.dart';
import 'package:al_quran/widgets/muhammad_logo.dart';
import 'package:al_quran/widgets/status_and_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:al_quran/provider/alQuran/bookmarked_list_provider.dart';
import 'package:al_quran/provider/alQuran/favorite_surah_list_provider.dart';
import 'package:al_quran/provider/alQuran/mushaf_quran_surah_provider.dart';
import 'package:al_quran/provider/alQuran/subject_wise_quran_list_provider.dart';
import 'package:al_quran/provider/alQuran/surah_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final isDark = getTheme(context).isDark;
    final themeName = getTheme(context).themeName;

    final language = getLanguage(context);

    return Scaffold(
      body: StatusAndNavigationBarProvider(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
              color: colors.bgColor1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AllahLogo(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Image.asset(
                            isDark
                                ? 'assets/images/bismillah_dark.png'
                                : 'assets/images/bismillah_light.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const MuhammadLogo(),
                ],
              ),
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
                        imagePath: 'assets/images/$themeName/quran.png',
                        title: language == 'bn' ? "আল-কুরআন" : 'Al-Quran',
                        nextScreen: MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => BookmarkedListProvider(),
                            ),
                            ChangeNotifierProvider(
                              create: (context) => SurahListProvider(),
                            ),
                            ChangeNotifierProvider(
                              create: (context) => FavouriteSurahListProvider(),
                            ),
                            ChangeNotifierProvider(
                              create: (context) =>
                                  SubjectWiseQuranListProvider(),
                            ),
                            ChangeNotifierProvider(
                              create: (context) => MushafQuranSurahProvider(),
                            ),
                          ],
                          child: const QuranBottomTab(),
                        ),
                      ),
                      HomeTopic(
                        title: language == 'en' ? "Settings" : "সেটিংস",
                        nextScreen: const Settings(),
                        icon: FaIcon(
                          FontAwesomeIcons.sliders,
                          size: 32,
                          color: colors.activeColor1,
                        ),
                      ),
                      HomeTopic(
                        title: language == 'bn' ? "ডাউনলোডস" : "Downloads",
                        nextScreen: MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => SurahListProvider(),
                            ),
                          ],
                          child: const DownloadedSurah(),
                        ),
                        icon: Icon(
                          Icons.download_for_offline,
                          color: colors.activeColor1,
                          size: 40,
                        ),
                      ),
                      HomeTopic(
                        title: language == 'bn' ? "ফিচারস" : "Features",
                        nextScreen: const FeaturesHome(),
                        icon: FaIcon(
                          FontAwesomeIcons.icons,
                          color: colors.activeColor1,
                          size: 35,
                        ),
                      ),
                      // HomeTopic(
                      //   title: language == 'bn' ? "প্রণেতা" : "Author",
                      //   nextScreen: const AboutMe(),
                      //   icon: FaIcon(
                      //     FontAwesomeIcons.solidUser,
                      //     color: colors.activeColor1,
                      //     size: 35,
                      //   ),
                      // ),
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
