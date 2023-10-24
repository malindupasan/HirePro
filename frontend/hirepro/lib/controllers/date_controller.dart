import 'package:intl/intl.dart';

class DateController {
  String formatDate(String inputDate) {
    // Parse the input date string
    DateTime date = DateTime.parse(inputDate);

    // Format the date as "22 Oct 2023"
    String formattedDate = DateFormat('d MMM y').format(date);

    // Add the day suffix
    formattedDate = formattedDate
        .replaceAllMapped(RegExp(r'(\d+)(st|nd|rd|th)'), (Match m) {
      return m.group(1)! + addDaySuffix(int.parse(m.group(1)!));
    });

    return formattedDate;
  }

  String addDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
