import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  /// Parses a date string based on the current locale.
  static DateTime parseDate(String dateString, Locale locale) {
    try {
      String localeCode = locale.languageCode;
      // Define the date format based on the locale
      DateFormat dateFormat;

      switch (localeCode) {
        case 'fr':
          dateFormat = DateFormat('d MMMM y', 'fr');
          break;
        case 'ar':
          dateFormat = DateFormat('d MMMM y', 'ar');
          break;
        case 'en':
        default:
          dateFormat = DateFormat('d MMMM y', 'en');
      }

      // Parse the date string
      return dateFormat.parse(dateString);
    } catch (e) {
      print("Error parsing date: $e");
      // Handle the error as needed, e.g., return current date or throw
      return DateTime.now();
    }
  }

  /// Formats a DateTime object based on the current locale.
  static String formatDate(DateTime date, String pattern, Locale locale) {
    try {
      String localeCode = locale.languageCode;
      DateFormat dateFormat = DateFormat(pattern, localeCode);
      return dateFormat.format(date);
    } catch (e) {
      print("Error formatting date: $e");
      // Handle the error as needed
      return date.toString();
    }
  }
}
