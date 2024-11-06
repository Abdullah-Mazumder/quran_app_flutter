import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/custom_appbar.dart';
import 'package:al_quran/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TajweedRule extends StatelessWidget {
  const TajweedRule({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              icon: FontAwesomeIcons.palette,
              title: language == 'bn' ? 'তাজবীদের নিয়ম' : 'Tajweed Rule',
            ),
            Expanded(
              child: Container(
                color: colors.bgColor2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(0, 145, 234, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ইখফা',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'ইখফা অর্থ অস্পষ্ট করে পরা। এর অক্ষর ১৫টি ت,ث,ج, د,ذ,ز,س,ش,ص,ض,ط,ظ,ف,ق,ك, । নুন সাকিন বা তানভিন (ــٌ،ــٍ،ــً) এর পর ইখফার যেকোনো অক্ষর আসলে নুন সাকিন নুন তানভিনকে ১আলিফ গুন্নাহ করে অস্পষ্ট করে টেনে পড়তে হয়।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(251, 140, 0, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'গুন্নাহ',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'কুরআনে গুনাহ হল নাকের মাধ্যমে আওয়াজ তৈরির নিয়ম, যা সাধারণত "নুন সাকিন" (نْ) বা "মীম সাকিন" (مْ) এ পাওয়া যায়।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(255, 167, 182, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ইখফায়ে মীম সাকিন',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'মীম সাকিনের বামে যদি ﺏ অক্ষর থাকে, তাহলে মীম সাকিন গুন্নাহ করে পড়তে হয়।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(65, 156, 69, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ঈদগাম',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'ইদগাম অর্থ মিলাইয়া পড়া। ইদগামের হরফ ৬টি। যথা:- ي – ر – م – ل – و – ن নুন সাকিন বা তানভীনের পরে ইদগামের ৬টি হরফ হইতে কোন একটি হরফ আসিলে উক্ত নুন সাকিন বা তানভীনকে পরের হরফ সাথে মিলাইয়া পড়িতে হয়।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(244, 67, 54, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ক্বলক্বলা',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'ক্বলক্বলা হল বাক্যের মধ্যে ب, ج, د, ط, ق এই পাঁচটি হরফের উপর সাকিন থাকলে বা উচ্চারণে থেমে গেলে প্রতিধ্বনিসহ শব্দটি উচ্চারণ করা। উদাহরণ: اَقْرَبْ এবং يَجْعَلْ।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(177, 0, 177, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ক্বলব',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'ক্বলব হল "নুন সাকিন" (نْ) বা তানবিনের (ــٌ،ــٍ،ــً) পর বা (ب) হরফ আসলে নুনের আওয়াজকে মীমে রূপান্তরিত করে নাকের মাধ্যমে পড়া; উদাহরণ: مِنْ بَعْدِهِمْ এবং سميعٌ بَصيرٌ।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromRGBO(190, 206, 117, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, top: 3, bottom: 1),
                          child: CustomText(
                            text: 'ঈদগাম মীম সাকিন',
                            additionalStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: colors.bgColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                'মীম সাকিন (مْ) এর পর আরেকটি (مْ) অক্ষর আসলে দুটি (م) কে একসাথে মিলিয়ে গুন্নাহ সহকারে পড়তে হয়।',
                            additionalStyle:
                                TextStyle(fontSize: 14, fontFamily: ''),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
