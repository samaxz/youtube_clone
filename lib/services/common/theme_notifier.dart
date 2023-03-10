import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true);

  bool _isDarkTheme = true;
  bool get isDarkTheme => _isDarkTheme;

  final String _isDark = 'is_dark';

  late SharedPreferences prefs;

  Future<void> getCurrentTheme() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_isDark) == null) {
      await setCurrentTheme(true);
    } else {
      _isDarkTheme = prefs.getBool(_isDark)!;
      if (_isDarkTheme) {
        state = true;
      } else {
        state = false;
      }
    }
  }

  Future<void> setCurrentTheme(bool setToDark) async {
    prefs = await SharedPreferences.getInstance();
    _isDarkTheme = await prefs.setBool(_isDark, setToDark);
    if (_isDarkTheme) {
      state = true;
    } else {
      state = false;
    }
  }

  Future<void> toggleThemes() async {
    if (state == true) {
      _isDarkTheme = await prefs.setBool(_isDark, false);
      state = false;
    } else {
      _isDarkTheme = await prefs.setBool(_isDark, true);
      state = true;
    }
  }
}

final themeNP = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);
