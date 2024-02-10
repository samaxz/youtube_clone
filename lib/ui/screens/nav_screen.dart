// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/common_classes.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/screens/home_screen.dart';
import 'package:youtube_clone/ui/screens/library_screen.dart';
import 'package:youtube_clone/ui/screens/shorts_screen.dart';
import 'package:youtube_clone/ui/screens/subs_screen.dart';
import 'package:youtube_clone/ui/widgets/custom_miniplayer.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';

class NavScreen extends ConsumerStatefulWidget {
  const NavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavScreenState();
}

class _NavScreenState extends ConsumerState<NavScreen> {
  static const double playerMinHeight = 60;
  late double playerMaxHeight;
  final pageController = PageController();

  // these are screens for the bottom nav bar
  final screens = [
    const HomeScreen(),
    const ShortsScreen(),
    const SizedBox(),
    const SubsScreen(),
    const LibraryScreen(),
  ];

  final screenKeyList = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(ref.read(connectivitySNP.notifier).initState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerMaxHeight = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    if (!mounted) {
      ref.read(connectivitySNP.notifier).dispose();
      pageController.dispose();
    }
    super.dispose();
  }

  bool shouldShowSnack = false;
  bool offline = false;

  @override
  Widget build(BuildContext context) {
    final selectedVideo = ref.watch(selectedVideoSP);
    final homeScrollController = ref.watch(homeScrollControllerP);
    final subsScrollController = ref.watch(subsScrollControllerP);
    final libScrollController = ref.watch(libScrollControllerP);
    final screenIndex = ref.watch(currentScreenIndexSP);
    final isShowingSearch = ref.watch(isShowingSearchSP(screenIndex));
    final screensManager = ref.watch(screensManagerProvider(screenIndex));
    final isShortsScreen =
        screensManager.lastOrNull?.screenTypeAndId.screenType == ScreenType.short;
    final isDarkTheme = ref.watch(themeNP);

    // this shows different pop-ups, depending on the chosen item:
    // video, channel, short...
    // it's shown on top of the MP
    ref.listen(
      showOptionsSP,
      (_, state) {
        state.maybeWhen(
          // this is Neither()
          orElse: () {},
          video: (videoAction) {
            Helper.showVideoActions(
              context: context,
              ref: ref,
              videoAction: videoAction,
            );
          },
        );

        ref.read(showOptionsSP.notifier).update((state) => const Neither());
      },
    );

    // when the user is not authenticated, this shows the authentication
    // pop-up for him to sign in to perform authenticated actions
    ref.listen(unauthAttemptSP, (_, state) {
      if (state) {
        Helper.handleAuthButtonPressed(context: context, ref: ref);
      }

      // this cancels it right away to allow continuous auth
      // actions to be performed - over and over again
      ref.read(unauthAttemptSP.notifier).update((state) => false);
    });

    // this listens to the current inet connection and displays
    // bottom sheet if there's none, then hides it
    ref.listen(
      connectivitySNP,
      (_, state) {
        state.when(
          offline: () {
            offline = true;

            Helper.scaffoldKey.currentState!.showBottomSheet(
              (context) => ValueListenableBuilder(
                valueListenable: playerExpandProgressVN,
                builder: (context, height, child) => SizedBox(
                  height: height,
                  child: child,
                ),
                child: Container(
                  // height: 30,
                  width: double.infinity,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text('No internet'),
                ),
              ),
            );
          },
          online: () {
            if (!offline) return;
            offline = false;

            Helper.scaffoldKey.currentState?.showBottomSheet(
              (context) => Container(
                height: 30,
                width: double.infinity,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text('Internet is back up'),
              ),
            );

            Future.delayed(
              const Duration(seconds: 3),
              () => Navigator.of(context).pop(),
            );
          },
        );
      },
    );

    return MiniplayerWillPopScope(
      onWillPop: () async {
        final navigator = screenKeyList[screenIndex].currentState!;

        if (!navigator.canPop()) return true;
        navigator.pop();

        return false;
      },
      child: Scaffold(
        // without this, the body can't be displayed behind the system bar
        // for shorts' body screen
        extendBodyBehindAppBar: true,
        // without this, the status bar with light theme is blank
        appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarHeight: 0,
        ),
        drawerEnableOpenDragGesture: false,
        key: Helper.scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListTile(
                  leading: isDarkTheme
                      ? Image.asset(
                          Helper.youtubeLogoDarkMode,
                          height: 20,
                        )
                      : Image.asset(
                          Helper.youtubeLogo,
                          height: 20,
                        ),
                ),
              ),
              ListTile(
                leading: Icon(MdiIcons.fire),
                title: const Text('Trending'),
                minLeadingWidth: 20,
                horizontalTitleGap: 10,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(MdiIcons.music),
                title: const Text('Music'),
                minLeadingWidth: 20,
                horizontalTitleGap: 10,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(MdiIcons.broadcast),
                title: const Text('Live'),
                minLeadingWidth: 20,
                horizontalTitleGap: 10,
                onTap: () {},
              ),
              ListTile(
                leading: Icon(MdiIcons.gamepad),
                title: const Text('Gaming'),
                minLeadingWidth: 20,
                horizontalTitleGap: 10,
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SafeArea(
          // this is used to make the shorts body visible behind system bar
          top: !isShortsScreen,
          // bottom: false,
          child: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: screens
                    .mapIndexed(
                      (index, screen) => Navigator(
                        key: screenKeyList[index],
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          settings: settings,
                          builder: (context) => screen,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Offstage(
                // if the video is not selected, then the mini player
                // will be hidden
                offstage: selectedVideo == null || isShowingSearch || isShortsScreen,
                child: CustomMiniplayer(video: selectedVideo),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: playerExpandProgressVN,
          builder: (context, height, child) {
            final value = Helper.percentageFromValueInRange(
              min: playerMinHeight,
              max: playerMaxHeight,
              value: height,
            );
            double opacity = 1 - value;

            if (opacity < 0) opacity = 0;
            if (opacity > 1) opacity = 1;

            return SizedBox(
              height:
                  value <= 1 ? kBottomNavigationBarHeight - kBottomNavigationBarHeight * value : 0,
              child: Transform.translate(
                offset: Offset(0, kBottomNavigationBarHeight * value * 0.5),
                child: Opacity(
                  opacity: opacity.toDouble(),
                  child: OverflowBox(
                    maxHeight: kBottomNavigationBarHeight,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: Offstage(
            offstage: isShowingSearch,
            child: Stack(
              alignment: const FractionalOffset(0.5, 1),
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: screenIndex,
                  onTap: (index) {
                    if (index == 2) return;

                    pageController.jumpToPage(index);
                    ref.read(currentScreenIndexSP.notifier).update((state) => index);

                    if (screenIndex == index) {
                      // pop all the previous routes from the navigation stack
                      if (screenKeyList[screenIndex].currentState!.canPop()) {
                        screenKeyList[screenIndex].currentState!.popUntil((route) => route.isFirst);

                        // TODO change this or delete this
                        // TODO update some state notifiers here if necessary
                        // ref.read(pushedHomeChannelSP.notifier).update((state) => false);

                        // scroll all the way to the top
                      } else if (index == 0) {
                        homeScrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      } else if (index == 3) {
                        subsScrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      } else if (index == 4) {
                        libScrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      }
                    }
                  },
                  // unselectedItemColor: isDarkTheme ? Colors.white : Colors.black,
                  unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.play_arrow_outlined,
                        size: 29,
                      ),
                      activeIcon: Icon(Icons.play_arrow),
                      label: 'Shorts',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.transparent,
                      ),
                      activeIcon: Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.subscriptions_outlined),
                      activeIcon: Icon(Icons.subscriptions),
                      label: 'Subscriptions',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.video_library_outlined),
                      activeIcon: Icon(Icons.video_library),
                      label: 'Library',
                    ),
                  ],
                ),
                FloatingActionButton(
                  splashColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightElevation: 0,
                  focusElevation: 0,
                  elevation: 0,
                  onPressed: () => Helper.showAddButtonActions(context: context, ref: ref),
                  child: Icon(
                    Icons.add_circle_outline_sharp,
                    size: 40,
                    // color: isDarkTheme ? Colors.white : Colors.black,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
