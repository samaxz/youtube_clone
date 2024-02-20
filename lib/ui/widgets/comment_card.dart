import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends ConsumerStatefulWidget {
  final String channelId;
  final String channelHandle;
  // TODO use this in the future
  final String? profileImageUrl;
  final String text;
  final int likeCount;
  final int replyCount;
  final String publishedTime;

  const CommentCard({
    super.key,
    required this.channelId,
    required this.channelHandle,
    this.profileImageUrl,
    required this.text,
    required this.likeCount,
    required this.replyCount,
    required this.publishedTime,
  });

  @override
  ConsumerState<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends ConsumerState<CommentCard> {
  bool expanded = false;

  Widget showMoreOrLess(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: expanded
                ? widget.text
                : '${widget.text.substring(
                    0,
                    widget.text.length - 50,
                  )}...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (!expanded) ...[
            TextSpan(
              text: ' Read more',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              recognizer: TapGestureRecognizer()
                ..onTap = () => setState(() => expanded = !expanded),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      maxLines: 4,
      text: TextSpan(text: widget.text),
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    final screenIndex = ref.read(currentScreenIndexSP);
                    final notifier = ref.read(screensManagerProvider(screenIndex).notifier);
                    notifier.pushScreen(
                      CustomScreen.channel(
                        channelId: widget.channelId,
                        screenIndex: screenIndex,
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    foregroundImage: AssetImage(Helper.defaultPfp),
                    radius: 20,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.channelHandle,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      LayoutBuilder(
                        builder: (context, constrains) {
                          textPainter.layout(maxWidth: constrains.maxWidth);
                          final overflowed = textPainter.didExceedMaxLines;
                          if (overflowed) {
                            return InkWell(
                              // this'll expand the text
                              onTap: () => setState(() => expanded = !expanded),
                              child: showMoreOrLess(context),
                            );
                          }
                          return Text(widget.text);
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${widget.likeCount} likes • ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${widget.replyCount} replies • ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            timeago.format(
                              DateTime.parse(widget.publishedTime),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
