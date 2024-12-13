// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:async';

import 'package:al_quran/models/quran/quran_data_model.dart';
import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/provider/alQuran/tafseer_provider.dart';
import 'package:al_quran/provider/app/app_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/base64_fonts.dart';
import 'package:al_quran/utils/constants.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:al_quran/widgets/loader.dart';
import 'package:al_quran/widgets/quran/tajweed_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';

class ShortTafseer extends HookWidget {
  final VerseInfo verse;
  final String surahNameBn;

  ShortTafseer({
    super.key,
    required this.verse,
    required this.surahNameBn,
  });

  InAppWebViewController? wbController;

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final tafseerProvider = Provider.of<TafseerProvider>(context);

    final appInfoProvider = Provider.of<AppInfoProvider>(context);
    final alQuranInfoProvider = Provider.of<AlQuranInfoProvider>(context);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Timer(const Duration(milliseconds: 200), () {
          tafseerProvider.readTafseerFromDB(
              surahId: verse.surahId, verseId: verse.verseId);
        });
      });

      return null;
    }, [verse.surahId, verse.verseId]);

    String htmlContent = '';

    if (tafseerProvider.isLoading == false) {
      htmlContent = """
<!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <style>
        @font-face { font-family: "indopak"; src: url(data:font/truetype;charset=utf-8;base64,${base64Fonts[indopakFont]}) format("truetype"); }
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

        * {
          padding: 0px;
          margin: 0px;
          box-sizing: border-box;
        }

        body {
          color: ${colors.txtColor.toCssString()};
          padding: 0 10px;
          padding-bottom: 500px;
        }
        .verseText {
          display: flex;
          flex-direction: column;
          gap: 10px;
          padding: 0 10px;
        }
        .arabic {
          display: flex;
          direction: rtl;
          flex-wrap: wrap;
          align-items: center;
          font-size: var(--arabic-font-size);
          font-family: var(--arabic-font-family);
          padding-top: 5px;
          margin-bottom: 5px;
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
          margin-top: 5px;
        }
        .tag {
          color: ${colors.activeColor1.toCssString()};
          font-weight: 700;
          font-size: ${appInfoProvider.banglaTextSize + 2}px;
          margin: 8px 0;
          font-family: regularFont;
        }
        .tafseer {
          font-size: var(--bangla-font-size);
          font-family: regularFont;
        }

        $tajweedStyle

        @media (max-width: 800px) {
          .arabic {
            justify-content: center;
          }
        }
      </style>
    </head>
    <body class="${alQuranInfoProvider.isEnableTajweed ? 'tajweed' : ''} ${appInfoProvider.isShowBanglaTranslation ? "enableBanglaTranslation" : ""} ${appInfoProvider.isShowEnglishTranslation ? "enableEnglishTranslation" : ""}" data-bn="${alQuranInfoProvider.bnTranslator}">
    <div class="arabic">
      ${verse.verseHtml.replaceAll(RegExp(r'ٱ'), 'ا').replaceAll(RegExp(r'اْ'), 'ا')}
      </div>
      <div class="taisirul">${verse.meaningBnTaisirul}</div>
      <div class="ahbayan">${verse.meaningBnAhbayan}</div>
      <div class="mujibur">${verse.meaningBnMujibur}</div>
      <div class="english">${verse.meaningEn}</div>
      <div class="tag">তাফসীরঃ</div>
      <div class="tafseer">
        ${tafseerProvider.data != null ? tafseerProvider.data.data.replaceAll('\n', '<br/>') : 'এই আয়াতের তাফসীর পরবর্তিতে আলোচনা করা হয়েছে!'}
    </div>

    <script>
      function clearBody() {
        document.body.innerHTML = '';
      }
    </script>
  </body>
</html>
    """;
    }

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (wbController != null) {
              wbController!.evaluateJavascript(source: 'clearBody();');
            }
            return true;
          },
          child: Column(
            children: [
              Container(
                color: colors.bgColor1,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const CustomText(
                          text: 'সংক্ষিপ্ত ব্যাখ্যা',
                          additionalStyle: TextStyle(
                            fontSize: 17,
                            fontFamily: '',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomText(
                          text:
                              'সূরাঃ $surahNameBn, আয়াতঃ ${convertEnglishToBanglaNumber(verse.verseId)}',
                          additionalStyle: const TextStyle(
                            fontSize: 13.5,
                            fontFamily: '',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: colors.bgColor2,
                  child: tafseerProvider.isLoading
                      ? const Center(
                          child: Loader(),
                        )
                      : InAppWebView(
                          initialData:
                              InAppWebViewInitialData(data: htmlContent),
                          initialSettings: InAppWebViewSettings(
                            transparentBackground: true,
                            verticalScrollBarEnabled: false,
                            supportZoom: false,
                            maximumZoomScale: 1.0,
                          ),
                          onWebViewCreated: (controller) =>
                              wbController = controller,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
