import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/channel/subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/mp_subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_details_notifier.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_rating_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
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
  // UPD i don't need it
  // TODO remove this
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
    final shortsNotifier = ref.read(shortsDetailsNotifierProvider(widget.short.id).notifier);
    await shortsNotifier.getDetails(
      videoId: widget.short.id,
      channelId: widget.short.snippet.channelId,
    );
    final subsNotifier = ref.read(
      subscriptionNotifierProvider(
        channelId: widget.short.snippet.channelId,
        screenIndex: widget.screenIndex,
      ).notifier,
    );
    await subsNotifier.getSubscriptionState();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getDetails);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    // this is for playing the newest loaded short for the first time
    final playerController = ref.watch(
      shortPlayerControllerProvider(widget.short.id),
    );
    final screenIndex = ref.watch(currentScreenIndexSP);
    final customScreen = ref.watch(screensManagerProvider(widget.screenIndex)).last;
    // these 2 listeners work together
    ref.listen(
      screensManagerProvider(widget.screenIndex),
      (_, state) {
        if (state.last.screenTypeAndId.screenType == ScreenType.short &&
            widget.screenIndex == screenIndex) {
          playerController.play();
          // i should probably add other checks here too
        } else {
          playerController.pause();
        }
      },
    );
    ref.listen(currentScreenIndexSP, (_, state) {
      if (state == widget.screenIndex &&
          customScreen.screenTypeAndId.screenType == ScreenType.short) {
        playerController.play();
      } else {
        playerController.pause();
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
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              // without this, the player's aspect ratio throws
              width: MediaQuery.of(context).size.width,
              child: PodVideoPlayer(
                controller: playerController,
                onVideoError: () => Center(
                  child: TextButton(
                    onPressed: () {
                      playerController
                          .changeVideo(
                            playVideoFrom: PlayVideoFrom.youtube(
                              'https://youtu.be/${widget.short.id}',
                            ),
                          )
                          .then(
                            (value) => playerController.play(),
                          );
                    },
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
                // hide the built-in progress bar, since i'm already using my own
                // inside overlayBuilder
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
