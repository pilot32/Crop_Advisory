import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const _themeKey = 'theme_mode';

@riverpod
class ThemeMode$ extends _$ThemeMode$ {
  SharedPreferences? _prefs;

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.light;
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs!.getString(_themeKey);

    if (saved != null) {
      state = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_themeKey, mode.name);
  }

  void toggle() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(newMode);
  }
}
