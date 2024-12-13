List<DateTime> getDaysOfMonth(int year, int month) {
  // Get the first day of the month
  DateTime firstDayOfMonth = DateTime(year, month, 1);

  // Get the last day of the month
  DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

  // Create a list to store all the days
  List<DateTime> days = [];

  // Loop from the first day to the last day
  for (int i = 0; i <= lastDayOfMonth.day - 1; i++) {
    days.add(firstDayOfMonth.add(Duration(days: i)));
  }

  return days;
}
