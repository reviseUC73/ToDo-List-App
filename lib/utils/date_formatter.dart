import 'package:intl/intl.dart';

class DateFormatter {
  static String getReadableDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    final difference = targetDate.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';

    return DateFormat('dd MMM yyyy').format(date);
  }
}
