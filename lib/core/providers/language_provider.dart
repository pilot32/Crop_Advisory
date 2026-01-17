import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'language_provider.g.dart';

const String _localeKey = 'app_locale';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  SharedPreferences? _prefs;

  @override
  Locale build() {
    _loadSavedLocale();
    return const Locale('en');
  }

  Future<void> _loadSavedLocale() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLocale = _prefs?.getString(_localeKey);

    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;

    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString(_localeKey, locale.languageCode);
  }
}
