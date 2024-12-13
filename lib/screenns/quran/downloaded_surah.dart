import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/downloaded_surah_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/downloaded_surah_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DownloadedSurah extends HookWidget {
  const DownloadedSurah({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final appInfoProvider = Provider.of<AppInfoProvider>(context);
    final downloadedSurahProvider =
        Provider.of<DownloadedSurahProvider>(context);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        downloadedSurahProvider
            .getDownloadedSurahNames(appInfoProvider.storagePath + '/audio');
      });

      return null;
    }, []);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.download,
              title: language == 'bn' ? 'ডাউনলোডস' : 'Downloads',
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: downloadedSurahProvider.isLoadinng
                    ? const Center(
                        child: Loader(),
                      )
                    : downloadedSurahProvider.surahNames.isEmpty
                        ? Center(
                            child: CustomText(
                              text: language == 'bn'
                                  ? 'আপনার ডাউনলোড তালিকা খালি!'
                                  : 'Your download list is empty!',
                              additionalStyle: TextStyle(
                                fontSize: 18,
                                color: colors.activeColor1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                downloadedSurahProvider.surahNames.length,
                            itemBuilder: (context, index) {
                              List<String> infos = downloadedSurahProvider
                                  .surahNames[index]
                                  .split('_');
                              String reciter = infos.last;
                              int surahId = int.parse(infos[1]);
                              SingleSurahInfo surahInfo =
                                  downloadedSurahProvider
                                      .surahList[surahId - 1];

                              return DownloadedSurahItem(
                                surahInfo: surahInfo,
                                surahId: surahId,
                                reciterName: reciterNames[reciter]!,
                                reciter: reciter,
                              );
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
