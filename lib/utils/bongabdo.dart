// ignore_for_file: prefer_typing_uninitialized_variables

final totalDaysInMonthOld = [31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30, 30];
final totalDaysInMonthNew = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30];

bool isLeapYear(int year) =>
    ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);

class Bongabdo {
  var hDay;
  var hMonth;
  var hYear;
  var hSeason;
  var version;

  Bongabdo.addMonth(int year, int month) {
    hYear = month % 12 == 0 ? year - 1 : year;
    hMonth = month % 12 == 0 ? 12 : month % 12;
    hDay = 1;
  }

  Bongabdo.fromDate(DateTime date, [this.version]) {
    toBanglaDate(date.year, date.month, date.day);
  }

  Bongabdo.now([this.version]) {
    var today = DateTime.now();
    toBanglaDate(today.year, today.month, today.day);
  }

  bDate(year, month, day, season) {
    this.hYear = year;
    this.hMonth = month;
    this.hDay = day;
    this.hSeason = season;
  }

  List<int> toList() => [hYear, hMonth, hDay];

  String fullDate() => "$hDay, $hMonth, $hYear বঙ্গাব্দ, $hSeason কাল";

  bool isnew() => this.version == "new";

  toBanglaDate(gYear, gMonth, gDay) {
    var totalDaysInMonth = isnew() ? totalDaysInMonthNew : totalDaysInMonthOld;

    isLeapYear(gYear) && isnew()
        ? totalDaysInMonth[10] = 29
        : totalDaysInMonth[10] = 31;

    /* if (isLeapYear(gYear)){
      totalDaysInMonth[10] = 31;
    } */

    int banglaYear =
        (gMonth < 4 || (gMonth == 4 && gDay < 14)) ? gYear - 594 : gYear - 593;

    int epochYear =
        (gMonth < 4 || (gMonth == 4 && gDay < 14)) ? gYear - 1 : gYear;

    var difference = (DateTime.utc(gYear, gMonth, gDay)
            .difference(DateTime.utc(epochYear, 04, 13)))
        .inDays
        .floor();

    var banglaMonthIndex = 0;

    for (var i = 0; i < 12; i++) {
      if (difference <= totalDaysInMonth[i]) {
        banglaMonthIndex = i;
        break;
      }
      difference -= totalDaysInMonth[i];
    }

    var banglaDate = difference;

    return bDate(banglaYear.toString(), banglaMonthIndex + 1,
        banglaDate.toString(), (banglaMonthIndex / 2).floor() + 1);
  }
}
