import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_prayer_times.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/format_time.dart';
import 'package:al_quran/widgets/calender/single_prayer_time.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProhibitedPrayerTimes extends StatelessWidget {
  const ProhibitedPrayerTimes({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;
    final language = getLanguage(context);

    PrayerTimesObject prayerTimes = getPrayerTimes(context: context);

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: colors.bgColor1,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  text: language == 'en'
                      ? 'Prohibited prayer times'
                      : 'নামাজের নিষিদ্ধ সময়'),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: colors.bgColor1,
                    context: context,
                    builder: (context) {
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
                                text: 'সালাতের নিষিদ্ধ সময় সম্পর্কে জ্ঞাতব্য',
                                additionalStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    'ইসলামী শরীয়তে ৩ টি সময়ে সালাত আদায় নিষিদ্ধ। আসর ও সূর্যাস্তের ব্যক্তিগত সহ নিষিদ্ধ সময় নির্ধারণের পদ্ধতি ও মাসআলা নিয়ে উল্লেখ করা হলো:\n\n(১) সূর্যোদয়ের সময়:\n----------------------------\nসূর্য উঠা শুরু করার সময় থেকে পুরোপুরি ভাবে উদয় হওয়ার শেষ হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে।\n\n(২) দ্বিপ্রহর বা মধ্যাহ্নের সময়:\n--------------------------------\nএই সময়টি যুহরের ওয়াক্ত শুরু হওয়ার আগের ৩ মিনিট। কিন্তু বাড়তি সতর্কতার জন্য ইসলামী ফাউন্ডেশন থেকে যুহরের ওয়াক্ত শুরুর আগের ৫ মিনিট নিষিদ্ধ সময় হিসেবে দেখাতে বলা হয়েছে।\n\n(৩) সূর্যাস্তের সময়:\n-----------------------\nসূর্য অস্ত যাওয়া শুরু সময় থেকে সূর্য পুরোপুরি ভাবে অস্তমিত হওয়া পর্যন্ত। অ্যাপে এই নিষিদ্ধ সময়ের ব্যাপ্তিকাল ১৫ মিনিট দেখানো হয়েছে।\nকোনো কারণবশতঃ ঐ দিনের আসরের সালাত পড়া না হয়ে থাকলে, সূর্যাস্তের নিষিদ্ধ সময়ের মধ্যে শুধুমাত্র ঐ দিনের আসরের সালাতটাই পড়া যাবে। তাই সূর্যাস্তের নিষিদ্ধ সময়কেও আসরের সালাতের ওয়াক্ত হিসেবে দেখানো হয়েছে। কিন্তু সালাত একরকম দেরি করে পড়া মোটেই উত্তম নয়।\n\nপ্রসঙ্গত উল্লেখ: বিভিন্ন সময়ে সূর্যোদয় ও সূর্যাস্তের নিষিদ্ধ সময় ২৩ মিনিট ধরে হত। কিন্তু বর্তমান কালের আধুনিক ও বৈজ্ঞানিক গবেষণার পর আলেমগণ ফতোয়া দিয়েছেন: এই সময়গুলো কোনোভাবেই ১৫ মিনিটের বেশি নয়। তাই অ্যাপে নিষিদ্ধ সময় ২৩ মিনিটের পরিবর্তে ১৫ মিনিট দেখানো হয়েছে।',
                                additionalStyle: TextStyle(fontFamily: ''),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.error_outline,
                  color: colors.activeColor1,
                  size: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              SinglePrayerTime(
                  prayerName: language == 'en' ? 'Morning' : 'সকাল',
                  time:
                      '${formatPrayerTime(prayerTimes.sunrise)} - ${formatPrayerTime(prayerTimes.prohibitedTime1End)}'),
              const SizedBox(height: 10),
              SinglePrayerTime(
                  prayerName: language == 'en' ? 'Afternoon' : 'দুপুর',
                  time:
                      '${formatPrayerTime(prayerTimes.prohibitedTime2Start)} - ${formatPrayerTime(prayerTimes.prohibitedTime2End)}'),
              const SizedBox(height: 10),
              SinglePrayerTime(
                  prayerName: language == 'en' ? 'Evening' : 'সন্ধ্যা',
                  time:
                      '${formatPrayerTime(prayerTimes.prohibitedTime3Start)} - ${formatPrayerTime(prayerTimes.asrEnd)}'),
            ],
          ),
        ],
      ),
    );
  }
}
