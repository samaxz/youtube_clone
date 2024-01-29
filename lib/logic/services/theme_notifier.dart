import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

class ThemeNotifier extends StateNotifier<bool> {
  final SharedPreferences prefs;

  ThemeNotifier(this.prefs) : super(true) {
    final theme = prefs.getBool(_isDark);
    if (theme != null) {
      state = theme;
    }
  }

  // TODO delete this
  // bool _isDarkTheme = true;
  // bool get isDarkTheme => _isDarkTheme;

  final String _isDark = 'is_dark';

  // TODO delete this
  // Future<void> getCurrentTheme() async {
  //   // prefs = await SharedPreferences.getInstance();
  //   if (prefs.getBool(_isDark) == null) {
  //     await setCurrentTheme(true);
  //   } else {
  //     _isDarkTheme = prefs.getBool(_isDark)!;
  //     if (_isDarkTheme) {
  //       state = true;
  //     } else {
  //       state = false;
  //     }
  //   }
  // }

  Future<void> setInitialTheme() async {
    if (prefs.getBool(_isDark) == null) {
      // by default, the value will be set to true from state
      await prefs.setBool(_isDark, state);
    }
  }

  // TODO delete this
  // Future<void> setCurrentTheme(bool setToDark) async {
  //   // prefs = await SharedPreferences.getInstance();
  //   // _isDarkTheme = await prefs.setBool(_isDark, setToDark);
  //   // if (_isDarkTheme) {
  //   //   state = true;
  //   // } else {
  //   //   state = false;
  //   // }
  // }

  Future<void> toggleTheme({bool? value}) async {
    // if (value != null) {
    //   state = value;
    //   await prefs.setBool(_isDark, value);
    // } else {
    //   state = !state;
    //   await prefs.setBool(_isDark, state);
    // }
    state = !state;
    await prefs.setBool(_isDark, state);

    // if (state == true) {
    //   _isDarkTheme = await prefs.setBool(_isDark, false);
    //   state = false;
    // } else {
    //   _isDarkTheme = await prefs.setBool(_isDark, true);
    //   state = true;
    // }
  }
}

final themeNP = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(
    ref.read(sharedPrefsP),
  ),
);
