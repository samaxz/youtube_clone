import 'dart:collection';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/notifiers/visibility_notifier.dart';
import 'package:youtube_demo/widgets/hidden_video_card.dart';
import 'package:youtube_demo/widgets/my_miniplayer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_demo/screens/nav_screen.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/common/providers.dart';

// this is the widget that is displayed inside listview builder in home screen body
// and a few other screens
class VideoCard extends ConsumerStatefulWidget {
  final Video video;
  final bool isInView;
  // * to know whether user is from video screen or not - true everywhere,
  // except for the video screen
  final bool maximize;
  final int elementAt;
  final bool hidden;
  final void Function(String videoId)? onHideVideo;
  final VoidCallback? onTap;

  const VideoCard({
    super.key,
    required this.video,
    required this.isInView,
    this.maximize = true,
    this.hidden = false,
    this.elementAt = 0,
    this.onHideVideo,
    this.onTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoCardState();
}

class _VideoCardState extends ConsumerState<VideoCard>
    with AutomaticKeepAliveClientMixin {
  late final PodPlayerController playerController;

  late bool isMute;
  bool showCaptions = true;

  bool disposed = false;

  void goToChannel() {
    final index = ref.watch(currentScreenIndexSP);

    final notifier = ref.read(pushedScreensCNP.notifier);
    notifier.pushScreen(
      index: index,
      screenTypeAndId: ScreenTypeAndId(
        screenType: ScreenType.channel,
        screenId: widget.video.snippet.channelId,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    playerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://youtu.be/${widget.video.id}',
      ),
      podPlayerConfig: const PodPlayerConfig(isLooping: true),
    );

    isMute = playerController.isMute;
    showCaptions = playerController.videoPlayerValue?.caption != Caption.none;
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isInView != oldWidget.isInView) {
      if (widget.isInView) {
        if (!playerController.isInitialised) {
          playerController.initialise().then((value) {
            playerController.play();
          });
        } else {
          playerController.play();
        }
      } else {
        playerController.pause();
      }
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final hidden = ref.watch(visibilitySNP).elementAtOrNull(widget.elementAt);
    final darkTheme = ref.watch(themeNP);

    return hidden != null && hidden
        ? HiddenVideoCard(index: widget.elementAt)
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Helper.handleVideoCardPressed(
                ref: ref,
                video: widget.video,
              );

              if (widget.maximize) {
                ref
                    .read(miniPlayerControllerP)
                    .animateToHeight(state: PanelState.max);
              }

              widget.onTap?.call();
            },
            child: Column(
              children: [
                if (widget.isInView) ...[
                  PodVideoPlayer(
                    controller: playerController,
                    alwaysShowProgressBar: true,
                    matchVideoAspectRatioToFrame: true,
                    overlayBuilder: (options) => Stack(
                      children: [
                        Positioned(
                          top: 10,
                          right: 8,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            splashRadius: 0.1,
                            color: Colors.white,
                            onPressed: () {
                              setState(() => isMute = !isMute);
                              isMute
                                  ? playerController.mute()
                                  : playerController.unMute();
                            },
                            icon: isMute
                                ? Icon(MdiIcons.volumeOff)
                                : Icon(MdiIcons.volumeHigh),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          right: 8,
                          child: IconButton(
                            color: Colors.white,
                            // TODO add caption support thru yt explode
                            onPressed: () {},
                            // if the subtitles are turned on and they are present for
                            // the video, then this is displayed as working subtitles
                            icon: !showCaptions &&
                                    widget.video.contentDetails?.caption !=
                                        null &&
                                    widget.video.contentDetails?.caption ==
                                        'true'
                                ? Icon(MdiIcons.closedCaption)
                                : Icon(MdiIcons.closedCaptionOutline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Stack(
                    children: [
                      widget.video.snippet.thumbnails.high == null
                          ? Image.asset(Helper.defaultThumbnail)
                          : CachedNetworkImage(
                              imageUrl: widget.video.snippet.thumbnails.high!,
                              errorWidget: (context, url, error) =>
                                  Image.asset(Helper.defaultThumbnail),
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Colors.black,
                          child: Text(
                            // TODO make this better
                            widget.video.contentDetails?.duration != null
                                ? Helper.formatDuration(
                                    widget.video.contentDetails!.duration!,
                                  ).toString()
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: goToChannel,
                        onLongPress: goToChannel,
                        child: const CircleAvatar(
                          foregroundImage: AssetImage(Helper.defaultPfp),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.video.snippet.title,
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
                                '${widget.video.snippet.channelTitle} • ${widget.video.statistics?.viewCount != null ? Helper.numberFormatter(widget.video.statistics!.viewCount!) : 'unknown'} views • ${timeago.format(widget.video.snippet.publishedAt)}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14,
                                      color: darkTheme
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        // TODO use this across all the other widgets and add this
                        // to helper
                        onTap: () => ref.read(showOptionsSP.notifier).update(
                              (state) => VideoOptions(
                                videoId: widget.video.id,
                                screenActions: ScreenActions.videoCard,
                                videoCardIndex: widget.elementAt,
                              ),
                            ),
                        child: const Icon(
                          Icons.more_vert,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
