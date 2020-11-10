import 'package:intl/intl.dart';

String getDateTime(String rawDateTime) {
  DateTime date = DateTime.parse(rawDateTime);
  var fommater = DateFormat("hh:mm dd-MM-yyyy");
  final date_str = fommater.format(date);
  return date_str.toString();
}
