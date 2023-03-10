import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volume_control/volume_control.dart';
import 'package:youtube_demo/screens/splash_screen.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Future<void> init() async {
    await ref.read(themeNP.notifier).getCurrentTheme();
    await ref.read(sembastP).init();
  }

  @override
  void initState() {
    super.initState();
    VolumeControl.setVolume(0.7);
    Future.microtask(init);
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = ref.watch(themeNP);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube Demo',
      theme: setupThemeData(darkTheme),
      home: const SplashScreen(),
    );
  }

  ThemeData setupThemeData(bool darkTheme) {
    return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkTheme ? Colors.white : Colors.black,
      ),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: darkTheme ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
