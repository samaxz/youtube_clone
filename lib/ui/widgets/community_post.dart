import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/data/models/channel/community_post_model.dart' as community_post;
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';

class CommunityPost extends ConsumerWidget {
  final community_post.CommunityPost communityPost;
  final int index;

  const CommunityPost({
    super.key,
    required this.communityPost,
    required this.index,
  });

  TextSpan linkify(BuildContext context, String rawText) {
    final spans = rawText.split(RegExp('(?=https?://|mailto:|tel:)')).indexed.expand((e) {
      final (i, chunk) = e;
      final index = i == 0 ? 0 : chunk.indexOf(RegExp('\\s|\\)|\$'));
      final link = chunk.substring(0, index);

      return [
        if (i != 0)
          TextSpan(
            text: link.replaceFirst(RegExp('^(mailto|tel):'), ''),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(
                    Uri.parse(link),
                  ),
          ),
        TextSpan(
          text: chunk.substring(index),
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ];
    });

    return TextSpan(
      children: [...spans],
    );
  }

  void handleMoreVertPressed(WidgetRef ref) {
    // TODO change this in the future
    ref.read(unauthAttemptSP.notifier).update((state) => true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onTap: () => handleMoreVertPressed(ref),
                onLongPress: () => handleMoreVertPressed(ref),
                child: const Icon(Icons.more_vert),
              )
            ],
          ),
          for (final text in communityPost.contentText) ...[
            if (text != null && text['text'] != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RichText(
                  text: linkify(context, text['text']),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
