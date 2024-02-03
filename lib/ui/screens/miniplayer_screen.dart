// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_video_screen.dart';
import 'package:youtube_clone/ui/widgets/video_info_tile.dart';
import 'package:youtube_clone/ui/widgets/video_tile.dart';

class MiniplayerScreen extends ConsumerStatefulWidget {
  final double height;
  final double percentage;
  final Video video;

  const MiniplayerScreen({
    super.key,
    required this.height,
    required this.percentage,
    required this.video,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MiniplayerScreenState();
}

class _MiniplayerScreenState extends ConsumerState<MiniplayerScreen> {
  static const double playerMinHeight = 60;
  late double playerMaxHeight;
  late final ScrollController scrollController;
  late final PodPlayerController playerController;

  // this'll be used for loading details
  Future<void> loadDetails() async {
    final videoDetailsNotifier = ref.read(videoDetailsNotifierProvider.notifier);
    await videoDetailsNotifier.loadDetails(
      videoId: widget.video.id,
      channelId: widget.video.snippet.channelId,
    );

    // final subsNotifier =
    //     ref.read(subscriptionNotifierProvider(widget.video.snippet.channelId).notifier);

    // await Future.wait([
    //   videoDetailsNotifier.loadDetails(
    //     videoId: widget.video.id,
    //     channelId: widget.video.snippet.channelId,
    //   ),
    //   subsNotifier.getSubscriptionState(),
    // ]);
  }

  Future<void> reloadData() async {
    // may as well show snack bar here
    if (!await Helper.hasInternet()) return;

    ref.invalidate(videoDetailsNotifierProvider);
    ref.invalidate(subscriptionNotifierProvider);

    final videoDetailsNotifier = ref.read(videoDetailsNotifierProvider.notifier);
    // final subsNotifier =
    //     ref.read(subscriptionNotifierProvider(widget.video.snippet.channelId).notifier);

    await Future.wait([
      videoDetailsNotifier.loadDetails(
        videoId: widget.video.id,
        channelId: widget.video.snippet.channelId,
      ),
      playerController.changeVideo(
        playVideoFrom: PlayVideoFrom.youtube(
          'https://youtu.be/${widget.video.id}',
        ),
      ),
      // subsNotifier.getSubscriptionState(),
    ]);

    playerController.play();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    playerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.video.id}'),
    )..initialise();
    // without this, the details are stuck in the loading state
    Future.microtask(loadDetails);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerMaxHeight = MediaQuery.of(context).size.height;
  }

  @override
  void didUpdateWidget(covariant MiniplayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.video.id != oldWidget.video.id) {
      Future.microtask(
        () => Future.wait([
          playerController.changeVideo(
            playVideoFrom: PlayVideoFrom.youtube(
              'https://youtu.be/${widget.video.id}',
            ),
          ),
          loadDetails(),
        ]),
      );
      log('video has been changed and didUpdateWidget() got called again');
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    scrollController.dispose();
    ref.invalidate(videoDetailsNotifierProvider);
    ref.invalidate(subscriptionNotifierProvider);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoDetails = ref.watch(videoDetailsNotifierProvider);
    final selectedVideo = ref.watch(selectedVideoSP)!;
    final value = Helper.percentageFromValueInRange(
      min: playerMinHeight,
      max: playerMaxHeight,
      value: widget.height,
    );

    // this is used to avoid overflow when player in full screen
    return value > 2
        ? const SizedBox()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: Helper.valueFromPercentageInRange(
                            // this should probably be a percentage of the screen
                            // TODO try to change this to screen percentage
                            min: 106,
                            max: MediaQuery.of(context).size.width,
                            percentage: widget.percentage,
                          ),
                          child: GestureDetector(
                            onTap: () => ref
                                .read(miniPlayerControllerP)
                                .animateToHeight(state: PanelState.max),
                            child: PodVideoPlayer(
                              controller: playerController,
                              matchVideoAspectRatioToFrame: true,
                              alwaysShowProgressBar: true,
                              overlayBuilder:
                                  value < 0.96 ? (options) => const SizedBox.shrink() : null,
                            ),
                          ),
                        ),
                      ),
                      value > 0.96
                          ? IconButton(
                              onPressed: () => ref
                                  .read(miniPlayerControllerP)
                                  .animateToHeight(state: PanelState.min),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: widget.percentage <= 1 ? 1 - widget.percentage : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.video.snippet.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    widget.video.snippet.channelTitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (playerController.isVideoPlaying)
                            Expanded(
                              child: IconButton(
                                onPressed: () => setState(
                                  () => playerController.pause(),
                                ),
                                icon: const Icon(Icons.pause_sharp),
                              ),
                            )
                          else if (!playerController.isVideoPlaying)
                            Expanded(
                              child: IconButton(
                                onPressed: () => setState(
                                  () => playerController.play(),
                                ),
                                icon: const Icon(Icons.play_arrow_sharp),
                              ),
                            )
                          else if (playerController.currentVideoPosition ==
                              playerController.totalVideoLength)
                            Expanded(
                              child: IconButton(
                                onPressed: () => setState(
                                  () => playerController.play(),
                                ),
                                icon: const Icon(Icons.replay_sharp),
                              ),
                            ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(miniPlayerControllerP)
                                    .animateToHeight(state: PanelState.dismiss);
                              },
                              icon: const Icon(Icons.close_sharp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Opacity(
                  opacity: widget.percentage <= 1 ? widget.percentage : 0,
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: videoDetails.when(
                      loading: () => 1,
                      data: (videoInfo) {
                        final videos = videoInfo.videoInfo!.data
                            .where((video) => video.id != selectedVideo.id)
                            .toList();

                        return videos.length + 1;
                      },
                      error: (failure, stackTrace) => 1,
                    ),
                    itemBuilder: (context, index) => videoDetails.when(
                      loading: () => const LoadingVideoScreen(),
                      data: (videoInfo) {
                        final videos = videoInfo.videoInfo!.data
                            .where((video) => video.id != selectedVideo.id)
                            .toList();

                        if (index == 0) {
                          return VideoInfoTile(
                            video: selectedVideo,
                            channel: videoInfo.channelInfo,
                            commentsInfo: videoInfo.comments,
                          );
                        }

                        // if the selected video is the same as a video
                        // on the list of liked videos under the VIT, then
                        // just hide that video
                        if (videos[index - 1].id == selectedVideo.id) {
                          return const SizedBox.shrink();
                        }

                        return VideoTile(
                          video: videos[index - 1],
                          isInView: false,
                          maximize: false,
                          elementAt: index - 1,
                          onTap: () {
                            Future.wait([
                              playerController.changeVideo(
                                playVideoFrom: PlayVideoFrom.youtube(
                                  'https://youtu.be/${videos[index - 1].id}',
                                ),
                              ),
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              ),
                            ]);
                          },
                        );
                      },
                      error: (failure, _) => FailureTile(
                        failure: failure as YoutubeFailure,
                        onTap: reloadData,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
