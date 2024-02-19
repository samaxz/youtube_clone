import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/channel/subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_details_notifier.dart';
import 'package:youtube_clone/logic/notifiers/mp_subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_rating_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/custom_inkwell.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';
import 'package:youtube_clone/ui/widgets/short_player_controller_provider.dart';

class ShortBodyPlayer extends ConsumerStatefulWidget {
  final Video short;
  // this comes from the passed in nav bar tab index
  final int screenIndex;
  // the index of the current short on channel's shorts tab
  // this is the latest index, which i don't necessarily need
  // all the time
  final int shortIndex;
  // last viewed short id
  final String lastId;
  // this comes from the state provider
  final int? currentScreenIndex;
  final bool shouldAutoPlay;
  final PodPlayerController? playerController;
  final void Function(PodPlayerController controller)? onLoad;

  const ShortBodyPlayer({
    super.key,
    required this.short,
    required this.screenIndex,
    required this.shortIndex,
    required this.lastId,
    this.currentScreenIndex,
    this.playerController,
    this.shouldAutoPlay = false,
    this.onLoad,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortBodyPlayerState();
}

class _ShortBodyPlayerState extends ConsumerState<ShortBodyPlayer>
    with AutomaticKeepAliveClientMixin {
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
    // **** this plays the sound and the percentage bar is moving
    // but the image is still
    // UPD both of these were done with ..initialize() at the end inside
    // provider's build()
    // final playerController = ref.read(
    //   shortPlayerControllerProvider(
    //     shortId: widget.short.id,
    //     shortIndex: widget.shortIndex,
    //   ),
    // );
    // // should i also add a listener or something
    // await playerController.initialise();
    // playerController.play();
    // *********
    // final playerController = ref.read(
    //   shortPlayerControllerProvider(
    //     shortId: widget.short.id,
    //     shortIndex: widget.shortIndex,
    //   ).notifier,
    // );
    // // should i also add a listener or something
    // await playerController.initialize();
    // playerController.play();
    // *********
    ref.read(shortIdSP.notifier).update((state) => widget.short.id);
    final shortsNotifier = ref.read(shortsDetailsNotifierProvider(widget.short.id).notifier);
    await shortsNotifier.getDetails(
      videoId: widget.short.id,
      channelId: widget.short.snippet.channelId,
    );
    final subsNotifier = ref.read(subscriptionNotifierProvider(
      channelId: widget.short.snippet.channelId,
      screenIndex: widget.screenIndex,
    ).notifier);
    await subsNotifier.getSubscriptionState();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getDetails);
    // log('_ShortsBodyPlayerState`s initState()');
  }

  @override
  void didUpdateWidget(covariant ShortBodyPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // log('new short index: ${widget.shortIndex}');
    // log('old short index: ${oldWidget.shortIndex}');
    log('didUpdateWidget() inside shorts body player`s state');
    // ** this kinda works
    // ref
    //     .watch(
    //       shortPlayerControllerProvider(
    //         shortId: widget.short.id,
    //         shortIndex: widget.shortIndex,
    //       ),
    //     )
    //     .play();
    // this is the current controller
    // i should also probably watch
    final playerController = ref.watch(
      shortPlayerControllerProvider(
        // shortId: widget.short.id,
        shortId: widget.lastId,
        // shortIndex: widget.shortIndex,
      ),
    );
    final screenIndex = ref.read(currentScreenIndexSP);
    final screensManager = ref.read(screensManagerProvider(widget.screenIndex)).last;
    final isShort = screensManager.screenTypeAndId.screenType == ScreenType.short;
    // if (widget.screenIndex != widget.currentScreenIndex) {
    if (widget.screenIndex != screenIndex || !isShort) {
      // ||
      // widget.shortIndex != oldWidget.shortIndex) {
      // widget.short.id != oldWidget.short.id) {
      playerController.pause();
    } else {
      playerController.play();
    }
  }

  @override
  void dispose() {
    // if (widget.shortIndex! > 0) playerController.dispose();
    // if (playerController.isInitialised) playerController.dispose();
    log('_ShortsBodyPlayerState`s playerController disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // log('_ShortsBodyPlayerState`s build()');
    final shortsDetails = ref.watch(shortsDetailsNotifierProvider(widget.short.id)).last;
    final rating = ref.watch(shortsRatingNotifierProvider(widget.short.id)).last;
    final subscribed = ref
        .watch(
          subscriptionNotifierProvider(
            channelId: widget.short.snippet.channelId,
            screenIndex: widget.screenIndex,
          ),
        )
        .last;
    // current player controller (duh)
    final playerController = ref.watch(
      shortPlayerControllerProvider(
        shortId: widget.short.id,
        // shortIndex: widget.shortIndex,
      ),
    );
    // TODO use current short id notifier here
    // ref.listen(shortIndexSP, (previous, next) {
    //   log('prev index: $previous');
    //   log('next index: $next');
    // });
    // ref.listen(videoIdSP, (previous, next) {
    //   log('prev id: $previous');
    //   log('next id: $next');
    //   ref
    //       .read(
    //         shortPlayerControllerProvider(
    //           shortIndex: widget.shortIndex,
    //           shortId: next,
    //         ).notifier,
    //       )
    //       .play();
    // });
    // this isn't working
    // ref.listen(shortSP, (previous, next) {
    //   if (previous != null) {
    //     // ref
    //     //     .watch(
    //     //       shortPlayerControllerProvider(
    //     //         shortId: previous.shortId,
    //     //         shortIndex: previous.shortIndex,
    //     //       ),
    //     //     )
    //     //     .pause();
    //   }
    //   ref
    //       .read(
    //         shortPlayerControllerProvider(
    //           shortIndex: next.shortIndex,
    //           shortId: next.shortId,
    //         ),
    //       )
    //       .play();
    // });
    // strange, i can't even listen to it
    // ref.listen(
    //   shortPlayerControllerProvider(
    //     // shortIndex: widget.shortIndex,
    //     shortId: widget.short.id,
    //   ),
    //   (previous, next) {
    //     log('previous: $previous');
    //     log('next: $next');
    //     isPlaying = next.isVideoPlaying;
    //     // next.play();
    //     // ref
    //     //     .read(
    //     //       shortPlayerControllerProvider(
    //     //         shortId: widget.short.id,
    //     //         // shortIndex: widget.shortIndex,
    //     //       ),
    //     //     )
    //     //     .play();
    //     // log('thasdf;lajf;alskdjf');
    //   },
    // );
    ref.listen(
      screensManagerProvider(widget.screenIndex),
      (_, state) {
        if (state.last.screenTypeAndId.screenType != ScreenType.short) {
          playerController.pause();
        }
      },
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            // log('is video playing: ${playerController.isVideoPlaying}');
            if (playerController.isVideoPlaying) {
              playerController.pause();
            } else {
              playerController.play();
            }
          },
          child: FittedBox(
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
                        .then(
                          (value) => playerController.play(),
                        ),
                    child: const Text('Error happened, try again'),
                  ),
                ),
                matchVideoAspectRatioToFrame: true,
                matchFrameAspectRatioToVideo: true,
                overlayBuilder: (options) => Padding(
                  padding: playerController.isVideoPlaying
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(bottom: 4),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: options.podProgresssBar,
                  ),
                ),
                // podProgressBarConfig: PodProgressBarConfig(
                //   // this isn't working
                //   circleHandlerRadius: playerController.isVideoPlaying ? 3 : 8,
                // ),
                alwaysShowProgressBar: false,
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
                      onTap: () => Helper.showComments(
                        context: context,
                        commentsInfo: data.comments,
                      ),
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
                      onTap: () => Helper.share(context: context, id: widget.short.id),
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
                      onTap: () {
                        // TODO change this in the future
                        ref.read(unauthAttemptSP.notifier).update((state) => true);
                      },
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
                              miniplayerSubscriptionNotifierProvider(widget.short.snippet.channelId)
                                  .notifier,
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
                    .then(
                      (value) => playerController.play(),
                    ),
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
