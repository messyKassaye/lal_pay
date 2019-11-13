import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lal_pay/localication/app_localizations.dart';
import 'package:lal_pay/localication/application.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }

  String getCurrentLangauge(){
    return newLocale.languageCode;
  }
}