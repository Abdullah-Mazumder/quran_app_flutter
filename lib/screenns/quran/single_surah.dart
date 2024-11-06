// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_info_provider.dart';
import 'package:al_quran/provider/alQuran/single_surah_provider.dart';
import 'package:al_quran/provider/alQuran/tafseer_provider.dart';
import 'package:al_quran/provider/alQuran/word_info_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/screenns/quran/short_tafseer.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/base64_fonts.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/utils/copy_text.dart';
import 'package:al_quran/utils/html_to_text.dart';
import 'package:al_quran/utils/show_toast.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/audio_player_box.dart';
import 'package:al_quran/widgets/quran/single_surah_info.dart';
import 'package:al_quran/widgets/quran/tajweed_style.dart';
import 'package:al_quran/widgets/quran/word_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SingleSurah extends HookWidget {
  final int? surahId;
  final int? bookmarkedVerseId;
  SingleSurah({super.key, this.surahId, this.bookmarkedVerseId});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final isDark = getTheme(context).isDark;
    final language = getLanguage(context);
    final appInfoProvider =
        Provider.of<AppInfoProvider>(context, listen: false);
    final alQuranInfoProvider =
        Provider.of<AlQuranInfoProvider>(context, listen: false);
    final surahData = Provider.of<SingleSurahProvider>(context, listen: false);
    final singleSurahInfo =
        Provider.of<SingleSurahInfoProvider>(context, listen: false);
    final wordInfoProvider =
        Provider.of<WordInfoProvider>(context, listen: false);

    void copyVerse(verseId) async {
      final verse = surahData.fullSurah[verseId - 1];
      final Map<String, String> bnTranslators = {
        'meaningBnAhbayan': verse.meaningBnAhbayan,
        'meaningBnMujibur': verse.meaningBnMujibur,
        'meaningBnTaisirul': verse.meaningBnTaisirul,
      };
      String textToCopy = "${htmlToText(verse.verseHtml)}\n";
      textToCopy = textToCopy.replaceFirst('۞', '');

      if (appInfoProvider.isShowBanglaTranslation) {
        textToCopy += "${bnTranslators[alQuranInfoProvider.bnTranslator]!}\n";
      }

      if (appInfoProvider.isShowEnglishTranslation) {
        textToCopy += "${verse.meaningEn}\n";
      }

      if (language == 'bn') {
        textToCopy +=
            '(সূরা - ${surahData.surahInfo!.nameBn}, আয়াত - ${convertEnglishToBanglaNumber(verse.verseId)})';
      } else {
        textToCopy +=
            '(Surah - ${surahData.surahInfo!.nameEn}, Ayah - ${verse.verseId})';
      }

      await copyTextToClipboard(textToCopy);

      showToast(
          language == 'bn' ? "কপি করা হয়েছে!" : "Copied!", colors.activeColor1);
    }

    useEffect(() {
      alQuranInfoProvider.quranSettingsBoxHandler(value: false);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Timer(const Duration(milliseconds: 600), () {
          singleSurahInfo.audioPlayerHandler(value: false);
          singleSurahInfo.setCurrentVers(1);
          singleSurahInfo.setSecondaryCurrentVerse(1);
          singleSurahInfo.setIndexOfAyahInView(-1);
          if (surahId != null) {
            surahData.readFullSurahWithIDFromDB(
              surahId!,
              language,
              alQuranInfoProvider.bookmarkedList,
              alQuranInfoProvider.history,
            );
          } else {
            surahData.readFullSurahWithIDFromDB(
              alQuranInfoProvider.lastReadSurah,
              language,
              alQuranInfoProvider.bookmarkedList,
              alQuranInfoProvider.history,
            );
          }
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
              Selector<SingleSurahProvider, Tuple2<bool, int>>(
                selector: (_, provider) =>
                    Tuple2(provider.isLoading, provider.wbProgress),
                builder: (_, value, __) {
                  String htmlContent = "";
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
                  String fullSurahHtml = bismillahImage + surahData.surahHtml;
                  if (surahData.isLoading == false) {
                    htmlContent = """
          <!DOCTYPE html>
            <html lang="en">
              <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <style>
          @font-face { font-family: 'indopak'; src: url(data:font/truetype;charset=utf-8;base64,${base64Fonts[indopakFont]}) format("truetype"); }
          @font-face { font-family: "regularFont"; src: url(data:font/truetype;charset=utf-8;base64,${base64Fonts[regularFont]}) format("truetype"); }
          
          :root {
            --arabic-font-size: ${appInfoProvider.arabicTextSize}px;
          }
          :root {
            --arabic-font-family: 'indopak';
          }
          :root {
            --bangla-font-size: ${appInfoProvider.banglaTextSize}px;
          }
          :root {
            --english-font-size: ${appInfoProvider.englishTextSize}px;
          }
          :root {
            --text-color: ${colors.txtColor.toCssString()};
          }
          :root {
            --warnBg-color: ${colors.warnBg.toCssString()};
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
            padding: 0px;
            margin: 0px;
            box-sizing: border-box;
          }
          
          body {
            color: var(--text-color);
            padding-bottom: 500px;
          }
          .bismillahImage {
            display: flex;
            justify-content: center;
            padding: 3px 0px;
          }
          .bismillahImage img {
            height: 40px;
          }
          .singleVerse {
            scroll-margin-top: 30px;
          }
          .verseInfo {
            background-color: var(--bg-color1);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 4px 0;
            gap: 4px;
          }
          .info {
            display: inline-block;
            font-size: 11px;
            border: 1.5px solid var(--active-color);
            padding: 2px 8px;
            padding-bottom: ${language == 'bn' ? '0px' : '2px'};
            border-radius: 80px;
            color: var(--active-color);
          }
          .info.active {
            background-color: var(--warnBg-color);
            color: var(--active-color);
            font-weight: 600;
          }
          .verseText {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 0 10px;
          }
          .arabic {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            direction: rtl;
            font-size: var(--arabic-font-size);
            font-family: var(--arabic-font-family);
            padding-top: 5px;
          }
          .pronunciation {
            display: none;
            font-size: var(--bangla-font-size);
            font-family: regularFont;
          }
          .enableBanglaTransliteration .pronunciation {
            display: block;
          }
          .taisirul, .ahbayan, .mujibur {
            display: none;
          }
          .enableBanglaTranslation[data-bn="meaningBnTaisirul"] .taisirul,
          .enableBanglaTranslation[data-bn="meaningBnAhbayan"] .ahbayan,
          .enableBanglaTranslation[data-bn="meaningBnMujibur"] .mujibur {
            display: block;
            font-size: var(--bangla-font-size);
            font-family: regularFont;
          }
          .english {
            display: none;
          }
          .enableEnglishTranslation .english {
            display: block;
            font-size: var(--english-font-size);
            font-family: regularFont;
          }
          .verseAction {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 15px;
            margin-bottom: 20px;
          }
          .icon {
            width: 18px;
            height: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--active-color);
            border: 1.5px solid var(--active-color);
            border-radius: 3px;
            transform-origin: center;
            transition: all 0.1s ease-in-out;
            padding: 10px;
          }
          .icon.book {
            font-size: 14px;
          }
          .activeWord {
            background-color: var(--active-word-color);
          }
          
          $tajweedStyle
          
          @media (max-width: 800px) {
            .arabic {
              justify-content: center;
            }
          }
                </style>
              </head>
              <body class="${alQuranInfoProvider.isEnableTajweed ? 'tajweed' : ''} ${appInfoProvider.isShowBanglaTranslation ? "enableBanglaTranslation" : ""} ${appInfoProvider.isShowBanglaTransliteration ? "enableBanglaTransliteration" : ""} ${appInfoProvider.isShowEnglishTranslation ? "enableEnglishTranslation" : ""}" data-bn="${alQuranInfoProvider.bnTranslator}">
                $fullSurahHtml
                <script>
document.addEventListener("DOMContentLoaded", function () {
  let verses = document.querySelectorAll('.singleVerse');
  let words = document.querySelectorAll(".word");

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

  const observer = new IntersectionObserver(
    function (entries) {
      const element = entries.filter((entry) => entry.isIntersecting)[0]?.target;
      if (element) {
        window.flutter_inappwebview.callHandler('currentVerseId', element.getAttribute('data-id'));
      }
    },
    { threshold: 0.2 }
  );

  verses.forEach((v) => {
    observer.observe(v);
  });
});

function toggleSaveOrDelete(verseId) {
  window.flutter_inappwebview.callHandler('saveOrDelete', verseId);
  var iconElement = document.querySelector('.saveOrDelete-'+verseId);
  const lastReadInfo = document.getElementsByClassName('lastRead') || undefined;
  
  if (lastReadInfo.length > 0) {
    [...lastReadInfo].forEach((element) => {
      element.style.display = 'none';
    })
  }

  if (iconElement.classList.contains('saved')) {
    iconElement.classList.remove('saved');
    iconElement.classList.remove('fa-trash');
    iconElement.classList.add('fa-floppy-disk');
  }else {
    const savedButton = document.getElementsByClassName('saved')[0] || undefined;
    if (savedButton) {
      savedButton.classList.remove('saved');
      savedButton.classList.remove('fa-trash');
      savedButton.classList.add('fa-floppy-disk');
    }

    iconElement.classList.add('saved');
    iconElement.classList.add('fa-trash');
    iconElement.classList.remove('fa-floppy-disk');

    const html = '<div class="lastRead info active">${language == 'bn' ? 'সর্বশেষ পঠিত' : 'Last Read'}</div>';
    document.querySelector('.verseId-'+verseId).innerHTML += html;
  }
}

function bookButtonClickHandler(verseId) {
  window.flutter_inappwebview.callHandler('book', verseId);
}

function copyToClipboard(copyButton, verseId) {
  window.flutter_inappwebview.callHandler('copy', verseId);

  var iconElement = document.querySelector('.copy-'+verseId);
  iconElement.classList.add('fa-solid');

  setTimeout(() => {
    let html = '<div class="copy icon"><i class="fa-regular fa-copy copy-';
    html += verseId + '"></i></div>';
    copyButton.innerHTML = html;
  }, 3000);
}

function toggleBookmark(verseId) {
  window.flutter_inappwebview.callHandler('bookmark', verseId);
  var iconElement = document.querySelector('.bookmark-'+verseId);
  
  if (iconElement.classList.contains('solid')) {
    iconElement.classList.remove('solid');
    iconElement.classList.add('fa-regular');

    const bookmarkInfo = document.querySelector('.verseId-'+verseId+' .bookmark');
    document.querySelector('.verseId-'+verseId).removeChild(bookmarkInfo);
  } else {
    iconElement.classList.add('solid');
    iconElement.classList.add('fa-solid');
    iconElement.classList.remove('fa-regular');

    const html = '<div class="bookmark info active">${language == 'bn' ? 'বুকমার্ক করা' : 'Bookmarked'}</div>';
    document.querySelector('.verseId-'+verseId).innerHTML += html;
  }
}

function iconButtonClickHandler(iconButton) {
  iconButton.style.transform = 'scale(0.9)';
  setTimeout(() => {
    iconButton.style.transform = 'scale(1)'
  }, 300);
}

function arabicTextSizeHandler(size) {
  document.documentElement.style.setProperty('--arabic-font-size', size + 'px');
}

function banglaTextSizeHandler(size) {
  document.documentElement.style.setProperty('--bangla-font-size', size + 'px');
}

function englishTextSizeHandler(size) {
  document.documentElement.style.setProperty('--english-font-size', size + 'px');
}

function toggleTajweed() {
  document.body.classList.toggle('tajweed');
}

function isShowBanglaTranslation() {
  document.body.classList.toggle('enableBanglaTranslation');
}

function isShowBanglaTransliteration() {
  document.body.classList.toggle('enableBanglaTransliteration');
}

function isShowEnglishTranslation() {
  document.body.classList.toggle('enableEnglishTranslation');
}

function arabicFontHandler(font) {
  document.documentElement.style.setProperty('--arabic-font-family', font);
}

function bnTranslatorHandler(translator) {
  document.body.setAttribute("data-bn", translator);
}

function setTextColor(color) {
  document.documentElement.style.setProperty('--text-color', color);
}

function setWarnBgColor(color) {
  document.documentElement.style.setProperty('--warnBg-color', color);
}

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

function scrollAyahToTop(v) {
  const verse = document.querySelector('.verse-' + v);
  verse.scrollIntoView({block: "start", behavior: "smooth"});
}

function highlightWord(s, v, w, isHighlightWord = true) {
  const activeWord = document.getElementsByClassName("activeWord");
  if (activeWord.length > 0) activeWord[0].classList.remove("activeWord");
  if (isHighlightWord) {
    const wordClass = s + "_" + v + "_" + w;
    const word = document.getElementsByClassName(wordClass);
    if (word.length > 0) {
      word[0].classList.add("activeWord");
    }
  }
}

function clearBody() {
  document.body.innerHTML = '';
}
                </script>
              </body>
            </html>
          """;
                  }

                  return Column(
                    children: [
                      SingleSurahInformation(
                        surahInfo: surahData.surahInfo,
                        isLoading: surahData.isLoading,
                        fullSurah: surahData.fullSurah,
                      ),
                      Expanded(
                        child: Container(
                          color: colors.bgColor2,
                          child: surahData.isLoading == true
                              ? const Center(
                                  child: Loader(),
                                )
                              : Container(
                                  color: colors.bgColor2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: InAppWebView(
                                          initialData: InAppWebViewInitialData(
                                              data: htmlContent),
                                          initialSettings: InAppWebViewSettings(
                                            transparentBackground: true,
                                            verticalScrollBarEnabled: false,
                                            horizontalScrollBarEnabled: false,
                                            supportZoom: false,
                                            builtInZoomControls: false,
                                            maximumZoomScale: 1.0,
                                            webViewAssetLoader:
                                                WebViewAssetLoader(
                                              domain:
                                                  "appassets.androidplatform.net",
                                              pathHandlers: [
                                                AssetsPathHandler(
                                                    path: '/assets/')
                                              ],
                                            ),
                                          ),
                                          onLoadStop: (controller, url) async {
                                            if (bookmarkedVerseId != null) {
                                              controller.evaluateJavascript(
                                                  source:
                                                      'scrollAyahToTop($bookmarkedVerseId);');
                                            } else if (alQuranInfoProvider
                                                        .history[
                                                    surahData.surahInfo!.id
                                                        .toString()] !=
                                                null) {
                                              int id = int.parse(
                                                  alQuranInfoProvider.history[
                                                      surahData.surahInfo!.id
                                                          .toString()]);
                                              controller.evaluateJavascript(
                                                  source:
                                                      'scrollAyahToTop($id);');
                                            }
                                            await controller
                                                .injectJavascriptFileFromAsset(
                                                    assetFilePath:
                                                        "assets/js/all.min.js");
                                          },
                                          onProgressChanged:
                                              (controller, progress) {
                                            surahData.setWbProgress(progress);
                                          },
                                          onWebViewCreated: (controller) {
                                            alQuranInfoProvider
                                                .setWbController(controller);
                                            appInfoProvider
                                                .setWbController(controller);

                                            controller.addJavaScriptHandler(
                                              handlerName: 'currentVerseId',
                                              callback: (args) {
                                                int id = int.parse(
                                                        args[0].toString()) -
                                                    1;
                                                singleSurahInfo
                                                    .setIndexOfAyahInView(id);
                                              },
                                            );

                                            controller.addJavaScriptHandler(
                                              handlerName: 'bookmark',
                                              callback: (args) {
                                                int id = int.parse(
                                                    args[0].toString());
                                                alQuranInfoProvider
                                                    .updateBookmarkedList(
                                                  surahId:
                                                      surahData.surahInfo!.id,
                                                  verseId: id,
                                                  language: language,
                                                  bgColor: colors.activeColor1,
                                                );
                                              },
                                            );

                                            controller.addJavaScriptHandler(
                                              handlerName: 'copy',
                                              callback: (args) {
                                                int id = int.parse(
                                                    args[0].toString());
                                                copyVerse(id);
                                              },
                                            );

                                            controller.addJavaScriptHandler(
                                              handlerName: 'book',
                                              callback: (args) {
                                                int id = int.parse(
                                                    args[0].toString());
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MultiProvider(
                                                      providers: [
                                                        ChangeNotifierProvider(
                                                          create: (context) =>
                                                              TafseerProvider(),
                                                        ),
                                                      ],
                                                      child: ShortTafseer(
                                                        verse: surahData
                                                            .fullSurah[id - 1],
                                                        surahNameBn: surahData
                                                            .surahInfo!.nameBn,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            controller.addJavaScriptHandler(
                                              handlerName: 'saveOrDelete',
                                              callback: (args) {
                                                String id = args[0].toString();
                                                alQuranInfoProvider
                                                    .updateHistoryAndLastReadSurah(
                                                  surahId: surahData
                                                      .surahInfo!.id
                                                      .toString(),
                                                  verseId: id,
                                                  language: language,
                                                  bgColor: colors.activeColor1,
                                                );
                                              },
                                            );

                                            controller.addJavaScriptHandler(
                                              handlerName: 'wordPosition',
                                              callback: (args) {
                                                if (alQuranInfoProvider
                                                    .isEnableWordMeaningAudio) {
                                                  wordInfoProvider
                                                      .readWordInfoFromDB(
                                                          args[0]);
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const WordInfoBox(),
              Selector<SingleSurahProvider, bool>(
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
                          surahId: surahData.surahInfo!.id,
                          versePositionStart:
                              surahData.fullSurah[0].versePosition,
                          totalAyah: surahData.surahInfo!.totalAyah,
                          versesPositions: surahData.fullSurah
                              .map((el) => el.versePosition)
                              .toList(),
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
