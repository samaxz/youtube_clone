import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_clone/logic/notifiers/video_category_notifier.dart';
import 'package:youtube_clone/logic/notifiers/videos_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/screens/notifications_screen.dart';
import 'package:youtube_clone/ui/widgets/filter_button.dart';

class CustomSliverAppBar extends ConsumerStatefulWidget {
  final bool displayExpandedHeight;
  final int index;

  const CustomSliverAppBar({
    super.key,
    this.displayExpandedHeight = false,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends ConsumerState<CustomSliverAppBar> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final categories = ref.watch(videoCategoriesNotifierProvider);
    var isDarkTheme = ref.watch(themeNP);

    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      elevation: 0,
      expandedHeight: categories.when(
        data: (data) => widget.displayExpandedHeight ? kToolbarHeight * 2 : null,
        error: (error, stackTrace) => null,
        loading: () => null,
      ),
      // TODO probably make this return a custom widget, instead of null
      flexibleSpace: categories.when(
        data: (data) => widget.displayExpandedHeight
            ? FlexibleSpaceBar(
                background: Padding(
                  // TODO put this into a separate widget
                  padding: const EdgeInsets.only(top: 50, bottom: 5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.where((category) => category.snippet.assignable).length + 4,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 16,
                          ),
                          child: FilterButton(
                            item: Icon(
                              MdiIcons.compassOutline,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            id: '',
                            index: index,
                            isFirst: true,
                            selectedPosition: 0,
                            onTap: (index) => Helper.scaffoldKey.currentState!.openDrawer(),
                          ),
                        );
                      }

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
                                color: isDarkTheme
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
                            color: _selectedIndex == index ? Colors.black : null,
                            onTap: (index) {
                              setState(() => _selectedIndex = index);
                              ref.invalidate(videosNotifierProvider);
                              ref.read(videosNotifierProvider.notifier).getVideos(newCategoryId: 0);
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
                            style: isDarkTheme
                                ? TextStyle(
                                    color: _selectedIndex == index ? Colors.black : Colors.white,
                                  )
                                : TextStyle(
                                    color: _selectedIndex == index ? Colors.white : Colors.black,
                                  ),
                          ),
                          id: filter.id,
                          index: index,
                          selectedPosition: _selectedIndex,
                          onTap: (index) {
                            setState(() => _selectedIndex = index);
                            ref.invalidate(videosNotifierProvider);
                            ref
                                .read(videosNotifierProvider.notifier)
                                .getVideos(newCategoryId: int.parse(filter.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            : null,
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink(),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child:
            isDarkTheme ? Image.asset(Helper.youtubeLogoDarkMode) : Image.asset(Helper.youtubeLogo),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cast,
            color: Theme.of(context).colorScheme.onSurface,
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
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
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
            color: Theme.of(context).colorScheme.onSurface,
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
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Helper.pressSearch(
            context: context,
            ref: ref,
            screenIndex: widget.index,
          ),
        ),
        IconButton(
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
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
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
                            value: isDarkTheme,
                            onChanged: (value) {
                              setState(() => isDarkTheme = !isDarkTheme);
                              ref.read(themeNP.notifier).toggleTheme();
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
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .signOut()
                                  .whenComplete(() => Navigator.of(context).pop());
                            },
                            child: const Text('sign out of your account'),
                          ),
                        ),
                      ),
                      unauthenticated: () => Expanded(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Helper.authenticate(ref: ref, context: context);
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
