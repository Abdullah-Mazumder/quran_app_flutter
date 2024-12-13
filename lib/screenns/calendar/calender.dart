import 'package:al_quran/screenns/calendar/calender_by_month.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/widgets/calender/calender_top.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CalenderTop(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                color: colors.bgColor2,
                child: const CalenderByMonth(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
