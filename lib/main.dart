import 'package:al_quran/nofification/notification.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/downloaded_surah_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/provider/app/silent_prayer_time_provider.dart';
import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/provider/theme/theme_provider.dart';
import 'package:al_quran/screenns/spash_screen.dart';
import 'package:al_quran/utils/shared_pref.dart';
import 'package:al_quran/widgets/status_and_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(ignoreSsl: true);
  await NotificationService.init();

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
      ChangeNotifierProvider(
        create: (context) => SilentPrayerTimeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CalenderInfoProvider(),
      )
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
      title: "মুসলিম প্রতিদিন - কালার কোরআন",
      debugShowCheckedModeBanner: false,
      home: StatusAndNavigationBarProvider(child: SplashScreenn()),
    );
  }
}
