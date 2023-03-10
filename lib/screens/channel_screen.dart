import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/screens/error_screen.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_about_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_community_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_home_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_sliver_appbar.dart';
import 'package:youtube_demo/widgets/channel/channel_sliver_overlap_observer.dart';
import 'package:youtube_demo/widgets/channel/channel_sliver_persistent_header.dart';
import 'package:youtube_demo/widgets/channel/channel_shorts_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_playlists_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_subs_tab.dart';
import 'package:youtube_demo/widgets/channel/channel_videos_tab.dart';

class ChannelScreen extends ConsumerStatefulWidget {
  final String channelId;
  final int index;
  final AsyncValue<Channel>? channel;
  final VoidCallback? loadData;

  const ChannelScreen({
    super.key,
    required this.channelId,
    required this.index,
    this.channel,
    this.loadData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends ConsumerState<ChannelScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 7);

    final notifier = ref.read(channelInfoCNP.notifier);
    Future.microtask(
      () => notifier.getChannelInfo(
        channelId: widget.channelId,
        index: widget.index,
      ),
    );
    widget.loadData?.call();
  }

  @override
  void dispose() {
    if (!mounted) {
      tabController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channel = ref.watch(
      channelInfoCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );

    return channel.when(
      loading: () => Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.chevron_left),
        ),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      data: (data) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            ChannelSliverAppbar(
              channel: data,
              index: widget.index,
            ),
            ChannelSliverPersistentHeader(
              channel: data,
              onAboutPressed: () => tabController.animateTo(6),
            ),
            ChannelSliverOverlapAbsorber(tabController: tabController),
          ],
          body: TabBarView(
            controller: tabController,
            children: [
              ChannelHomeTab(
                channelId: widget.channelId,
                index: widget.index,
                animateTo: (index) => tabController.animateTo(index),
              ),
              ChannelVideosTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
              ChannelShortsTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
              ChannelPlaylistsTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
              ChannelCommunityTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
              ChannelSubsTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
              ChannelAboutTab(
                channelId: widget.channelId,
                index: widget.index,
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => ErrorScreen(
        failure: error as YoutubeFailure,
        onError: () {
          final notifier = ref.read(channelInfoCNP.notifier);
          notifier.getChannelInfo(
            channelId: widget.channelId,
            index: widget.index,
          );
        },
      ),
    );
  }
}
