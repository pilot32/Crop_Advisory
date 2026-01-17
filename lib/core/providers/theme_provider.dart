/// Theme Provider
/// 
/// Manages app theme mode (light/dark) with persistence

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const String _themeModeKey = 'theme_mode';

/// Theme mode state provider
@riverpod
class ThemeMode$ extends _$ThemeMode$ {
  SharedPreferences? _prefs;

  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.system; // Default
  }

  /// Load theme mode from storage
  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final savedMode = _prefs?.getString(_themeModeKey);
    
    if (savedMode != null) {
      state = ThemeMode.values.firstWhere(
        (mode) => mode.name == savedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }

  /// Set theme mode and persist
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString(_themeModeKey, mode.name);
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  /// Check if dark mode is active
  bool get isDarkMode => state == ThemeMode.dark;
}
