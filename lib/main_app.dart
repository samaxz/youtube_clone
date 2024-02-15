import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volume_control/volume_control.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/screens/nav_screen.dart';
import 'package:youtube_clone/ui/screens/splash_screen.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  ThemeData setupThemeData(bool isDarkTheme) {
    return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
    );
  }

  Future<void> init() async {
    await Future.wait([
      ref.read(themeNP.notifier).setInitialTheme(),
      ref.read(sembastP).init(),
      ref.read(authNotifierProvider.notifier).checkAndUpdateAuthStatus(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    // this is used for debugging purposes on emulator
    // TODO comment this out before creating apk or pushing
    VolumeControl.setVolume(0.7);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    Future.delayed(const Duration(milliseconds: 600), init);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDarkTheme = ref.watch(themeNP);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube clone',
      theme: setupThemeData(isDarkTheme),
      home: authState.maybeWhen(
        orElse: () => const NavScreen(),
        initial: () => const SplashScreen(),
      ),
    );
  }
}
