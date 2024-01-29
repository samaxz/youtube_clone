import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/data/models/channel/community_post_model.dart' as community_post;
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

class CommunityPost extends ConsumerWidget {
  final community_post.CommunityPost communityPost;
  final int index;

  const CommunityPost({
    super.key,
    required this.communityPost,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final index = ref.watch(currentScreenIndexSP);
    // final channel = ref.watch(
    //   channelInfoCNP.select(
    //     (value) => value.state[index]!.last.value,
    //   ),
    // )!;
    final channel = ref.watch(channelInfoNotifierProvider(index)).last.value!;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                Helper.defaultPfp,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(channel.snippet.title),
                  Text(communityPost.date ?? 'unknown'),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Helper.handleSavePressed(context),
                onLongPress: () => Helper.handleSavePressed(context),
                child: const Icon(Icons.more_vert),
              )
            ],
          ),
          for (final text in communityPost.contentText) ...[
            // this ?? check doesn't display anything
            Text(text?['text'] ?? ''),
          ],
        ],
      ),
    );
  }
}
