import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_clone/ui/widgets/community_post.dart';

class ChannelCommunityTab extends ConsumerStatefulWidget {
  final String channelId;
  final int screenIndex;

  const ChannelCommunityTab({
    super.key,
    required this.channelId,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelCommunityTabState();
}

class _ChannelCommunityTabState extends ConsumerState<ChannelCommunityTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadPosts({bool isReloading = false}) async {
    final notifier = ref.read(channelCommunityNotifierProvider(widget.screenIndex).notifier);
    await notifier.getCommunityPosts(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadPosts);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final posts = ref.watch(channelCommunityNotifierProvider(widget.screenIndex)).last;

    return posts.when(
      data: (data) => ListView.separated(
        padding: const EdgeInsets.only(top: 50),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) => CommunityPost(
          communityPost: data[index],
          index: widget.screenIndex,
        ),
      ),
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;
        final code = failure.failureData.code;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                onPressed: () => loadPosts(isReloading: true),
                child: const Text('tap to retry'),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
