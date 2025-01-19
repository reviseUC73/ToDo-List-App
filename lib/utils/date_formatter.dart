import 'package:intl/intl.dart';

class DateFormatter {
  static String getReadableDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';

    return DateFormat('dd MMM yyyy').format(date);
  }
}
