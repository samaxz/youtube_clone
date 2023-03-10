import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_demo/screens/authorization_screen.dart';
import 'package:youtube_demo/screens/notifications_screen.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

import 'package:youtube_demo/widgets/filter_button.dart';

class CustomSliverAppBar extends ConsumerStatefulWidget {
  final VoidCallback? onTap;
  final bool displayExpandedHeight;
  final int index;

  const CustomSliverAppBar({
    super.key,
    this.onTap,
    this.displayExpandedHeight = false,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends ConsumerState<CustomSliverAppBar> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //   () => ref.read(authNotifierProvider.notifier).checkAndUpdateAuthStatus(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final fullScreen = ref.watch(fullScreenPressedSP);
    final authState = ref.watch(authNotifierProvider);
    final categories = ref.watch(videoCategoryNP);
    var darkTheme = ref.watch(themeNP);

    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      elevation: 0,
      expandedHeight: categories.when(
        // TODO prolly refactor this
        data: (data) =>
            widget.displayExpandedHeight ? kToolbarHeight * 2 : null,
        error: (error, stackTrace) => null,
        loading: () => null,
      ),
      // TODO probably make this return a custom widget, instead of null
      flexibleSpace: categories.when(
        data: (data) => widget.displayExpandedHeight
            ? FlexibleSpaceBar(
                background: Padding(
                  // TODO put this into a separate widget
                  padding: !fullScreen
                      ? const EdgeInsets.only(top: 50, bottom: 5)
                      : EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data
                              .where((category) => category.snippet.assignable)
                              .length +
                          4,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 16,
                            ),
                            child: FilterButton(
                              item: Icon(MdiIcons.compassOutline),
                              id: '',
                              index: index,
                              isFirst: true,
                              selectedPosition: 0,
                              onTap: (index) =>
                                  Helper.scaffoldKey.currentState!.openDrawer(),
                            ),
                          );
                        }

                        // * the All filter button
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 16,
                            ),
                            child: FilterButton(
                              item: Text(
                                'All',
                                style: TextStyle(
                                  color: darkTheme
                                      ? _selectedIndex == index
                                          ? Colors.black
                                          : Colors.white
                                      : _selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              id: '0',
                              index: index,
                              selectedPosition: _selectedIndex,
                              color:
                                  _selectedIndex == index ? Colors.black : null,
                              onTap: (index) {
                                _selectedIndex = index;
                                setState(() {});
                                ref.invalidate(videosNPOld);
                                ref.read(videosNPOld.notifier).getVideos(
                                      categoryId: 0,
                                      authState: authState,
                                    );
                              },
                            ),
                          );
                        }

                        final filter = data[index - 2];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 16,
                          ),
                          child: FilterButton(
                            item: Text(
                              filter.snippet.title,
                              style: darkTheme
                                  ? TextStyle(
                                      color: _selectedIndex == index
                                          ? Colors.black
                                          : Colors.white,
                                    )
                                  : TextStyle(
                                      color: _selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                            ),
                            id: filter.id,
                            index: index,
                            selectedPosition: _selectedIndex,
                            onTap: (index) {
                              _selectedIndex = index;
                              setState(() {});
                              // * this is kind of useless
                              ref.invalidate(videosNPOld);
                              ref.read(videosNPOld.notifier).getVideos(
                                    categoryId: int.parse(filter.id),
                                    authState: authState,
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : null,
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink(),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: darkTheme
            ? Image.asset('assets/youtube_dark_mode.png')
            : Image.asset('assets/youtube.png'),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cast,
            color: darkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            useSafeArea: true,
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.clear),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'I don`t think i`m gonna implement this to begin with',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: darkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(index: widget.index),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: darkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () => Helper.handleShowSearch(
            context: context,
            ref: ref,
            index: widget.index,
          ),
        ),
        IconButton(
          // TODO make this a custom widget, cause it's used on 2 screens
          icon: const CircleAvatar(
            foregroundImage: AssetImage(Helper.defaultPfp),
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              enableDrag: false,
              isScrollControlled: true,
              useRootNavigator: true,
              useSafeArea: true,
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.clear),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark mode:'),
                          Switch(
                            value: darkTheme,
                            onChanged: (value) {
                              setState(() {
                                darkTheme = !darkTheme;
                              });
                              ref.read(themeNP.notifier).toggleThemes();
                            },
                          ),
                        ],
                      ),
                    ),
                    authState.maybeWhen(
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      authenticated: () => Expanded(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(authNP.notifier).signOut().whenComplete(
                                    () => Navigator.of(context).pop(),
                                  );
                            },
                            child: const Text('sign out of your account'),
                          ),
                        ),
                      ),
                      unauthenticated: () => Expanded(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await ref.read(authNP.notifier).signIn(
                                (authorizationUrl) {
                                  final completer = Completer<Uri>();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AuthorizationScreen(
                                        authorizationUrl: authorizationUrl,
                                        onAuthorizationCodeRedirectAttempt:
                                            (redirectedUrl) {
                                          completer.complete(redirectedUrl);
                                        },
                                      ),
                                    ),
                                  );
                                  return completer.future;
                                },
                              );

                              if (!context.mounted) return;

                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);

                              ref
                                  .read(pushedHomeChannelSP.notifier)
                                  .update((state) => false);
                            },
                            child: const Text('sign in to your account'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
