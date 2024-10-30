import 'package:al_quran/widgets/quran/tajweed_tag.dart';
import 'package:flutter/material.dart';

class TajweedTags extends StatelessWidget {
  const TajweedTags({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
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
                label: 'ইখফা',
                color: Color.fromRGBO(0, 145, 234, 1),
              ),
              TajweedTag(
                label: 'গুন্নাহ',
                color: Color.fromRGBO(251, 140, 0, 1),
              ),
              TajweedTag(
                label: 'ইখফায়ে মীম সাকিন',
                color: Color.fromRGBO(255, 167, 182, 1),
              ),
              TajweedTag(
                label: 'ঈদগাম',
                color: Color.fromRGBO(65, 156, 69, 1),
              ),
              TajweedTag(
                label: 'ক্বলক্বলা',
                color: Color.fromRGBO(244, 67, 54, 1),
              ),
              TajweedTag(
                label: 'ক্বলব',
                color: Color.fromRGBO(177, 0, 177, 1),
              ),
              TajweedTag(
                label: 'ঈদগাম মীম সাকিন',
                color: Color.fromRGBO(190, 206, 117, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
