// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/mushaf_quran_surah_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/base64_fonts.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/audio_player_box.dart';
import 'package:al_quran/widgets/quran/mushaf_surah_info.dart';
import 'package:al_quran/widgets/quran/tajweed_style.dart';
import 'package:al_quran/widgets/quran/word_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MushafQuranSurah extends HookWidget {
  final int surahId;
  MushafQuranSurah({super.key, required this.surahId});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;
    final isDark = getTheme(context).isDark;
    final mushafQuranSurahProvider =
        Provider.of<MushafQuranSurahProvider>(context, listen: false);
    final singleSurahInfo =
        Provider.of<SingleSurahInfoProvider>(context, listen: false);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    final wordInfoProvider =
        Provider.of<WordInfoProvider>(context, listen: false);

    useEffect(() {
      alQuranInfoProvider.quranSettingsBoxHandler(value: false);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Timer(const Duration(milliseconds: 500), () {
          singleSurahInfo.audioPlayerHandler(value: false);
          singleSurahInfo.setCurrentVers(1);
          singleSurahInfo.setSecondaryCurrentVerse(1);
          singleSurahInfo.setIndexOfAyahInView(-1);
          mushafQuranSurahProvider.readSurahFromDB(surahId, language);
        });
      });
      return null;
    }, [surahId]);

    return WillPopScope(
      onWillPop: () async {
        appInfoProvider.surahWbController!
            .evaluateJavascript(source: 'clearBody();');
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Selector<MushafQuranSurahProvider, Tuple2<bool, String>>(
                selector: (_, provider) =>
                    Tuple2(provider.isLoading, provider.data),
                builder: (_, value, __) {
                  return Column(
                    children: [
                      MushafSurahInformation(
                        surahInfo: mushafQuranSurahProvider.surahInfo,
                        isLoading: mushafQuranSurahProvider.isLoading,
                      ),
                      Expanded(
                        child: Container(
                          color: colors.bgColor2,
                          child: mushafQuranSurahProvider.isLoading
                              ? const Center(child: Loader())
                              : Builder(
                                  builder: (context) {
                                    String bismillahImage = "";
                                    if (surahId != 1 && surahId != 9) {
                                      if (isDark) {
                                        bismillahImage = """
<div class="bismillahImage"><img src='https://appassets.androidplatform.net/assets/flutter_assets/assets/images/bismillah_dark.png'></div>
""";
                                      } else {
                                        bismillahImage = """
<div class="bismillahImage"><img src='https://appassets.androidplatform.net/assets/flutter_assets/assets/images/bismillah_light.png'></div>
""";
                                      }
                                    }
                                    String fullSurahHtml = bismillahImage +
                                        mushafQuranSurahProvider.data;
                                    var htmlContent = """
        <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <style>
          @font-face { font-family: "indopak"; src: url(data:font/truetype;charset=utf-8;base64,${base64Fonts[indopakFont]}) format("truetype"); }
      
          :root {
            --arabic-font-size: ${appInfoProvider.arabicTextSize}px;
          }
          :root {
            --arabic-font-family: 'indopak';
          }
          :root {
            --text-color: ${colors.txtColor.toCssString()};
          }
          :root {
            --bg-color1: ${colors.bgColor1.toCssString()};
          }
          :root {
            --active-color: ${colors.activeColor1.toCssString()};
          }
          :root {
            --active-word-color: ${colors.activeColor1.withOpacity(0.3).toCssString()};
          }
      
          * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
          }
      
          body {
            padding-bottom: 300px;
            color: var(--text-color);
          }
      
          .bismillahImage {
            display: flex;
            justify-content: center;
            padding: 3px 0px;
          }
      
          .bismillahImage img {
            height: 40px;
          }
      
          .pageInfo {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--bg-color1);
            padding: 5px 0;
            gap: 5px;
          }
      
          .pageInfo .info {
            display: inline-block;
            font-size: 11px;
            border: 1.5px solid var(--active-color);
            padding: 2px 8px;
            padding-bottom: ${language == 'bn' ? '0px' : '2px'};
            border-radius: 80px;
            color: var(--active-color);
          }
      
          .verses {
            display: flex;
            flex-wrap: wrap;
            direction: rtl;
            align-items: center;
            padding: 5px 10px;
            font-size: var(--arabic-font-size);
            justify-content: center;
            font-family: var(--arabic-font-family);
          }
      
          .verseId {
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--text-color);
            height: 20px;
            width: 20px;
            border-radius: 20px;
            margin: 0px 5px;
            font-family: '';
          }
      
          .id {
            font-size: 10px;
          }
      
          .word {
            scroll-margin-top: 35px;
          }
      
          $tajweedStyle
      
          .activeWord {
            background-color: var(--active-word-color);
          }
      </style>
        </head>
        <body class="${alQuranInfoProvider.isEnableTajweed ? 'tajweed' : ''}">
        $fullSurahHtml
      <script>
document.addEventListener('DOMContentLoaded', function () {
  const words = document.querySelectorAll(".word");

  words.forEach((word) => {
    word.addEventListener("click", () => {
      window.flutter_inappwebview.callHandler('wordPosition', word.classList[1]);
      window.flutter_inappwebview.callHandler('wordAudioPath', word.getAttribute("data-audio"));

      word.classList.add("activeWord");
      setTimeout(() => {
        word.classList.remove("activeWord");
      }, 1000)
    });
  });
});
      
function arabicTextSizeHandler(size) {
  document.documentElement.style.setProperty('--arabic-font-size', size + 'px');
}

function toggleTajweed() {
  document.body.classList.toggle('tajweed');
}

function arabicFontHandler(font) {
  document.documentElement.style.setProperty('--arabic-font-family', font);
}

function setTextColor(color) {
  document.documentElement.style.setProperty('--text-color', color);
}

function setWarnBgColor(color) {}

function setBgColor1(color) {
  document.documentElement.style.setProperty('--bg-color1', color);
}

function setActiveColor(color) {
  document.documentElement.style.setProperty('--active-color', color);
}

function setActiveWordColor(color) {
  document.documentElement.style.setProperty('--active-word-color', color);
}

function bismillahImageHandler(isDark) {
  const bismillahImage = document.querySelector('.bismillahImage img');
  if (bismillahImage) {
    if (isDark) {
      bismillahImage.src = 'https://appassets.androidplatform.net/assets/flutter_assets/assets/images/bismillah_dark.png';
    } else {
      bismillahImage.src = 'https://appassets.androidplatform.net/assets/flutter_assets/assets/images/bismillah_light.png';
    }
  }
}

function scrollAyahToTop(v, s) {
  const wordClass = s + "_" + v + "_" + "1";
  const verse = document.getElementsByClassName(wordClass)[0];
  verse.scrollIntoView({block: "start", behavior: "smooth"});
}

function highlightWord(s, v, w, isHighlightWord = true) {
  const activeWord = document.getElementsByClassName("activeWord");
  if (activeWord.length > 0) activeWord[0].classList.remove("activeWord");
  const wordClass = s + "_" + v + "_" + w;
  const word = document.getElementsByClassName(wordClass);
  if (isHighlightWord && word.length > 0) {
    word[0].classList.add("activeWord");
  }
}

function clearBody() {
  document.body.innerHTML = '';
}
      </script>
        </body>
      </html>
                                            """;

                                    return InAppWebView(
                                      initialData: InAppWebViewInitialData(
                                          data: htmlContent),
                                      initialSettings: InAppWebViewSettings(
                                        transparentBackground: true,
                                        verticalScrollBarEnabled: false,
                                        horizontalScrollBarEnabled: false,
                                        supportZoom: false,
                                        builtInZoomControls: false,
                                        maximumZoomScale: 1.0,
                                        webViewAssetLoader: WebViewAssetLoader(
                                          domain:
                                              "appassets.androidplatform.net",
                                          pathHandlers: [
                                            AssetsPathHandler(path: '/assets/')
                                          ],
                                        ),
                                      ),
                                      onWebViewCreated: (controller) {
                                        alQuranInfoProvider
                                            .setWbController(controller);
                                        appInfoProvider
                                            .setWbController(controller);

                                        controller.addJavaScriptHandler(
                                          handlerName: 'wordPosition',
                                          callback: (args) {
                                            if (alQuranInfoProvider
                                                .isEnableWordMeaningAudio) {
                                              wordInfoProvider
                                                  .readWordInfoFromDB(args[0]);
                                            }
                                          },
                                        );

                                        controller.addJavaScriptHandler(
                                          handlerName: 'wordAudioPath',
                                          callback: (args) async {
                                            if (alQuranInfoProvider
                                                .isEnableWordMeaningAudio) {
                                              await player.setUrl(
                                                  'https://audio.qurancdn.com/${args[0]}');
                                              await player.play();
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const WordInfoBox(),
              Selector<MushafQuranSurahProvider, bool>(
                selector: (_, provider) => provider.isLoading,
                builder: (_, isLoading, __) {
                  if (isLoading) {
                    return const SizedBox();
                  }

                  return Selector<AlQuranInfoProvider, bool>(
                    selector: (_, provider) => provider.isEnableAudioPlayer,
                    builder: (_, value, __) {
                      if (value == false) {
                        return const SizedBox();
                      }

                      return AnimatedPositioned(
                        width: MediaQuery.of(context).size.width,
                        duration: const Duration(milliseconds: 200),
                        bottom: value ? -275 : -1000,
                        child: AudioPlayerBox(
                          surahId: mushafQuranSurahProvider.surahInfo!.id,
                          versePositionStart:
                              mushafQuranSurahProvider.versePositionStart,
                          totalAyah:
                              mushafQuranSurahProvider.surahInfo!.totalAyah,
                          versesPositions:
                              mushafQuranSurahProvider.versesPositions,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
