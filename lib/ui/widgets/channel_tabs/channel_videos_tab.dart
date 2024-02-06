import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_videos_notifier.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_video_tile.dart';

class ChannelVideosTab extends ConsumerStatefulWidget {
  final String channelId;
  final int screenIndex;

  const ChannelVideosTab({
    super.key,
    required this.screenIndex,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelVideosTabState();
}

class _ChannelVideosTabState extends ConsumerState<ChannelVideosTab>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  static const filters = ['Latest', 'Popular', 'Oldest'];

  @override
  bool get wantKeepAlive => true;

  Future<void> loadVideos({bool isReloading = false}) async {
    final notifier = ref.read(channelVideosNotifierProvider(widget.screenIndex).notifier);
    await notifier.getVideos(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadVideos);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final videos = ref.watch(channelVideosNotifierProvider(widget.screenIndex)).last;
    final isDarkTheme = ref.watch(themeNP);
    final notifier = ref.watch(channelVideosNotifierProvider(widget.screenIndex).notifier);
    final displayFilters = notifier.displayFilters;

    return CustomScrollView(
      slivers: [
        if (displayFilters)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 5, bottom: 2),
              child: Row(
                children: filters
                    .mapIndexed(
                      (index, element) => GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          final notifier =
                              ref.read(channelVideosNotifierProvider(widget.screenIndex).notifier);
                          notifier.switchVideos(index == 1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
        videos.when(
          data: (data) {
            if (data.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(80),
                  child: Center(
                    child: Text('oops, looks like it`s empty'),
                  ),
                ),
              );
            }

            return SliverList.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ChannelVideoTile(
                  video: data[index],
                );
              },
            );
          },
          error: (error, stackTrace) {
            final failure = error as YoutubeFailure;
            final code = failure.failureData.code;

            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
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
                        onPressed: () => loadVideos(isReloading: true),
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
              padding: EdgeInsets.only(top: 90),
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
