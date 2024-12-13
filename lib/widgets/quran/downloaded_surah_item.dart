import 'dart:async';
import 'dart:io';

import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/downloaded_surah_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/screenns/quran/single_surah.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/file_name_generator.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:al_quran/widgets/button.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DownloadedSurahItem extends StatelessWidget {
  final SingleSurahInfo surahInfo;
  final int surahId;
  final String reciter;
  final String reciterName;
  const DownloadedSurahItem({
    super.key,
    required this.surahInfo,
    required this.surahId,
    required this.reciter,
    required this.reciterName,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final appInfoProvider = Provider.of<AppInfoProvider>(context);
    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);

    Future<void> deleteTheSurah(String reciter) async {
      try {
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        String timingFilePath =
            '${documentDirectory.path}/audioTiming/${createAudioTimingFileName(surahId, reciter)}';
        File timingFile = File(timingFilePath);

        Directory dir = Directory(
            '${appInfoProvider.storagePath}/audio/${createAudioFileDir(surahId, reciter)}');

        // ignore: use_build_context_synchronously
        deleteSurahBox(context, timingFile, dir);
      } catch (e) {
        showToast('Something went wrong!', colors.activeColor1);
      }
    }

    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        color: colors.bgColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: colors.bgColor1,
        child: InkWell(
          splashColor: colors.activeColor1.withOpacity(0.2),
          onTap: () {
            alQuranInfoProvider.setReciter(value: reciter);
            Timer(const Duration(milliseconds: 200), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => SingleSurahProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => SingleSurahInfoProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => WordInfoProvider(),
                      ),
                    ],
                    child: SingleSurah(
                      surahId: surahId,
                    ),
                  ),
                ),
              );
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 41,
                  height: 41,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors.bgColor2,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Icon(
                        Icons.download_done,
                        color: colors.activeColor1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: language == 'bn'
                            ? surahInfo.nameBn
                            : surahInfo.nameEn,
                        additionalStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      CustomText(
                        text: reciterName,
                        additionalStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 41,
                  height: 41,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors.bgColor2,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteTheSurah(reciter);
                        },
                        icon: Icon(
                          Icons.delete_sharp,
                          color: colors.activeColor1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteSurahBox(
      BuildContext context, File audioTimingFile, Directory surahDir) {
    showDialog(
      context: context,
      builder: (context) {
        final language = getLanguage(context);
        final colors = getTheme(context).colors;
        final downloadedSurahProvider =
            Provider.of<DownloadedSurahProvider>(context, listen: false);
        final appInfoProvider = Provider.of<AppInfoProvider>(context);

        return Dialog(
          clipBehavior: Clip.antiAlias,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            color: colors.bgColor2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 3),
                  decoration: BoxDecoration(
                    color: colors.bgColor1,
                    border: Border(
                      bottom: BorderSide(color: colors.activeColor1, width: 3),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: language == 'bn' ? 'ডিলিট!' : 'Delete!',
                        additionalStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: CustomText(
                    text: language == 'bn'
                        ? 'আপনি কি সূরাটি ডিলিট করতে চান?'
                        : 'Do you want to delete this Surah?',
                    additionalStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Button(
                          label: 'No',
                          onPress: () {
                            Navigator.pop(context);
                          },
                        ),
                        Button(
                          label: 'Yes',
                          onPress: () async {
                            try {
                              await audioTimingFile.delete();
                              await surahDir.delete(recursive: true);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);

                              showToast(
                                  'Successfully Deleted!', colors.activeColor1);
                              downloadedSurahProvider.getDownloadedSurahNames(
                                  appInfoProvider.storagePath + '/audio');
                            } catch (e) {
                              showToast(
                                  'Something went wrong!', colors.activeColor1);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
