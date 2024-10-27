import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/downloaded_surah_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/provider/theme/theme_provider.dart';
import 'package:al_quran/screenns/spash_screen.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/status_and_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppInfoProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(context),
      ),
      ChangeNotifierProvider(
        create: (context) => AlQuranInfoProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SingleSurahInfoProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DownloadedSurahProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    MediaQuery.of(context).platformBrightness;

    if (themeProvider.mode == 'system') {
      setValueInSharedPref('theme', 'system');
      themeProvider.setTheme(context: context);
    }

    return const MaterialApp(
      title: "Al Quran",
      debugShowCheckedModeBanner: false,
      home: StatusAndNavigationBarProvider(child: SplashScreenn()),
    );
  }
}
