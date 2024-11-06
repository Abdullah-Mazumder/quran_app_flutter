import 'package:al_quran/provider/alQuran/al_quran_info_provider.dart';
import 'package:al_quran/state_helper/get_language.dart';
import 'package:al_quran/widgets/quran/tajweed_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TajweedTags extends StatelessWidget {
  const TajweedTags({super.key});

  @override
  Widget build(BuildContext context) {
    final language = getLanguage(context);

    return Selector<AlQuranInfoProvider, bool>(
      builder: (_, value, __) {
        return !value
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          runSpacing: 5,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            TajweedTag(
                              label: language == 'bn' ? 'ইখফা' : 'Ikhfa',
                              color: const Color.fromRGBO(0, 145, 234, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn' ? 'গুন্নাহ' : 'Gunnah',
                              color: const Color.fromRGBO(251, 140, 0, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn'
                                  ? 'ইখফায়ে মীম সাকিন'
                                  : 'Ikhfa Mim Sakin',
                              color: const Color.fromRGBO(255, 167, 182, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn' ? 'ঈদগাম' : 'Idhgam',
                              color: const Color.fromRGBO(65, 156, 69, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn' ? 'ক্বলক্বলা' : 'Qalqala',
                              color: const Color.fromRGBO(244, 67, 54, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn' ? 'ক্বলব' : 'Qalb',
                              color: const Color.fromRGBO(177, 0, 177, 1),
                            ),
                            TajweedTag(
                              label: language == 'bn'
                                  ? 'ঈদগাম মীম সাকিন'
                                  : 'Idhgam Mim Sakin',
                              color: const Color.fromRGBO(190, 206, 117, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              );
      },
      selector: (_, provider) => provider.isEnableTajweedTags,
    );
  }
}
