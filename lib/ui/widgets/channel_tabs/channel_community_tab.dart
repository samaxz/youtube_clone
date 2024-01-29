import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_clone/ui/widgets/community_post.dart';

class ChannelCommunityTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelCommunityTab({
    super.key,
    required this.channelId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelCommunityTabState();
}

class _ChannelCommunityTabState extends ConsumerState<ChannelCommunityTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadPosts({bool isReloading = false}) async {
    final notifier = ref.read(channelCommunityNotifierProvider(widget.index).notifier);
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

    final posts = ref.watch(channelCommunityNotifierProvider(widget.index)).last;

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
          child: TextButton(
            onPressed: () => loadPosts(isReloading: true),
            child: const Text('Tap to retry'),
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text('Error: ${error.failureData.message}'),
          //     const SizedBox(height: 10),
          //     ElevatedButton(
          //       onPressed: getPosts,
          //       child: const Text('Tap to retry'),
          //     ),
          //   ],
          // ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
