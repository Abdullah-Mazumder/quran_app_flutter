// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:al_quran/nofification/notification.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/debounce_handler.dart';
import 'package:al_quran/utils/file_name_generator.dart';
import 'package:al_quran/utils/request_permission.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:al_quran/widgets/button.dart';
import 'package:al_quran/widgets/checkbox_with_label.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/selectbox_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
void downloadCallback(id, status, progress) {
  final SendPort send =
      IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([progress]);
}

class AudioPlayerBox extends HookWidget {
  final int surahId;
  final int versePositionStart;
  final int totalAyah;
  final List<dynamic> versesPositions;
  const AudioPlayerBox({
    super.key,
    required this.surahId,
    required this.versePositionStart,
    required this.totalAyah,
    required this.versesPositions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);
    final singleSurahInfo =
        Provider.of<SingleSurahInfoProvider>(context, listen: false);
    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);

    int currentAyahPlayeing = 1;
    int ayahRepeatation = 1;

    int totalFiles = versesPositions.length;
    int totalUndownloadedFiles = 0;
    int totalAlreadyDownloadedFiles = 0;
    int downloadedFiles = 0;

    ReceivePort port = ReceivePort();

    Future<void> showDownloadNotification(int progress) async {
      await NotificationService.showProgressNotification(progress, totalFiles);

      if (progress == totalFiles && progress > 0) {
        await NotificationService.cancelNotification(0);
      }
    }

    useEffect(() {
      IsolateNameServer.registerPortWithName(
          port.sendPort, 'downloader_send_port');
      port.listen((dynamic data) {
        if (data[0] == 100) {
          downloadedFiles++;
        }

        showDownloadNotification(downloadedFiles + totalAlreadyDownloadedFiles);

        if (downloadedFiles == totalUndownloadedFiles && downloadedFiles > 0) {
          singleSurahInfo.setIsDownloadedSurah(true);
          showToast('Download Completed!', colors.activeColor1);
        }
      });
      FlutterDownloader.registerCallback(downloadCallback);

      return null;
    }, []);

    useEffect(() {
      void fn() async {
        Directory dir = Directory(
            '${appInfoProvider.storagePath}/audio/${createAudioFileDir(surahId, alQuranInfoProvider.reciter)}');

        if ((await dir.exists())) {
          List<FileSystemEntity> files = dir.listSync();
          int diff = totalAyah - files.length;
          if (diff == 0) {
            singleSurahInfo.setIsDownloadedSurah(true);
          } else {
            singleSurahInfo.setIsDownloadedSurah(false);
          }
        } else {
          singleSurahInfo.setIsDownloadedSurah(false);
        }
      }

      fn();

      Future<void> fn2() async {
        if (singleSurahInfo.audioPlayer != null) {
          try {
            await singleSurahInfo.audioPlayer!.stop();
            await singleSurahInfo.audioPlayer!.dispose();
            singleSurahInfo.setAudioPlayer(player: null);
            singleSurahInfo.audioLoadingHandler(false);
            singleSurahInfo.audioPlayingHandler(false);
            singleSurahInfo.setAudioTimingInfo(value: null);
            // ignore: empty_catches
          } catch (e) {}
        }
      }

      fn2();

      return null;
    }, [alQuranInfoProvider.reciter, surahId]);

    useEffect(() {
      return () {
        singleSurahInfo.clearAudioCach();
        IsolateNameServer.removePortNameMapping('downloader_send_port');
      };
    }, []);

    Future<void> downloadTheSurah() async {
      try {
        Directory audioDir = Directory(
            '${appInfoProvider.storagePath}/audio/${createAudioFileDir(surahId, alQuranInfoProvider.reciter)}');
        if (!audioDir.existsSync()) {
          await audioDir.create(recursive: true);
        }

        Directory documentDirectory = await getApplicationDocumentsDirectory();
        Directory audioTimingDir =
            Directory('${documentDirectory.path}/audioTiming');
        if (!audioTimingDir.existsSync()) {
          await audioTimingDir.create();
        }

        var url =
            'https://api.qurancdn.com/api/qdc/audio/reciters/${alQuranInfoProvider.reciter.split('~')[0]}/audio_files?chapter=$surahId&segments=true';

        final res = await http.get(Uri.parse(url));
        final response = jsonDecode(res.body);

        final timings =
            json.encode(response['audio_files'][0]['verse_timings']);
        File file = File(
            '${audioTimingDir.path}/${createAudioTimingFileName(surahId, alQuranInfoProvider.reciter)}');

        await file.parent.create(recursive: true);
        await file.writeAsString(timings);

        showToast('Download Starded....', colors.activeColor1);

        List<Future<String?>> downloadTasks = [];

        for (int i = 0; i < totalFiles; i++) {
          final fileName = '${i + 1}.mp3';
          final url = 'https://cdn.islamic.network/quran/audio/64/'
              '${alQuranInfoProvider.reciter.split('~')[1]}/${versesPositions[i]}.mp3';

          File file = File('${audioDir.path}/$fileName');

          if (!file.existsSync()) {
            downloadTasks.add(FlutterDownloader.enqueue(
              url: url,
              savedDir: audioDir.path,
              fileName: fileName,
              showNotification: false,
              openFileFromNotification: false,
            ));
          }
        }

        totalUndownloadedFiles = downloadTasks.length;
        totalAlreadyDownloadedFiles = totalFiles - totalUndownloadedFiles;

        Future.wait(downloadTasks);
      } catch (e) {
        showToast('Something went wrong!', colors.activeColor1);
      }
    }

    Future<void> deleteTheSurah() async {
      try {
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        String timingFilePath =
            '${documentDirectory.path}/audioTiming/${createAudioTimingFileName(surahId, alQuranInfoProvider.reciter)}';
        File timingFile = File(timingFilePath);

        Directory dir = Directory(
            '${appInfoProvider.storagePath}/audio/${createAudioFileDir(surahId, alQuranInfoProvider.reciter)}');

        // ignore: use_build_context_synchronously
        deleteSurahBox(context, timingFile, dir);
      } catch (e) {
        showToast('Something went wrong!', colors.activeColor1);
      }
    }

    List<List<int>> updateTimingFile(List<dynamic> jsonObj) {
      final List<List<int>> data = [];

      jsonObj.asMap().forEach((verseIndex, item) {
        int st = 0;
        int end = 0;
        final List<int> wordsTimings = [];

        for (var segment in (item['segments'] as List<dynamic>)) {
          if (segment.length == 3) {
            final List<dynamic> segmentList = List<dynamic>.from(segment);
            final int wordId = segmentList[0].toInt();
            final int wordStart = segmentList[1].toInt();
            final int wordEnd = segmentList[2].toInt();
            final int diff = wordEnd - wordStart;
            end += diff;

            for (; st <= end; st++) {
              wordsTimings.add(wordId);
            }
          }
        }

        data.add(wordsTimings);
      });

      return data;
    }

    Future<void> playVerse(int verseId) async {
      try {
        if (singleSurahInfo.audioPlayer != null) {
          await singleSurahInfo.audioPlayer!.dispose();
        }

        final player = AudioPlayer();
        await player.setSpeed(double.parse(alQuranInfoProvider.playbackSpeed));
        singleSurahInfo.setAudioPlayer(player: player);

        singleSurahInfo.audioPlayer!.playerStateStream.listen((event) {
          if (event.processingState == ProcessingState.idle ||
              event.processingState == ProcessingState.loading ||
              event.processingState == ProcessingState.buffering) {
            singleSurahInfo.audioLoadingHandler(true);
            singleSurahInfo.audioPlayingHandler(false);
          }

          if (event.processingState == ProcessingState.ready) {
            singleSurahInfo.audioLoadingHandler(false);
            singleSurahInfo.audioPlayingHandler(true);
          }
        });

        List<int> currentAyahTimings = singleSurahInfo
            .audioTimingInfo!['$surahId'][currentAyahPlayeing - 1];

        singleSurahInfo.audioPlayer!.positionStream.listen((event) {
          int position = event.inMilliseconds;
          if (position > 0 && position < currentAyahTimings.length) {
            appInfoProvider.surahWbController!.evaluateJavascript(
                source:
                    'highlightWord($surahId, $currentAyahPlayeing, ${currentAyahTimings[position]}, ${alQuranInfoProvider.isWordHighLight});');
          }
        });

        if (singleSurahInfo.isDownloadedSurah) {
          String audioFilePath =
              '${appInfoProvider.storagePath}/audio/${createAudioFileDir(surahId, alQuranInfoProvider.reciter)}/$verseId.mp3';
          await singleSurahInfo.audioPlayer!.setUrl(audioFilePath);
        } else {
          var audioUrl =
              'https://cdn.islamic.network/quran/audio/64/${alQuranInfoProvider.reciter.split('~')[1]}/${versePositionStart - 1 + verseId}.mp3';
          await singleSurahInfo.audioPlayer!.setUrl(audioUrl);
        }
        await singleSurahInfo.audioPlayer!.play();

        singleSurahInfo.audioPlayer!.playerStateStream.listen((event) async {
          if (event.processingState == ProcessingState.completed) {
            appInfoProvider.surahWbController!
                .evaluateJavascript(source: 'highlightWord(115, 1, 1);');

            if (ayahRepeatation < int.parse(alQuranInfoProvider.ayahRepeats)) {
              await singleSurahInfo.audioPlayer!.seek(Duration.zero);
              singleSurahInfo.audioPlayer!.play();
              ayahRepeatation++;
            } else {
              if (alQuranInfoProvider.isPlayFullSurah) {
                currentAyahPlayeing++;
                if (currentAyahPlayeing <= totalAyah) {
                  appInfoProvider.surahWbController!.evaluateJavascript(
                      source:
                          'scrollAyahToTop($currentAyahPlayeing, $surahId);');
                  singleSurahInfo.setCurrentVers(currentAyahPlayeing);
                  singleSurahInfo.setSecondaryCurrentVerse(currentAyahPlayeing);
                  playVerse(currentAyahPlayeing);
                  ayahRepeatation = 1;
                } else {
                  await singleSurahInfo.clearAudioCach();
                }
              } else {
                await singleSurahInfo.clearAudioCach();
              }
            }
          }
        });
      } catch (e) {
        singleSurahInfo.clearAudioCach();
      }
    }

    Future<void> loadAndPlaySurah() async {
      if (singleSurahInfo.audioPlayer != null) {
        singleSurahInfo.audioPlayer!.play();
        singleSurahInfo.audioPlayingHandler(true);
        return;
      }

      singleSurahInfo.audioLoadingHandler(true);
      singleSurahInfo.audioPlayingHandler(false);

      if (!singleSurahInfo.isDownloadedSurah) {
        showToast(
            language == 'bn'
                ? 'অডিও ইন্টারনেট থেকে লোড হচ্ছে...'
                : 'Audio Is Loading From Internet...',
            colors.activeColor1);
        var url =
            'https://api.qurancdn.com/api/qdc/audio/reciters/${alQuranInfoProvider.reciter.split('~')[0]}/audio_files?chapter=$surahId&segments=true';

        final res = await http.get(Uri.parse(url));
        final response = jsonDecode(res.body);

        final timings = response['audio_files'][0]['verse_timings'];

        final List<List<int>> updatedTimingInfo = updateTimingFile(timings);

        singleSurahInfo
            .setAudioTimingInfo(value: {'$surahId': updatedTimingInfo});
      } else {
        String audioTimingFilePath =
            '${(await getApplicationDocumentsDirectory()).path}/audioTiming/${createAudioTimingFileName(surahId, alQuranInfoProvider.reciter)}';
        File audioTimingFile = File(audioTimingFilePath);
        String content = await audioTimingFile.readAsString();
        List<dynamic> jsonData = jsonDecode(content);

        final List<List<int>> updatedTimingInfo = updateTimingFile(jsonData);

        singleSurahInfo
            .setAudioTimingInfo(value: {'$surahId': updatedTimingInfo});
      }

      currentAyahPlayeing = singleSurahInfo.ayahInViewIndex + 1;
      appInfoProvider.surahWbController!.evaluateJavascript(
          source: 'scrollAyahToTop($currentAyahPlayeing, $surahId);');
      ayahRepeatation = 1;
      singleSurahInfo.setCurrentVers(currentAyahPlayeing);
      singleSurahInfo.setSecondaryCurrentVerse(currentAyahPlayeing);
      playVerse(currentAyahPlayeing);
    }

    Future<void> playBack() async {
      if (singleSurahInfo.currentVerse - 1 > 0) {
        if (singleSurahInfo.audioPlayer != null &&
            singleSurahInfo.isAudioPlayeing) {
          await singleSurahInfo.audioPlayer!.stop();
          singleSurahInfo.setAudioPlayer(player: null);
          singleSurahInfo.audioPlayingHandler(false);
          singleSurahInfo.audioLoadingHandler(true);
          appInfoProvider.surahWbController!
              .evaluateJavascript(source: 'highlightWord(115, 1, 1);');
          currentAyahPlayeing = singleSurahInfo.currentVerse - 1;
          ayahRepeatation = 1;
          playVerse(currentAyahPlayeing);
        }

        appInfoProvider.surahWbController!.evaluateJavascript(
          source:
              'scrollAyahToTop(${singleSurahInfo.currentVerse - 1}, $surahId);',
        );

        singleSurahInfo.setCurrentVers(singleSurahInfo.currentVerse - 1);
        singleSurahInfo.setSecondaryCurrentVerse(singleSurahInfo.currentVerse);
      }
    }

    Future<void> playNext() async {
      if (singleSurahInfo.currentVerse + 1 <= totalAyah) {
        if (singleSurahInfo.audioPlayer != null &&
            singleSurahInfo.isAudioPlayeing) {
          await singleSurahInfo.audioPlayer!.stop();
          singleSurahInfo.setAudioPlayer(player: null);
          singleSurahInfo.audioPlayingHandler(false);
          singleSurahInfo.audioLoadingHandler(true);
          appInfoProvider.surahWbController!
              .evaluateJavascript(source: 'highlightWord(115, 1, 1);');
          currentAyahPlayeing = singleSurahInfo.currentVerse + 1;
          ayahRepeatation = 1;
          playVerse(currentAyahPlayeing);
        }

        appInfoProvider.surahWbController!.evaluateJavascript(
            source:
                'scrollAyahToTop(${singleSurahInfo.currentVerse + 1}, $surahId);');

        singleSurahInfo.setCurrentVers(singleSurahInfo.currentVerse + 1);
        singleSurahInfo.setSecondaryCurrentVerse(singleSurahInfo.currentVerse);
      }
    }

    return Selector<SingleSurahInfoProvider, bool>(
      selector: (_, provider) => provider.isAudioPlayerOpen,
      builder: (_, value, __) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          bottom: value ? 0 : -275,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            onVerticalDragStart: (details) {
              singleSurahInfo.audioPlayerHandler();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: colors.bgColor1,
                border: Border(
                  top: BorderSide(color: colors.activeColor1, width: 5),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Selector<SingleSurahInfoProvider,
                      Tuple3<dynamic, bool, bool>>(
                    selector: (_, provider) => Tuple3(provider.audioPlayer,
                        provider.isAudioLoading, provider.isAudioPlayeing),
                    builder: (_, value, __) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: -7,
                        children: [
                          IconButton(
                            onPressed: debounceHandler(() {
                              playBack();
                            }),
                            icon: FaIcon(
                              FontAwesomeIcons.backward,
                              color: colors.activeColor1,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            child: value.item2
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                        top: 17, left: 15, right: 15),
                                    child: Loader(
                                      lh: 15,
                                      lw: 15,
                                    ),
                                  )
                                : value.item3
                                    ? IconButton(
                                        onPressed: () async {
                                          await singleSurahInfo.audioPlayer!
                                              .pause();
                                          singleSurahInfo
                                              .audioPlayingHandler(false);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.pause,
                                          color: colors.activeColor1,
                                          size: 20,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: loadAndPlaySurah,
                                        icon: FaIcon(
                                          FontAwesomeIcons.play,
                                          color: colors.activeColor1,
                                          size: 20,
                                        ),
                                      ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (value.item1 != null) {
                                await singleSurahInfo.clearAudioCach();
                                appInfoProvider.surahWbController!
                                    .evaluateJavascript(
                                        source: 'highlightWord(115, 1, 1);');
                              }
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidSquare,
                              color: value.item1 == null
                                  ? colors.activeColor1.withOpacity(0.5)
                                  : colors.activeColor1,
                              size: 19,
                            ),
                          ),
                          IconButton(
                            onPressed: debounceHandler(() {
                              playNext();
                            }),
                            icon: FaIcon(
                              FontAwesomeIcons.forward,
                              color: colors.activeColor1,
                              size: 20,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Selector<SingleSurahInfoProvider, Tuple2<int, int>>(
                    selector: (_, provider) => Tuple2(
                        provider.currentVerse, provider.secondaryCurrentVerse),
                    builder: (_, value, __) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: language == 'bn'
                                      ? convertEnglishToBanglaNumber(
                                          value.item2)
                                      : value.item2.toString(),
                                  additionalStyle: TextStyle(
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: '',
                                  ),
                                ),
                                CustomText(
                                  text: language == 'bn'
                                      ? convertEnglishToBanglaNumber(totalAyah)
                                      : totalAyah.toString(),
                                  additionalStyle: TextStyle(
                                    color: colors.activeColor1,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 7.0,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                min: 1.0,
                                max: totalAyah.toDouble(),
                                divisions: 5000,
                                value: value.item2.toDouble(),
                                onChangeEnd: (value) async {
                                  int newValue = value.toInt();

                                  appInfoProvider.surahWbController!
                                      .evaluateJavascript(
                                          source:
                                              'scrollAyahToTop($newValue, $surahId);');

                                  if (singleSurahInfo.audioPlayer != null &&
                                      singleSurahInfo.isAudioPlayeing) {
                                    await singleSurahInfo.audioPlayer!.stop();
                                    singleSurahInfo.setAudioPlayer(
                                        player: null);
                                    singleSurahInfo.audioPlayingHandler(false);
                                    singleSurahInfo.audioLoadingHandler(true);
                                    currentAyahPlayeing = newValue;
                                    ayahRepeatation = 1;
                                    playVerse(currentAyahPlayeing);
                                  }

                                  singleSurahInfo.setCurrentVers(newValue);
                                  singleSurahInfo
                                      .setSecondaryCurrentVerse(newValue);
                                },
                                onChanged: (value) {
                                  singleSurahInfo
                                      .setSecondaryCurrentVerse(value.toInt());
                                },
                                inactiveColor: colors.activeColor2,
                                activeColor: colors.activeColor1,
                                label: value.item2.toString(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Selector<AlQuranInfoProvider, bool>(
                    selector: (_, provider) => provider.isPlayFullSurah,
                    builder: (_, value, __) {
                      return CheckboxWithLabel(
                        bgColor: colors.bgColor1,
                        onChanged: () {
                          alQuranInfoProvider.setIsPlayFullSurah();
                        },
                        title: language == 'bn'
                            ? 'সম্পূর্ণ সূরা শুনুন'
                            : 'Play Full Surah',
                        value: value,
                      );
                    },
                  ),
                  Selector<AlQuranInfoProvider, String>(
                    selector: (_, provider) => provider.playbackSpeed,
                    builder: (_, value, __) {
                      return SelectBoxWithLabel(
                        bgColor: colors.bgColor1,
                        width: 100,
                        height: 500,
                        items: playbackSpeeds,
                        onChanged: (value) {
                          alQuranInfoProvider.setPlaybackSpeed(
                            value: value,
                            audioPlayer: singleSurahInfo.audioPlayer,
                          );
                        },
                        value: value,
                        label: language == 'bn'
                            ? 'প্লেব্যাক স্পীড'
                            : 'Playback Speed',
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Selector<AlQuranInfoProvider, String>(
                    selector: (_, provider) => provider.ayahRepeats,
                    builder: (_, value, __) {
                      return SelectBoxWithLabel(
                        bgColor: colors.bgColor1,
                        width: 100,
                        height: 500,
                        items: ayahRepeats,
                        onChanged: (value) {
                          alQuranInfoProvider.setAyahRepeats(value: value);
                        },
                        value: value,
                        label: language == 'bn'
                            ? 'আয়াত পুনরাবৃত্তি করুন'
                            : 'Repeat Ayah',
                      );
                    },
                  ),
                  Selector<SingleSurahInfoProvider, bool>(
                    selector: (_, provider) => provider.isDownloadedSurah,
                    builder: (_, value, __) {
                      if (value) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Material(
                            color: colors.bgColor1,
                            child: InkWell(
                              splashColor: colors.activeColor1.withOpacity(0.2),
                              onTap: () {
                                deleteTheSurah();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: language == 'bn'
                                          ? 'সূরাটি ডিলিট করুন'
                                          : 'Delete The Surah',
                                      additionalStyle: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.trash,
                                      color: colors.activeColor1,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Material(
                          color: colors.bgColor1,
                          child: InkWell(
                            splashColor: colors.activeColor1.withOpacity(0.2),
                            onTap: () async {
                              dynamic isGranted =
                                  await checkAndRequestStoragePermission();
                              if (!isGranted) {
                                showToast(
                                    language == 'bn'
                                        ? 'স্টোরেজ অনুমতি দেওয়া হয় নি!'
                                        : 'Storage Permission is not granted!',
                                    colors.activeColor1);
                                return;
                              }
                              downloadTheSurah();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: language == 'bn'
                                        ? 'সূরাটি ডাউনলোড করুন'
                                        : 'Download The Surah',
                                    additionalStyle: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.download,
                                    color: colors.activeColor1,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  deleteSurahBox(
      BuildContext context, File audioTimingFile, Directory surahDir) {
    showDialog(
      context: context,
      builder: (context) {
        final language = getLanguage(context);
        final colors = getTheme(context).colors;
        final singleSurahInfo =
            Provider.of<SingleSurahInfoProvider>(context, listen: false);

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
                              singleSurahInfo.setIsDownloadedSurah(false);
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
