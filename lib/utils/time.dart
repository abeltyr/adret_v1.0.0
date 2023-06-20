import 'package:intl/intl.dart';

class FetchTime {}

// ignore: non_constant_identifier_names
String FormatTimeOfDay(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);

  final format = DateFormat.jm();

  final now = DateTime.now();
  final dt =
      DateTime(now.year, now.month, now.day, parseDate.hour, parseDate.minute);

  return format.format(dt);
}
