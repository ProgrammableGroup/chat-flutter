import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CommonFuncUtil {
  static String dateTimeToString(DateTime date) {
    initializeDateFormatting('ja_JP');
    final formatter = DateFormat('HH:mm', 'ja_JP');
    final formatted = formatter.format(date);
    return formatted;
  }
}
