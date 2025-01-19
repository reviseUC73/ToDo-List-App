import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('should return "Today" for the current date', () {
      final now = DateTime.now();
      final result = DateFormatter.getReadableDate(now);

      expect(result, 'Today');
    });

    test('should return "Tomorrow" for the next date', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final result = DateFormatter.getReadableDate(tomorrow);

      expect(result, 'Tomorrow');
    });

    test('should return formatted date for future dates', () {
      final futureDate = DateTime.now().add(const Duration(days: 5));
      final result = DateFormatter.getReadableDate(futureDate);

      final expected = '${futureDate.day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(futureDate)} ${futureDate.year}';
      expect(result, expected);
    });

    test('should return formatted date for past dates', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 2));
      final result = DateFormatter.getReadableDate(pastDate);

      final expected = '${pastDate.day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(pastDate)} ${pastDate.year}';
      expect(result, expected);
    });
  });
}