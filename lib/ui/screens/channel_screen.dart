import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_clone/ui/screens/error_screen.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_about_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_community_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_home_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_playlists_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_shorts_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_overlap_observer.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_persistent_header.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_subs_tab.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_videos_tab.dart';

class ChannelScreen extends ConsumerStatefulWidget {
  final String channelId;
  final int screenIndex;
  // TODO remove these fields
  final AsyncValue<Channel>? channel;
  final VoidCallback? loadData;

  const ChannelScreen({
    super.key,
    required this.channelId,
    required this.screenIndex,
    this.channel,
    this.loadData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends ConsumerState<ChannelScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  Future<void> getChannelInfo({bool isReloading = false}) async {
    final notifier = ref.read(channelInfoNotifierProvider(widget.screenIndex).notifier);
    await notifier.getChannelInfo(widget.channelId, isRefreshing: isReloading);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 7);
    Future.microtask(getChannelInfo);
    widget.loadData?.call();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channel = ref.watch(channelInfoNotifierProvider(widget.screenIndex)).last;

    return channel.when(
      loading: () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              Icons.chevron_left,
              size: 31,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
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
              index: widget.screenIndex,
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
                screenIndex: widget.screenIndex,
                animateTo: (index) => tabController.animateTo(index),
              ),
              ChannelVideosTab(
                channelId: widget.channelId,
                index: widget.screenIndex,
              ),
              ChannelShortsTab(
                channelId: widget.channelId,
                screenIndex: widget.screenIndex,
              ),
              ChannelPlaylistsTab(
                channelId: widget.channelId,
                index: widget.screenIndex,
              ),
              ChannelCommunityTab(
                channelId: widget.channelId,
                index: widget.screenIndex,
              ),
              ChannelSubsTab(
                channelId: widget.channelId,
                index: widget.screenIndex,
              ),
              ChannelAboutTab(
                channelId: widget.channelId,
                index: widget.screenIndex,
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => ErrorScreen(
        index: widget.screenIndex,
        failure: error as YoutubeFailure,
        onError: () => getChannelInfo(isReloading: true),
      ),
    );
  }
}
