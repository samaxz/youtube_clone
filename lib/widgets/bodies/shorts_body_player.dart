import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/theme_notifier.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_list_notifier.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/notifiers/shorts_details_notifier.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_shorts_tab.dart';
import 'package:youtube_demo/widgets/custom_inkwell.dart';
import 'package:youtube_demo/widgets/failure_tile.dart';
import 'package:youtube_demo/widgets/shimmers/loading_shorts_body.dart';
import 'package:visibility_detector/visibility_detector.dart';

final playShortSP = StateProvider<Map<int, bool>>(
  (ref) => {
    0: false,
    1: true,
    3: false,
    4: false,
  },
);

class ShortsBodyPlayer extends ConsumerStatefulWidget {
  final Video short;
  final AuthState authState;
  // * this comes from the passed in nav bar tab index
  final int index;
  // * this comes from the state provider
  final int? currentScreenIndex;
  final bool shouldAutoPlay;
  final void Function(PodPlayerController controller)? onLoad;
  final int? currentIndex;

  const ShortsBodyPlayer({
    super.key,
    required this.short,
    required this.authState,
    required this.index,
    this.currentScreenIndex,
    this.shouldAutoPlay = false,
    this.currentIndex,
    this.onLoad,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShortsBodyContentPlayerState();
}

class _ShortsBodyContentPlayerState extends ConsumerState<ShortsBodyPlayer> {
  late final PodPlayerController playerController;

  Future<void> goToChannel() async {
    final notifier = ref.read(pushedScreensCNP.notifier);
    notifier.pushScreen(
      index: widget.index,
      screenTypeAndId: ScreenTypeAndId(
        screenType: ScreenType.channel,
        screenId: widget.short.snippet.channelId,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    playerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://youtu.be/${widget.short.id}',
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
        isLooping: true,
      ),
    );
    final shortsDetailsNot = ref.read(shortsDetailsNotifierProvider.notifier);
    shortsDetailsNot.getDetails(
      index: widget.index,
      videoId: widget.short.id,
      channelId: widget.short.snippet.channelId,
    );
    if (!playerController.isInitialised) {
      playerController.initialise().then((value) {
        playerController.play();
      });
    } else {
      playerController.play();
    }
  }

  @override
  void dispose() {
    if (!mounted) {
      playerController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shortsDetails =
        ref.watch(shortsDetailsNotifierProvider)[widget.index]!;
    final index = ref.watch(currentScreenIndexSP);
    final rating = ref.watch(ratingSNP);
    final playShort = ref.watch(playShortSP)[widget.index];
    final subscribed = ref.watch(subscriptionSNP);
    final darkTheme = ref.watch(themeNP);

    ref.listen(playShortSP, (_, state) {
      if (playerController.isInitialised) {
        if (state[widget.index]! == true && index == widget.index) {
          playerController.play();
        } else {
          playerController.pause();
        }
      }
    });

    // * this works in conjunction with play short sp
    ref.listen(currentScreenIndexSP, (_, state) {
      if (playerController.isInitialised) {
        if (widget.index == state && playShort! == true) {
          playerController.play();
        } else {
          playerController.pause();
        }
      }
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            if (playerController.isVideoPlaying) {
              playerController.pause();
            } else {
              playerController.play();
            }
          },
          child: Container(
            color: Colors.red,
            child: PodVideoPlayer(
              controller: playerController,
              onVideoError: () => Center(
                child: TextButton(
                  onPressed: () => playerController
                      .changeVideo(
                        playVideoFrom: PlayVideoFrom.youtube(
                          'https://youtu.be/${widget.short.id}',
                        ),
                      )
                      .then((value) => playerController.play()),
                  child: const Text('Error happened, try again'),
                ),
              ),
              videoAspectRatio: 5 / 9.51,
              frameAspectRatio: 5 / 9.51,
              overlayBuilder: (options) => Align(
                alignment: Alignment.bottomCenter,
                child: options.podProgresssBar,
              ),
            ),
          ),
        ),
        shortsDetails.when(
          data: (data) => Stack(
            children: [
              Positioned(
                top: 310,
                right: 0,
                child: Column(
                  children: [
                    CustomInkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            rating.value!.maybeWhen(
                              orElse: () => Icons.thumb_up_alt_outlined,
                              liked: () => Icons.thumb_up_alt,
                            ),
                            size: 28,
                            color: rating.value!.maybeWhen(
                              orElse: () => Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.short.statistics?.likeCount != null
                                ? '${Helper.numberFormatter(widget.short.statistics!.likeCount!)} '
                                : 'Like',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.read(ratingSNP.notifier).like(widget.short.id);
                      },
                    ),
                    CustomInkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            rating.value!.maybeWhen(
                              orElse: () => Icons.thumb_down_alt_outlined,
                              disliked: () => Icons.thumb_down_alt,
                            ),
                            size: 28,
                            color: rating.value!.maybeWhen(
                              orElse: () => Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Dislike',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.read(ratingSNP.notifier).dislike(widget.short.id);
                      },
                    ),
                    CustomInkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.comment,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.short.statistics?.commentCount != null
                                ? '${Helper.numberFormatter(widget.short.statistics!.commentCount!)} '
                                : 'Comments',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Helper.handleCommentsPressed(
                          context: context,
                          commentsInfo: data.comments,
                        );
                      },
                    ),
                    CustomInkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.share,
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Remix',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    CustomInkWell(
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sync,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Remix',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: goToChannel,
                          onLongPress: goToChannel,
                          child: Image.asset(
                            Helper.defaultPfp,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: goToChannel,
                          onLongPress: goToChannel,
                          child: Text(
                            '@${widget.short.snippet.channelTitle}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => ref
                              .read(subscriptionSNP.notifier)
                              .changeSubscriptionState(
                                widget.short.snippet.channelId,
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: (subscribed.value!)
                                  ? Colors.black54
                                  : Colors.red.shade700,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              (subscribed.value!) ? 'subscribed' : 'subscribe',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      child: Text(
                        widget.short.snippet.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => Center(
            child: FailureTile(
              failure: error as YoutubeFailure,
              onTap: () {
                final notifier =
                    ref.read(shortsDetailsNotifierProvider.notifier);
                notifier.getDetails(
                  videoId: widget.short.id,
                  channelId: widget.short.snippet.channelId,
                  index: index,
                );
                playerController
                    .changeVideo(
                      playVideoFrom: PlayVideoFrom.youtube(
                        'https://youtu.be/${widget.short.id}',
                      ),
                    )
                    .then((value) => playerController.play());
              },
            ),
          ),
          loading: () => const LoadingShortsBody(),
        ),
      ],
    );
  }
}
