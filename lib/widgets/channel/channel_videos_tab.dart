import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_videos_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_video_card.dart';

class ChannelVideosTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelVideosTab({
    super.key,
    required this.index,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChannelVideosTabState();
}

class _ChannelVideosTabState extends ConsumerState<ChannelVideosTab>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  static const filters = ['Latest', 'Popular', 'Oldest'];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(channelVideosTabCNP.notifier);
    Future.microtask(
      () => notifier.getVideos(
        index: widget.index,
        channelId: widget.channelId,
        shouldAdd: true,
        reloading: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final videos = ref.watch(
      channelVideosTabCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );
    final darkTheme = ref.watch(themeNP);

    return CustomScrollView(
      slivers: [
        if (!videos.isLoading &&
            !videos.hasError &&
            videos.hasValue &&
            videos.value!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 5,
                bottom: 2,
              ),
              child: Row(
                children: filters
                    .mapIndexed(
                      (index, element) => GestureDetector(
                        onTap: () {
                          final notifier =
                              ref.read(channelVideosTabCNP.notifier);

                          if (index == 0 || index == 2) {
                            notifier.getVideos(
                              index: widget.index,
                              channelId: widget.channelId,
                              shouldAdd: false,
                              reloading: false,
                            );
                          } else {
                            notifier.getPopularVideos(
                              index: widget.index,
                              channelId: widget.channelId,
                            );
                          }
                          setState(() => selectedIndex = index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
                return ChannelVideoCard(
                  video: data[index],
                );
              },
            );
          },
          error: (error, stackTrace) {
            final errorNew = error as YoutubeFailure;

            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Text('error: ${error.failureData.message}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final notifier =
                              ref.read(channelVideosTabCNP.notifier);
                          notifier.getVideos(
                            index: widget.index,
                            channelId: widget.channelId,
                            shouldAdd: true,
                            reloading: true,
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
