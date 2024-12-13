String getDifferenceOfTwoTimes(DateTime start, DateTime end) {
  Duration difference =
      DateTime(end.year, end.month, end.day, end.hour, end.minute, end.second)
          .difference(DateTime(start.year, start.month, start.day, start.hour,
              start.minute, start.second));

  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;

  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  // Return the formatted difference as a string
  return '$formattedHours:$formattedMinutes:$formattedSeconds';
}

bool isCurrentTimeBetween(DateTime startTime, DateTime endTime) {
  DateTime start = DateTime(startTime.year, startTime.month, startTime.day,
      startTime.hour, startTime.minute, startTime.second);
  DateTime end = DateTime(endTime.year, endTime.month, endTime.day,
      endTime.hour, endTime.minute, endTime.second);

  DateTime currentTime = DateTime.now();

  return currentTime.isAfter(start) && currentTime.isBefore(end);
}

int getDifferenceInSeconds(DateTime start, DateTime end) {
  Duration difference =
      DateTime(end.year, end.month, end.day, end.hour, end.minute, end.second)
          .difference(DateTime(start.year, start.month, start.day, start.hour,
              start.minute, start.second));

  return difference.inSeconds;
}

bool areDatesEqual(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
