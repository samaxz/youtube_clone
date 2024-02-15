import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_details_notifier.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/custom_inkwell.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';

class ShortsBodyPlayer extends ConsumerStatefulWidget {
  final Video short;
  // this comes from the passed in nav bar tab index
  final int screenIndex;
  // this comes from the state provider
  final int? currentScreenIndex;
  final bool shouldAutoPlay;
  final void Function(PodPlayerController controller)? onLoad;
  // the index of the current short on channel's shorts tab
  final int? shortIndex;

  const ShortsBodyPlayer({
    super.key,
    required this.short,
    required this.screenIndex,
    this.currentScreenIndex,
    this.shouldAutoPlay = false,
    this.onLoad,
    this.shortIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortsBodyPlayerState();
}

class _ShortsBodyPlayerState extends ConsumerState<ShortsBodyPlayer>
    with AutomaticKeepAliveClientMixin {
  late final PodPlayerController playerController;

  @override
  bool get wantKeepAlive => true;

  void goToChannel() {
    final notifier = ref.read(screensManagerProvider(widget.screenIndex).notifier);
    notifier.pushScreen(
      CustomScreen.channel(
        channelId: widget.short.snippet.channelId,
        screenIndex: widget.screenIndex,
      ),
    );
  }

  Future<void> getDetails() async {
    final shortsNotifier = ref.read(shortsDetailsNotifierProvider(widget.screenIndex).notifier);
    await shortsNotifier.getDetails(
      videoId: widget.short.id,
      channelId: widget.short.snippet.channelId,
    );

    final subsNotifier =
        ref.read(subscriptionNotifierProvider(widget.short.snippet.channelId).notifier);
    await subsNotifier.getSubscriptionState();
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
    // TODO remove this, as it'll always initialize the video
    if (!playerController.isInitialised) {
      playerController.initialise().then((value) {
        playerController.play();
      });
    } else {
      playerController.play();
    }
    Future.microtask(getDetails);
    // log('_ShortsBodyPlayerState`s initState()');
  }

  @override
  void didUpdateWidget(covariant ShortsBodyPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.screenIndex == oldWidget.screenIndex) return;

    // if (widget.shortIndex == oldWidget.shortIndex) {
    //   log('short index is the same');
    // } else if (widget.shortIndex != oldWidget.shortIndex) {
    //   log('short index is different');
    // }

    // playerController.pause();
    // if (!playerController.isInitialised) {
    //   playerController.initialise().then((value) {
    //     playerController.play();
    //   });
    // } else {
    //   playerController.play();
    // }
  }

  @override
  void dispose() {
    playerController.dispose();
    // log('_ShortsBodyPlayerState`s playerController disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final shortsDetails = ref.watch(shortsDetailsNotifierProvider(widget.screenIndex)).last;
    final screenIndex = ref.watch(currentScreenIndexSP);
    final rating = ref.watch(ratingNotifierProvider(widget.short.id));
    // TODO change this in the future
    const subscribed = AsyncLoading();
    final currentScreen = ref.watch(screensManagerProvider(widget.screenIndex)).last;

    ref.listen(screensManagerProvider(widget.screenIndex), (_, state) {
      if (!playerController.isInitialised) return;

      if (state.last.screenTypeAndId.screenType == ScreenType.short &&
          widget.screenIndex == screenIndex) {
        playerController.play();
      } else {
        playerController.pause();
      }
    });

    ref.listen(currentScreenIndexSP, (_, state) {
      if (!playerController.isInitialised) return;

      if (widget.screenIndex == state &&
          currentScreen.screenTypeAndId.screenType == ScreenType.short) {
        playerController.play();
      } else {
        log('or is this stopping the video?');
        playerController.pause();
      }
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        // TODO remove positioned
        Positioned(
          // top: -10,
          child: GestureDetector(
            onTap: () {
              // log('is video playing: ${playerController.isVideoPlaying}');

              if (playerController.isVideoPlaying) {
                playerController.pause();
              } else {
                playerController.play();
              }
            },
            child: FittedBox(
              // fit: BoxFit.fitHeight,
              // fit: BoxFit.fill,
              fit: BoxFit.cover,
              child: SizedBox(
                // without this, the player's aspect ratio throws
                width: MediaQuery.of(context).size.width,
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
                  matchVideoAspectRatioToFrame: true,
                  matchFrameAspectRatioToVideo: true,
                  overlayBuilder: (options) => Align(
                    alignment: Alignment.bottomCenter,
                    // alignment: options.podProgresssBar.alignment,
                    child: options.podProgresssBar,
                  ),
                  // overlayBuilder: (options) => Positioned(
                  //   bottom: 5,
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: options.podProgresssBar,
                  //   ),
                  // ),
                ),
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
                            rating.valueOrNull?.maybeWhen(
                              orElse: () => Icons.thumb_up_alt_outlined,
                              liked: () => Icons.thumb_up_alt,
                            ),
                            size: 28,
                            color: rating.valueOrNull?.maybeWhen(
                              orElse: () => Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.short.statistics?.likeCount != null
                                ? '${Helper.formatNumber(widget.short.statistics!.likeCount!)} '
                                : 'Like',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.read(ratingNotifierProvider(widget.short.id).notifier).like();
                      },
                    ),
                    CustomInkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            rating.valueOrNull?.maybeWhen(
                              orElse: () => Icons.thumb_down_alt_outlined,
                              disliked: () => Icons.thumb_down_alt,
                            ),
                            size: 28,
                            color: rating.valueOrNull?.maybeWhen(
                              orElse: () => Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Dislike',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.read(ratingNotifierProvider(widget.short.id).notifier).dislike();
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
                                ? '${Helper.formatNumber(widget.short.statistics!.commentCount!)} '
                                : 'Comments',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        Helper.showComments(
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
                            'Share',
                            style: TextStyle(color: Colors.white),
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
                            style: TextStyle(color: Colors.white),
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
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            final notifier = ref.read(
                              subscriptionNotifierProvider(widget.short.snippet.channelId).notifier,
                            );
                            notifier.changeSubscriptionState();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: (subscribed.value != null && subscribed.value!)
                                  ? Colors.black54
                                  : Colors.red.shade700,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              (subscribed.value != null && subscribed.value!)
                                  ? 'subscribed'
                                  : 'subscribe',
                              style: const TextStyle(color: Colors.white),
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
                        style: const TextStyle(color: Colors.white),
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
              onTap: () => Future.wait([
                playerController
                    .changeVideo(
                      playVideoFrom: PlayVideoFrom.youtube(
                        'https://youtu.be/${widget.short.id}',
                      ),
                    )
                    .then((value) => playerController.play()),
                getDetails(),
              ]),
            ),
          ),
          loading: () => const LoadingShortsBody(),
        ),
      ],
    );
  }
}
