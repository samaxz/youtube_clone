import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_shorts_notifier.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_list_notifier.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_shorts_card.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body_player.dart';

class ChannelShortsTab extends ConsumerStatefulWidget {
  final int index;
  final String channelId;

  const ChannelShortsTab({
    super.key,
    required this.index,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChannelShortsTabState();
}

class _ChannelShortsTabState extends ConsumerState<ChannelShortsTab>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  static const filters = ['Latest', 'Popular'];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(channelShortsTabCNP.notifier);
    notifier.getShorts(
      index: widget.index,
      channelId: widget.channelId,
      addState: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final shorts = ref.watch(
      channelShortsTabCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );
    final shortScreenIsShort = ref.watch(
      pushedScreensCNP.select(
        (value) {
          return value.screens[widget.index]!.last.screenTypeAndId.screenType ==
              ScreenType.short;
        },
      ),
    );
    final pushedScreens = ref.watch(
      pushedScreensCNP.select(
        (value) {
          return value.screens[widget.index]!
              .map((e) => e.screenTypeAndId)
              .toList();
        },
      ),
    );
    final darkTheme = ref.watch(themeNP);

    return CustomScrollView(
      slivers: [
        if (!shorts.isLoading &&
            !shorts.hasError &&
            shorts.hasValue &&
            shorts.value!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 5,
                bottom: 10,
              ),
              child: Row(
                children: filters
                    .mapIndexed(
                      (index, element) => GestureDetector(
                        onTap: () {
                          final notifier =
                              ref.read(channelShortsTabCNP.notifier);

                          if (index == 0) {
                            notifier.getShorts(
                              index: widget.index,
                              channelId: widget.channelId,
                              addState: false,
                            );
                          } else {
                            notifier.getPopularShorts(
                              index: widget.index,
                              channelId: widget.channelId,
                            );
                          }
                          setState(() => selectedIndex = index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: darkTheme
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
                                color: darkTheme
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
              itemBuilder: (context, index) => ChannelShortsCard(
                short: data[index],
                // UPD deleted the pushed screens implementation
                onTap: () {
                  final notifier =
                      ref.read(pushedScreensListNotifierProvider.notifier);
                  notifier.addScreen(
                    pushedScreens: pushedScreens,
                    newScreen: ScreenTypeAndId(
                      screenType: ScreenType.short,
                      screenId: data[index].id,
                    ),
                    index: widget.index,
                  );

                  // log('pushed screens are: $pushedScreens');

                  ref
                      .read(playShortSP.notifier)
                      .update((state) => {...state, widget.index: true});
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => ShortsBody(
                        index: widget.index,
                        shortIndex: index,
                        onLoadVideos: () {},
                        onError: () {
                          final notifier =
                              ref.read(channelShortsTabCNP.notifier);
                          notifier.getShorts(
                            index: index,
                            channelId: data[index].id,
                            addState: true,
                          );
                        },
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
                      ),
                    ),
                  )
                      .whenComplete(() {
                    notifier.removeLast(widget.index);
                    // log('state now is: $pushedScreensList');
                    // * i can put this inside removeLast() above
                    shortScreenIsShort
                        ? ref
                            .read(playShortSP.notifier)
                            .update((state) => {...state, widget.index: true})
                        : ref
                            .read(playShortSP.notifier)
                            .update((state) => {...state, widget.index: false});
                  });
                },
              ),
            );
          },
          error: (error, stackTrace) {
            final failure = error as YoutubeFailure;

            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Center(
                  child: Column(
                    children: [
                      Text('Error: ${error.failureData.message}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final notifier =
                              ref.read(channelShortsTabCNP.notifier);
                          notifier.getShorts(
                            index: widget.index,
                            channelId: widget.channelId,
                            addState: true,
                          );
                        },
                        child: const Text('Tap to retry'),
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
