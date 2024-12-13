import 'package:al_quran/screenns/about_me.dart';
import 'package:al_quran/screenns/calendar/calender.dart';

import 'package:al_quran/screenns/features/features_home.dart';
import 'package:al_quran/screenns/quran/downloaded_surah.dart';
import 'package:al_quran/screenns/quran/quran_bottom_tab.dart';
import 'package:al_quran/screenns/settings.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/allah_logo.dart';
import 'package:al_quran/widgets/home_screen_calender_data.dart';
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
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Stack(
                  children: [
                    const SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: HomeScreenCalenderData(),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxWidth: 367),
                              width: MediaQuery.of(context).size.width - 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                color: colors.activeColor1,
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.txtColor
                                        .withOpacity(isDark ? 0.2 : 0.4),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(5),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 5,
                                  children: [
                                    HomeTopic(
                                      width: 25,
                                      imagePath:
                                          'assets/images/$themeName/quran.png',
                                      title: language == 'bn'
                                          ? "আল-কুরআন"
                                          : 'Al-Quran',
                                      nextScreen: MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                BookmarkedListProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                SurahListProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                FavouriteSurahListProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                SubjectWiseQuranListProvider(),
                                          ),
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                MushafQuranSurahProvider(),
                                          ),
                                        ],
                                        child: const QuranBottomTab(),
                                      ),
                                    ),
                                    HomeTopic(
                                      title: language == 'bn'
                                          ? "ক্যালেন্ডার"
                                          : "Calender",
                                      nextScreen: const Calendar(),
                                      icon: FaIcon(
                                        FontAwesomeIcons.calendarDays,
                                        size: 24,
                                        color: colors.activeColor1,
                                      ),
                                    ),
                                    HomeTopic(
                                      title: language == 'bn'
                                          ? "ফিচারস"
                                          : "Features",
                                      nextScreen: const FeaturesHome(),
                                      icon: FaIcon(
                                        FontAwesomeIcons.icons,
                                        color: colors.activeColor1,
                                        size: 24,
                                      ),
                                    ),
                                    HomeTopic(
                                      title: language == 'en'
                                          ? "Settings"
                                          : "সেটিংস",
                                      nextScreen: const Settings(),
                                      icon: FaIcon(
                                        FontAwesomeIcons.sliders,
                                        size: 24,
                                        color: colors.activeColor1,
                                      ),
                                    ),
                                    HomeTopic(
                                      title: language == 'bn'
                                          ? "ডাউনলোডস"
                                          : "Downloads",
                                      nextScreen: MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                SurahListProvider(),
                                          ),
                                        ],
                                        child: const DownloadedSurah(),
                                      ),
                                      icon: Icon(
                                        Icons.download_for_offline,
                                        color: colors.activeColor1,
                                        size: 24,
                                      ),
                                    ),
                                    HomeTopic(
                                      title: language == 'bn'
                                          ? "প্রণেতা"
                                          : "Author",
                                      nextScreen: const AboutMe(),
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidUser,
                                        color: colors.activeColor1,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
