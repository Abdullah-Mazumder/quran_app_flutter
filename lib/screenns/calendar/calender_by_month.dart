import 'package:al_quran/provider/calender/calender_info_provider.dart';
import 'package:al_quran/state_helper/get_theme.dart';
import 'package:al_quran/utils/get_days_of_month.dart';
import 'package:al_quran/utils/get_difference_of_two_times.dart';
import 'package:al_quran/widgets/calender/day_of_a_month.dart';
import 'package:al_quran/widgets/calender/month_and_year_hadler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalenderByMonth extends StatelessWidget {
  const CalenderByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = getTheme(context).colors;

    final calenderInfoProvider = Provider.of<CalenderInfoProvider>(context);

    List<DateTime> days =
        getDaysOfMonth(calenderInfoProvider.year, calenderInfoProvider.month);

    int currentDateIndex = days.indexWhere((date) {
      return areDatesEqual(date, DateTime.now());
    });

    if (currentDateIndex == -1) {
      currentDateIndex = 0;
    }

    return Container(
      color: colors.bgColor2,
      child: Column(
        children: [
          const MonthAndYearHadler(),
          const SizedBox(height: 5),
          Expanded(
            child: ScrollablePositionedList.builder(
              initialScrollIndex: currentDateIndex,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return DayOfAMonth(
                  date: days[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
