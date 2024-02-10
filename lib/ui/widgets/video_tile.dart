import 'dart:collection';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';

import 'package:youtube_clone/logic/notifiers/visibility_notifier.dart';
import 'package:youtube_clone/ui/screens/channel_screen.dart';
import 'package:youtube_clone/ui/screens/shorts_screen.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/hidden_video_card.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_clone/data/info/common_classes.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/video_info_tile.dart';

// this is the widget that is displayed inside listview builder in home screen body
// and a few other screens
class VideoTile extends ConsumerStatefulWidget {
  final Video video;
  final bool isInView;
  // to know whether user is from video screen or not - true everywhere,
  // except for the video screen
  final bool maximize;
  // this is for calling handleMoreVertPressed() on suggested
  // video under video info tile on miniplayer screen
  // element's index in the list
  final int videoIndex;
  final bool hidden;
  // final void Function(String videoId)? onHideVideo;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const VideoTile({
    super.key,
    required this.video,
    required this.isInView,
    this.maximize = true,
    this.hidden = false,
    required this.videoIndex,
    // this.onHideVideo,
    this.onTap,
    this.onLongPress,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoTileState();
}

class _VideoTileState extends ConsumerState<VideoTile> with AutomaticKeepAliveClientMixin {
  late final PodPlayerController playerController;
  late bool isMute;
  bool showCaptions = true;
  bool disposed = false;

  void goToChannel() {
    final screenIndex = ref.read(currentScreenIndexSP);
    final notifier = ref.read(screensManagerProvider(screenIndex).notifier);
    notifier.pushScreen(
      CustomScreen.channel(
        channelId: widget.video.snippet.channelId,
        screenIndex: screenIndex,
      ),
    );
  }

  // TODO use this across all the other widgets and add this to helper
  // this method is used for showing the pop-up globally - above the mp
  // however, i also can use the helper's method for it under the mp - in the
  // suggestions
  void handleMoreVertPressed() {
    // this is for global video tile, although it can also be used
    // inside miniplayer
    final notifier = ref.read(showOptionsSP.notifier);
    notifier.update(
      (state) => VideoOptions(
        VideoAction(
          playerController: playerController,
          videoId: widget.video.id,
          videoIndex: widget.videoIndex,
        ),
      ),
    );
    // this is for video suggestions under the mp
    // Helper.showVideoActions(
    //   context: context,
    //   ref: ref,
    //   videoAction: VideoAction(
    //     playerController: playerController,
    //     videoId: widget.video.id,
    //     videoIndex: widget.videoIndex,
    //   ),
    // );
    // log('video tile index is: ${widget.elementAt}');
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
  void didUpdateWidget(covariant VideoTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isInView == oldWidget.isInView) return;

    if (widget.isInView) {
      // this is bs, it's not how the widget should work
      // Future.delayed(const Duration(seconds: 1), () {
      //   if (!playerController.isInitialised) {
      //     playerController.initialise().then((value) {
      //       playerController.play();
      //     });
      //   } else {
      //     playerController.play();
      //   }
      //   // if (playerController.isInitialised) playerController.play();
      // });
      if (!playerController.isInitialised) {
        playerController.initialise().then((value) {
          playerController.play();
        });
      } else {
        playerController.play();
      }
      // if (playerController.isInitialised) playerController.play();
    } else {
      playerController.pause();
    }
    // if (!widget.isInView) playerController.pause();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final hidden = ref.watch(visibilitySNP).elementAt(widget.videoIndex);

    return hidden
        ? HiddenVideoCard(index: widget.videoIndex)
        : Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Helper.handleVideoCardPressed(
                  ref: ref,
                  video: widget.video,
                );

                if (widget.maximize) {
                  ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.max);
                }

                widget.onTap?.call();

                // log('user clicked on video tile');
              },
              onLongPress: () {
                handleMoreVertPressed();

                // i don't need this
                widget.onLongPress?.call();
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
                                isMute ? playerController.mute() : playerController.unMute();
                              },
                              icon: isMute ? Icon(MdiIcons.volumeOff) : Icon(MdiIcons.volumeHigh),
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
                                      widget.video.contentDetails?.caption != null &&
                                      widget.video.contentDetails?.caption == 'true'
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
                              widget.video.contentDetails?.duration != null
                                  ? Helper.formatDuration(widget.video.contentDetails!.duration!)
                                  : '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                              // .copyWith(color: Theme.of(context).colorScheme.onSurface),
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
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Flexible(
                                child: Text(
                                  '${widget.video.snippet.channelTitle} • ${widget.video.statistics?.viewCount != null ? Helper.numberFormatter(widget.video.statistics!.viewCount!) : 'unknown'} views • ${timeago.format(widget.video.snippet.publishedAt)}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: handleMoreVertPressed,
                          child: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
