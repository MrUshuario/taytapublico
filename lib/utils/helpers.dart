import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';


class Helpers {
  static Future<String> readData(String? path) async {
    return await rootBundle.loadString(path!);
  }

  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

  static String removeAccents(String input) {
    final regex = RegExp(r'[áéíóúüÁÉÍÓÚÜ]');

    Map<String, String> accentMap = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'ü': 'u',
      'Á': 'A',
      'É': 'E',
      'Í': 'I',
      'Ó': 'O',
      'Ú': 'U',
      'Ü': 'U',
    };

    return input.replaceAllMapped(regex, (match) => accentMap[match.group(0)]!);
  }
}
