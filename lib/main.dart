import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/main_app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final prefs = await SharedPreferences.getInstance();
      runApp(
        ProviderScope(
          overrides: [
            sharedPrefsP.overrideWithValue(prefs),
          ],
          child: const MainApp(),
        ),
      );
    },
    (error, stack) {
      log(
        'exception got caught inside ${Zone.current} zone',
        error: error,
        stackTrace: stack,
      );
    },
  );
}
