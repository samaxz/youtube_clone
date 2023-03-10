import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_uploads_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_video_card.dart';

class ChannelHomeTab extends ConsumerStatefulWidget {
  final String channelId;
  // * screen index - bottom nav bar tab index
  final int index;
  final void Function(int index) animateTo;

  const ChannelHomeTab({
    super.key,
    required this.channelId,
    required this.index,
    required this.animateTo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelHomeTabState();
}

class _ChannelHomeTabState extends ConsumerState<ChannelHomeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    final notifier = ref.read(channelHomeNotifierProvider.notifier);
    notifier.getHomeTabContent(
      index: widget.index,
      channelId: widget.channelId,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final uploads = ref.watch(channelHomeNotifierProvider)[widget.index]!.last;

    return CustomScrollView(
      slivers: [
        uploads.when(
          data: (data) {
            if (data.videos.isEmpty) {
              return const SliverToBoxAdapter(
                child: SizedBox.shrink(),
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

                  return ChannelVideoCard(
                    video: data.videos[index - 1],
                  );
                },
              ),
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
                      Text('Error: ${error.failureData.message}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          final notifier =
                              ref.read(channelHomeNotifierProvider.notifier);
                          notifier.getHomeTabContent(
                            index: widget.index,
                            channelId: widget.channelId,
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
                child: SizedBox.shrink(),
              );
            }

            return SliverList.builder(
              // * ayo, wtf is this - why do i need + 1 tho
              itemCount: data.shorts.length >= 8 ? 8 : data.shorts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: data.videos.isEmpty
                        ? const EdgeInsets.fromLTRB(10, 60, 0, 5)
                        : const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: InkWell(
                      enableFeedback: false,
                      onTap: () {
                        widget.animateTo(2);
                      },
                      child: const Text('Shorts'),
                    ),
                  );
                }

                return ChannelVideoCard(
                  video: data.shorts[index - 1],
                );
              },
            );
          },
          error: (error, stackTrace) => const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          ),
          loading: () => const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
