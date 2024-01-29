import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_home_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_video_tile.dart';

class ChannelHomeTab extends ConsumerStatefulWidget {
  final String channelId;
  // bottom nav bar tab's index
  final int screenIndex;
  final void Function(int index) animateTo;

  const ChannelHomeTab({
    super.key,
    required this.channelId,
    required this.screenIndex,
    required this.animateTo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelHomeTabState();
}

class _ChannelHomeTabState extends ConsumerState<ChannelHomeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadHomeVids({bool isReloading = false}) async {
    final notifier = ref.read(channelHomeNotifierProvider(widget.screenIndex).notifier);
    await notifier.getHomeTabContent(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(loadHomeVids);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final uploads = ref.watch(channelHomeNotifierProvider(widget.screenIndex)).last;

    return CustomScrollView(
      slivers: [
        // TODO test this case
        if (uploads.hasValue && uploads.value!.videos.isEmpty && uploads.value!.shorts.isEmpty) ...[
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 90),
              child: Text('oops, looks like it`s empty'),
            ),
          ),
        ] else ...[
          uploads.when(
            data: (data) {
              if (data.videos.isEmpty) {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.only(top: 50),
                sliver: SliverList.builder(
                  itemCount: data.videos.length >= 8 ? 8 : data.videos.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: GestureDetector(
                          onTap: () => widget.animateTo(1),
                          child: const Text('Videos'),
                        ),
                      );
                    }

                    return ChannelVideoTile(
                      video: data.videos[index - 1],
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              // final failure = error as YoutubeFailure;

              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: TextButton(
                      onPressed: () => loadHomeVids(isReloading: true),
                      child: const Text('Tap to retry'),
                    ),
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.only(top: 90),
                  //   child: Column(
                  //     children: [
                  //       Text('Error: ${error.failureData.message}'),
                  //       const SizedBox(height: 10),
                  //       ElevatedButton(
                  //         onPressed: loadHomeVids,
                  //         child: const Text('Tap to retry'),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          uploads.when(
            data: (data) {
              if (data.shorts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }

              return SliverList.builder(
                // why do i need + 1 though
                itemCount: data.shorts.length >= 8 ? 8 : data.shorts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: data.videos.isEmpty
                          ? const EdgeInsets.fromLTRB(10, 60, 0, 5)
                          : const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: InkWell(
                        enableFeedback: false,
                        onTap: () => widget.animateTo(2),
                        child: const Text('Shorts'),
                      ),
                    );
                  }

                  return ChannelVideoTile(
                    video: data.shorts[index - 1],
                  );
                },
              );
            },
            error: (error, stackTrace) => const SliverToBoxAdapter(
              child: SizedBox(),
            ),
            loading: () => const SliverToBoxAdapter(
              child: SizedBox(),
            ),
          ),
        ],
      ],
    );
  }
}
