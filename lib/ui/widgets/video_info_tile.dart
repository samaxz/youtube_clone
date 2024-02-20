import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/mp_subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/custom_inkwell.dart';

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
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ];
    });
    return TextSpan(
      children: [...spans],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Theme.of(context).cardColor,
          // this removes the expansion tile's white line at the bottom
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: const EdgeInsets.symmetric(horizontal: 8),
              iconColor: Theme.of(context).iconTheme.color,
              collapsedIconColor: Theme.of(context).iconTheme.color,
              onExpansionChanged: (value) => setState(() => expanded = !expanded),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.video.snippet.title,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        widget.video.statistics?.viewCount != null
                            ? '${Helper.formatNumber(widget.video.statistics!.viewCount!)} views  •'
                            : 'unknown views  •',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        timeago.format(widget.video.snippet.publishedAt),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: expanded ? Icon(MdiIcons.menuUp) : Icon(MdiIcons.menuDown),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9, right: 9, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: linkify(context, widget.video.snippet.description),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 0),
        _ActionsRow(widget.video),
        const Divider(height: 0),
        _AuthorInfo(widget.channel),
        const Divider(height: 0),
        _CommentsSection(widget.commentsInfo),
        const Divider(height: 0),
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
              orElse: () => Icon(
                Icons.thumb_up_off_alt_outlined,
                size: 28,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              liked: () => Icon(
                Icons.thumb_up,
                size: 28,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ))
        .valueOrNull;

    final dislike = rating
        .whenData((value) => value.maybeWhen(
              orElse: () => Icon(
                Icons.thumb_down_off_alt_outlined,
                size: 28,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              liked: () => Icon(
                Icons.thumb_down,
                size: 28,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ))
        .valueOrNull;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // this is the like button
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              like ?? const CircularProgressIndicator(),
              const SizedBox(height: 5),
              Text(
                video.statistics?.likeCount != null
                    ? '${Helper.formatNumber(video.statistics!.likeCount!)} '
                    : 'Like',
              ),
            ],
          ),
          onTap: () => ref.read(ratingNotifierProvider(video.id).notifier).like(),
          onLongPress: () => ref.read(ratingNotifierProvider(video.id).notifier).like(),
        ),
        // this is the dislike button
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dislike ?? const CircularProgressIndicator(),
              const SizedBox(height: 5),
              const Text('Dislike'),
            ],
          ),
          onTap: () => ref.read(ratingNotifierProvider(video.id).notifier).dislike(),
          onLongPress: () => ref.read(ratingNotifierProvider(video.id).notifier).dislike(),
        ),
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.reply_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 5),
              const Text('Share'),
            ],
          ),
          onTap: () => Helper.share(context: context, id: video.id),
          onLongPress: () => Helper.share(context: context, id: video.id),
        ),
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.download_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 5),
              const Text('Download'),
            ],
          ),
          onTap: () {
            Helper.downloadVideo(
              context: context,
              ref: ref,
              videoId: video.id,
            );
          },
          onLongPress: () {
            Helper.downloadVideo(
              context: context,
              ref: ref,
              videoId: video.id,
            );
          },
        ),
        CustomInkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.library_add_outlined,
                size: 30,
                // secondary is ok
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 5),
              const Text('Save'),
            ],
          ),
          onTap: () {
            // TODO use a helper method here that will use notifier under the hood
            ref.read(unauthAttemptSP.notifier).update((state) => true);
          },
          onLongPress: () {
            // TODO use this in the future
            // Helper.handleSavePressed(context);
            ref.read(unauthAttemptSP.notifier).update((state) => true);
          },
        ),
      ],
    );
  }
}

class _AuthorInfo extends ConsumerStatefulWidget {
  final Channel channel;

  const _AuthorInfo(this.channel);

  @override
  ConsumerState createState() => _AuthorInfoState();
}

class _AuthorInfoState extends ConsumerState<_AuthorInfo> {
  void pushScreen() {
    final screenIndex = ref.read(currentScreenIndexSP);
    final notifier = ref.read(screensManagerProvider(screenIndex).notifier);
    notifier.pushScreen(
      CustomScreen.channel(
        channelId: widget.channel.id,
        screenIndex: screenIndex,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(miniplayerSubscriptionNotifierProvider(widget.channel.id).notifier);
    Future.microtask(
      () => notifier.getSubscriptionState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(miniplayerSubscriptionNotifierProvider(widget.channel.id));

    final subscribed = subscription
        .whenData(
          (subscribed) => TextButton(
            onPressed: () {
              final notifier =
                  ref.read(miniplayerSubscriptionNotifierProvider(widget.channel.id).notifier);
              notifier.changeSubscriptionState();
            },
            onLongPress: () {
              final notifier =
                  ref.read(miniplayerSubscriptionNotifierProvider(widget.channel.id).notifier);
              notifier.changeSubscriptionState();
            },
            // TODO change styles here when the user is subbed or unsubbed
            child: Text(subscribed ? 'SUBSCRIBED' : 'SUBSCRIBE'),
          ),
        )
        .valueOrNull;

    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: pushScreen,
        onLongPress: pushScreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
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
                        widget.channel.snippet.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.channel.statistics?.subscriberCount != null
                            ? Helper.formatNumber(widget.channel.statistics!.subscriberCount)
                            : 'unknown',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              subscribed ?? const CircularProgressIndicator(),
            ],
          ),
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
      return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text('comments are disabled'),
            ),
          ),
        ),
      );
      // TODO remove this case, cause it'll never happen
      // i also don't want it to happen
    } else if (commentsInfo.failure != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(commentsInfo.failure!.message!),
        ),
      );
    } else if (commentsInfo.data.isEmpty) {
      return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text('comments are empty'),
            ),
          ),
        ),
      );
    }

    final snippet = commentsInfo.data.first.snippet;
    final topLevelCommentSnippet = snippet.topLevelComment.topLevelCommentSnippet;

    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => Helper.showComments(
          context: context,
          commentsInfo: commentsInfo,
        ),
        onLongPress: () => Helper.showComments(
          context: context,
          commentsInfo: commentsInfo,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).buttonTheme.colorScheme?.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Text(
                  topLevelCommentSnippet.textDisplay.split('\n')[0],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
