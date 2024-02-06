import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_shorts_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/services/custom_screen.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_shorts_card.dart';

class ChannelShortsTab extends ConsumerStatefulWidget {
  final int screenIndex;
  final String channelId;

  const ChannelShortsTab({
    super.key,
    required this.screenIndex,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelShortsTabState();
}

class _ChannelShortsTabState extends ConsumerState<ChannelShortsTab>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  static const filters = ['Latest', 'Popular'];

  @override
  bool get wantKeepAlive => true;

  Future<void> loadShorts({bool isReloading = false}) async {
    final notifier = ref.read(channelShortsNotifierProvider(widget.screenIndex).notifier);
    await notifier.getShorts(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadShorts);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final shorts = ref.watch(channelShortsNotifierProvider(widget.screenIndex)).last;
    final isDarkTheme = ref.watch(themeNP);

    return CustomScrollView(
      slivers: [
        if (!shorts.isLoading && !shorts.hasError && shorts.hasValue && shorts.value!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 5, bottom: 10),
              child: Row(
                children: filters
                    .mapIndexed(
                      (index, element) => GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          final notifier =
                              ref.read(channelShortsNotifierProvider(widget.screenIndex).notifier);
                          notifier.switchCategory(index == 1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDarkTheme
                                  ? selectedIndex == index
                                      ? Colors.white
                                      : Colors.grey.shade800
                                  : selectedIndex == index
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade300,
                            ),
                            child: Text(
                              element,
                              style: TextStyle(
                                color: isDarkTheme
                                    ? selectedIndex == index
                                        ? Colors.black
                                        : Colors.white
                                    : selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        shorts.when(
          data: (data) {
            if (data.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(100),
                  child: Center(
                    child: Text('oops, looks like it`s empty'),
                  ),
                ),
              );
            }

            return SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: data.length,
              // i feel like the problem is here
              itemBuilder: (context, index) => ChannelShortsCard(
                short: data[index],
                // UPD deleted the pushed screens implementation
                // TODO refactor this
                onTap: () {
                  final notifier = ref.read(screensManagerProvider(widget.screenIndex).notifier);
                  notifier.pushScreen(
                    CustomScreen.short(
                      shortId: data[index].id,
                      // wtf is this?
                      screen: ShortsBody(
                        shorts: shorts.when(
                          data: (data) => BaseInfoLoaded(
                            BaseInfo(data: data),
                          ),
                          error: (error, stackTrace) => BaseInfoError(
                            baseInfo: BaseInfo(data: data),
                            failure: error as YoutubeFailure,
                          ),
                          loading: () => BaseInfoLoading(
                            baseInfo: BaseInfo(data: data),
                          ),
                        ),
                        onLoadVideos: () {},
                        onError: () => loadShorts(isReloading: true),
                        screenIndex: widget.screenIndex,
                        shortIndex: index,
                      ),
                    ),
                    // shouldPushNewScreen: false,
                  );
                  // *******************************
                  // final notifier = ref.read(pushedScreensListNotifierProvider.notifier);
                  // notifier.addScreen(
                  //   // pushedScreens: pushedScreens,
                  //   pushedScreens: screenTypesList,
                  //   newScreen: ScreenTypeAndId(
                  //     screenType: ScreenType.short,
                  //     screenId: data[index].id,
                  //   ),
                  //   index: widget.index,
                  // );
                  //
                  // // log('pushed screens are: $pushedScreens');
                  //
                  // ref.read(playShortSP.notifier).update((state) => {...state, widget.index: true});
                  // Navigator.of(context)
                  //     .push(
                  //   MaterialPageRoute(
                  //     builder: (context) => ShortsBody(
                  //       index: widget.index,
                  //       shortIndex: index,
                  //       onLoadVideos: () {},
                  //       onError: getShorts,
                  //       shorts: shorts.when(
                  //         data: (data) => BaseInfoLoaded(
                  //           BaseInfo(data: data),
                  //         ),
                  //         error: (error, stackTrace) => BaseInfoError(
                  //           baseInfo: BaseInfo(data: data),
                  //           failure: error as YoutubeFailure,
                  //         ),
                  //         loading: () => BaseInfoLoading(
                  //           baseInfo: BaseInfo(data: data),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                  //     .whenComplete(() {
                  //   notifier.removeLast(widget.index);
                  //   // log('state now is: $pushedScreensList');
                  //   // i can put this inside removeLast() above
                  //   // shortScreenIsShort
                  //   isShortScreen
                  //       ? ref
                  //           .read(playShortSP.notifier)
                  //           .update((state) => {...state, widget.index: true})
                  //       : ref
                  //           .read(playShortSP.notifier)
                  //           .update((state) => {...state, widget.index: false});
                  // });
                  // *******************************
                },
              ),
            );
          },
          error: (error, stackTrace) {
            final failure = error as YoutubeFailure;
            final code = failure.failureData.code;

            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Center(
                  child: Column(
                    children: [
                      if (code == 403) ...[
                        const Text('too many requests, try again later'),
                      ] else if (code == 404) ...[
                        const Text('oops, looks like it`s empty'),
                      ] else ...[
                        const Text('unknown error, try again later'),
                      ],
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => loadShorts(isReloading: true),
                        child: const Text('tap to retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
