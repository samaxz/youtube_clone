import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/widgets/my_miniplayer.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/widgets/comment_card.dart';
import 'package:youtube_demo/widgets/custom_inkwell.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_demo/widgets/video_card.dart';

class VideoInfoTile extends ConsumerStatefulWidget {
  final Video video;
  final Channel channel;
  final BaseInfo<Comment> commentsInfo;

  const VideoInfoTile({
    super.key,
    required this.video,
    required this.channel,
    required this.commentsInfo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoInfoTileState();
}

class _VideoInfoTileState extends ConsumerState<VideoInfoTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          onExpansionChanged: (value) => setState(() => expanded = !expanded),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                widget.video.snippet.title,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    widget.video.statistics?.viewCount != null
                        ? '${Helper.numberFormatter(widget.video.statistics!.viewCount!)} views  •'
                        : 'unknown views  •',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    timeago.format(widget.video.snippet.publishedAt),
                  ),
                ],
              ),
            ],
          ),
          trailing: expanded ? Icon(MdiIcons.menuUp) : Icon(MdiIcons.menuDown),
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.video.snippet.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const Divider(),
        _ActionsRow(widget.video),
        const Divider(),
        _AuthorInfo(widget.channel),
        const Divider(),
        _CommentsSection(widget.commentsInfo),
        const Divider(),
      ],
    );
  }
}

class _ActionsRow extends ConsumerWidget {
  final Video video;

  const _ActionsRow(this.video);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(ratingFP(video));
    final like = rating
        .whenData((value) => value.maybeWhen(
              orElse: () => const Icon(
                Icons.thumb_up_off_alt_outlined,
                size: 28,
              ),
              liked: () => const Icon(
                Icons.thumb_up,
                size: 28,
                color: Colors.white,
              ),
            ))
        .valueOrNull;

    final dislike = rating
        .whenData((value) => value.maybeWhen(
              orElse: () => const Icon(
                Icons.thumb_down_off_alt_outlined,
                size: 28,
              ),
              liked: () => const Icon(
                Icons.thumb_down,
                size: 28,
                color: Colors.white,
              ),
            ))
        .valueOrNull;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // * this is the like button
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // like,
              like ?? const CircularProgressIndicator(),
              const SizedBox(height: 5),
              Text(
                video.statistics?.likeCount != null
                    ? '${Helper.numberFormatter(video.statistics!.likeCount!)} '
                    : 'Like',
              ),
            ],
          ),
          onTap: () => ref.read(ratingSNP.notifier).like(video.id),
          onLongPress: () => ref.read(ratingSNP.notifier).like(video.id),
        ),
        // * this is the dislike button
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // dislike,
              dislike ?? const CircularProgressIndicator(),
              const SizedBox(height: 5),
              const Text('Dislike'),
            ],
          ),
          onTap: () => ref.read(ratingSNP.notifier).dislike(video.id),
          onLongPress: () => ref.read(ratingSNP.notifier).dislike(video.id),
        ),
        CustomInkWell(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.reply_outlined,
                size: 30,
              ),
              SizedBox(height: 5),
              Text('Share'),
            ],
          ),
          onTap: () => Helper.handleSharePressed(context),
        ),
        CustomInkWell(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.download_outlined,
                size: 30,
              ),
              SizedBox(height: 5),
              Text('Download'),
            ],
          ),
          onTap: () {
            Helper.showDownloadPressed(
              context: context,
              ref: ref,
              videoId: video.id,
            );
          },
        ),
        CustomInkWell(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.library_add_outlined,
                size: 30,
              ),
              SizedBox(height: 5),
              Text('Save'),
            ],
          ),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The video has been added to Watch Later'),
            ),
          ),
          onLongPress: () => Helper.handleSavePressed(context),
        ),
      ],
    );
  }
}

class _AuthorInfo extends ConsumerWidget {
  final Channel channel;

  const _AuthorInfo(this.channel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentScreenIndexSP);
    final subscription = ref.watch(subscriptionSNP);
    final pushedScreens = ref.watch(
      pushedScreensCNP.select(
        (value) => value.screens[index]?.lastWhere(
          (element) => true,
          orElse: () => CustomScreen.initial(),
        ),
      ),
    );

    final subscribed = subscription
        .whenData(
          (subscribed) => TextButton(
            onPressed: () => ref
                .read(subscriptionSNP.notifier)
                .changeSubscriptionState(channel.id),
            // TODO change styles here when the user is subbed or unsubbed
            child: Text((subscribed) ? 'Subscribed' : 'Subscribe'),
          ),
        )
        .valueOrNull;

    return GestureDetector(
      // * this is for detecting empty space - like spacer, so that
      // it works with it
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.min);

        if (pushedScreens!.screenTypeAndId.screenId == channel.id) return;

        final notifier = ref.read(pushedScreensCNP.notifier);
        notifier.pushScreen(
          index: index,
          screenTypeAndId: ScreenTypeAndId(
            screenType: ScreenType.channel,
            screenId: channel.id,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const CircleAvatar(
              foregroundImage: AssetImage(Helper.defaultPfp),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      channel.snippet.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      channel.statistics?.subscriberCount != null
                          ? Helper.numberFormatter(
                              channel.statistics!.subscriberCount,
                            )
                          : 'unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            subscribed ?? const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _CommentsSection extends ConsumerWidget {
  final BaseInfo<Comment> commentsInfo;

  const _CommentsSection(this.commentsInfo);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (commentsInfo.disabled != null) {
      return const Center(
        child: Text('comments are private'),
      );
    } else if (commentsInfo.failure != null) {
      return Center(
        child: Text(commentsInfo.failure!.message!),
      );
    } else if (commentsInfo.data.isEmpty) {
      return const Center(
        child: Text('comments are empty'),
      );
    }

    final topLevelCommentSnippet =
        commentsInfo.data.first.snippet.topLevelComment.topLevelCommentSnippet;
    final totalReplyCount = commentsInfo.data.first.snippet.totalReplyCount;

    return GestureDetector(
      onTap: () => Helper.handleCommentsPressed(
        context: context,
        commentsInfo: commentsInfo,
      ),
      child: CommentCard(
        author: topLevelCommentSnippet.authorDisplayName,
        text: topLevelCommentSnippet.textDisplay,
        likeCount: topLevelCommentSnippet.likeCount,
        replyCount: totalReplyCount,
        publishedTime: topLevelCommentSnippet.updatedAt,
      ),
    );
  }
}
