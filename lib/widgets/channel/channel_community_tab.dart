import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_demo/widgets/community_post.dart';

class ChannelCommunityTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelCommunityTab({
    super.key,
    required this.channelId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChannelCommunityTabState();
}

class _ChannelCommunityTabState extends ConsumerState<ChannelCommunityTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    ref
        .read(channelCommunityTabCNP.notifier)
        .getCommunityPosts(channelId: widget.channelId, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final posts = ref.watch(
      channelCommunityTabCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );

    return posts.when(
      data: (data) => ListView.separated(
        padding: const EdgeInsets.only(top: 50),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) => CommunityPost(
          communityPost: data[index],
          index: widget.index,
        ),
      ),
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: ${error.failureData.message}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => ref
                    .read(communityPostsNotifierProvider.notifier)
                    .getCommunityPosts(widget.channelId),
                child: const Text('Tap to retry'),
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
