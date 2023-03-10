// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_demo/screens/home_screen.dart';
import 'package:youtube_demo/screens/library_screen.dart';
import 'package:youtube_demo/screens/miniplayer_screen.dart';
import 'package:youtube_demo/screens/shorts_screen.dart';
import 'package:youtube_demo/screens/subscriptions_screen.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_demo/widgets/custom_miniplayer.dart';
import 'package:youtube_demo/widgets/my_miniplayer.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body_player.dart';

final showOptionsSP = StateProvider<ShowOptions>((ref) => const Neither());

final unauthAttemptSP = StateProvider((ref) => false);

final selectedShortSP = StateProvider((ref) => false);

final dismissSP = StateProvider((ref) => false);

class NavScreen extends ConsumerStatefulWidget {
  const NavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavScreenState();
}

// * no point in using this mixin here, cause it doesn't work
class _NavScreenState extends ConsumerState<NavScreen> {
  static const double playerMinHeight = 60;
  late double playerMaxHeight;
  late final PageController pageController;

  // these are screens for the bottom nav bar
  List<Widget> screens = [
    const HomeScreen(),
    const ShortsScreen(),
    const SizedBox(),
    const SubscriptionsScreen(),
    const LibraryScreen(),
  ];

  static final screenKeyList = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    ref.read(connectivitySNP.notifier).initState();
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
    final scrollController = ref.watch(scrollControllerP);
    final showSearch = ref.watch(showSearchSP);
    final selectedIndex = ref.watch(currentScreenIndexSP);
    final authState = ref.watch(authNP);
    final playShort = ref.watch(playShortSP)[selectedIndex]!;
    final isShortScreen = ref.watch(
      pushedScreensCNP.select(
        (value) =>
            value.screens[selectedIndex]!.last.screenTypeAndId.screenType ==
            ScreenType.short,
      ),
    );
    final darkTheme = ref.watch(themeNP);

    // * this shows different pop-ups, depending on the chosen item:
    // video, channel, short...
    // it's shown on top of the MP
    ref.listen(
      showOptionsSP,
      (_, state) {
        state.maybeWhen(
          // * or else here is neither
          orElse: () {},
          video: (videoId, screenAction, videoCardIndex) {
            Helper.handleMoreVertPressed(
              context: context,
              ref: ref,
              screenIdAndActions: ScreenIdAndActions(
                id: videoId,
                actions: screenAction,
              ),
              videoCardIndex: videoCardIndex,
            );
          },
        );

        ref.read(showOptionsSP.notifier).update((state) => const Neither());
      },
    );

    // * this shows the authentication page, when the user is
    // unauthenticated to sign in
    ref.listen(unauthAttemptSP, (_, state) {
      if (state) {
        Helper.handleAuthButtonPressed(
          context: context,
          ref: ref,
          authState: authState,
        );
      }

      // * this cancels it right away, to allow continuous auth
      // actions to be performed - over and over again,
      ref.read(unauthAttemptSP.notifier).update((state) => false);
    });

    // * this listens to the current inet connection and displays
    // bottom sheet if there's none
    ref.listen(
      connectivitySNP,
      (_, state) {
        state.when(
          offline: () {
            offline = true;

            Helper.scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                height: 30,
                width: double.infinity,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text('No internet'),
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
        final navigator = screenKeyList[selectedIndex].currentState!;

        if (!navigator.canPop()) return true;
        navigator.pop();

        return false;
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        key: Helper.scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListTile(
                  leading: darkTheme
                      ? Image.asset(
                          'assets/youtube_dark_mode.png',
                          height: 25,
                        )
                      : Image.asset(
                          'assets/youtube.png',
                          height: 25,
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
          child: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  ref
                      .read(currentScreenIndexSP.notifier)
                      .update((state) => index);
                },
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
                // will be hidden, thanks to offstage
                offstage: selectedVideo == null ||
                    // TODO change this
                    showSearch ||
                    // * and this
                    playShort ||
                    isShortScreen,
                child: CustomMiniplayer(video: selectedVideo),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: playerExpandProgress,
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
              // * could also be <, whatever
              height: value <= 1
                  ? kBottomNavigationBarHeight -
                      kBottomNavigationBarHeight * value
                  : 0,
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
          child: Stack(
            alignment: const FractionalOffset(0.5, 1),
            children: [
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                onTap: (index) {
                  if (index == 2) return;

                  pageController.jumpToPage(index);

                  ref
                      .read(currentScreenIndexSP.notifier)
                      .update((state) => index);

                  if (selectedIndex == index) {
                    if (screenKeyList[selectedIndex].currentState!.canPop()) {
                      screenKeyList[selectedIndex]
                          .currentState!
                          .popUntil((route) => route.isFirst);

                      // TODO change this
                      ref
                          .read(pushedHomeChannelSP.notifier)
                          .update((state) => false);
                    }

                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  }
                },
                unselectedItemColor: darkTheme ? Colors.white : Colors.black,
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
                onPressed: () => Helper.handleAddButtonPressed(
                  context: context,
                  ref: ref,
                ),
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 40,
                  color: darkTheme ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
