import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/convert_en_to_bn_number.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SinglePrayerTime extends StatelessWidget {
  final String prayerName;
  final String time;
  final bool isAsrPrayer;
  final bool isActive;

  const SinglePrayerTime({
    super.key,
    required this.prayerName,
    required this.time,
    this.isAsrPrayer = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isActive ? colors.activeColor1.withOpacity(0.4) : null,
        border: Border(
          bottom: BorderSide(color: colors.activeColor1.withOpacity(0.2)),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: prayerName),
              const SizedBox(width: 2),
              isAsrPrayer
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: colors.bgColor1,
                          context: context,
                          builder: (context) {
                            return _bottomSheetContent();
                          },
                        );
                      },
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red[900],
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          CustomText(
            text: language == 'en' ? time : convertEnglishToBanglaNumber(time),
            additionalStyle: const TextStyle(fontFamily: ''),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: 'নিষিদ্ধ সময়ে আসরের সালাত প্রসঙ্গে',
              additionalStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            CustomText(
              text:
                  'সূর্য অস্ত যাওয়া শুরুর সময় থেকে সূর্য পুরোপুরি ভাবে অস্তমিত হওয়া পর্যন্ত নামাজ পড়া নিষেধ। কিন্তু কোনো কারণবশতঃ ঐ দিনের আসরের সালাত পড়া না হয়ে থাকলে, সূর্যাস্তের নিষিদ্ধ সময়ের মধ্যে শুধুমাত্র ঐ দিনের আসরের সালাতটাই পড়া যাবে।',
            ),
            SizedBox(height: 10),
            CustomText(
              text:
                  'তাই সূর্যাস্তের নিষিদ্ধ সময়কে আসরের সালাতের ওয়াক্ত হিসাবেও দেখানো হয়েছে।',
            ),
          ],
        ),
      ),
    );
  }
}
