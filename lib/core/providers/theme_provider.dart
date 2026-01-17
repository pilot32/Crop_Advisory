import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeMode$ extends _$ThemeMode$ {
  @override
  ThemeMode build() {
    return ThemeMode.light; // default opens in light mode
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      await prefs.setString('theme', 'light');
    } else {
      state = ThemeMode.dark;
      await prefs.setString('theme', 'dark');
    }
  }
}
