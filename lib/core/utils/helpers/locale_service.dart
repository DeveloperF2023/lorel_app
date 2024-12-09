import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? '** $key not found';
  }

  bool isArabicSelected(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale newLocale;

  AppLocalizationsDelegate(this.newLocale);

  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localizations = AppLocalization(newLocale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
