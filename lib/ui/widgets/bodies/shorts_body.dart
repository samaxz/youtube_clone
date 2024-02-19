import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/bodies/short_body_player.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';
import 'package:youtube_clone/ui/widgets/short_player_controller_provider.dart';

// this is used for displaying the "Shorts" text and
// subscriptions button when the short is paused
final pauseSP = StateProvider((ref) => false);

// this is used for identifying the current index of the
// short being played from the shorts list
final shortIndexVN = ValueNotifier(0);

final shortIndexSP = StateProvider((ref) => 0);

final shortIdSP = StateProvider((ref) => '');

class IdAndIndex {
  final String shortId;
  final int shortIndex;

  const IdAndIndex({
    required this.shortId,
    required this.shortIndex,
  });

  const IdAndIndex.initial()
      : shortId = '',
        shortIndex = 0;
}

final shortSP = StateProvider((ref) => const IdAndIndex.initial());

// this is a universal shorts body class, not dependent on
// the shorts screen class
class ShortsBody extends ConsumerStatefulWidget {
  final BaseInfoState<Video> shorts;
  // final BaseInfo<Video> shorts;
  final VoidCallback onLoadMoreShorts;
  final VoidCallback onError;
  final int screenIndex;
  final bool backButtonOn;
  final int shortIndex;

  const ShortsBody({
    super.key,
    required this.shorts,
    required this.onLoadMoreShorts,
    required this.onError,
    required this.screenIndex,
    this.backButtonOn = true,
    this.shortIndex = 0,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortsBodyState();
}

class _ShortsBodyState extends ConsumerState<ShortsBody> with AutomaticKeepAliveClientMixin {
  final pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => pageController.jumpToPage(widget.shortIndex),
    );
  }

  @override
  void dispose() {
    if (!mounted) {
      pageController.dispose();
      // log('_ShortsBodyState`s pageController disposed');
    }
    super.dispose();
  }

  // int lastIndex = 0;
  // int shortIndex = 0;

  // int prevIndex = 0;
  // int currentIndex = 0;

  // this is robust, i don't need it
  // IdAndIndex oldIdAndIndex = const IdAndIndex.initial();
  // IdAndIndex newIdAndIndex = const IdAndIndex.initial();

  String prevId = '';
  String newId = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ref.listen(shortIndexSP, (previous, next) {
    //   // log('prev index: $previous');
    //   // log('next index: $next');
    //   if (previous != null) prevIndex = previous;
    //   currentIndex = next;
    // });
    // **** this works
    // ref.listen(shortSP, (previous, next) {
    //   if (previous != null) {
    //     oldIdAndIndex = previous;
    //     // ref
    //     //     .watch(
    //     //       shortPlayerControllerProvider(
    //     //         shortId: previous.shortId,
    //     //         shortIndex: previous.shortIndex,
    //     //       ),
    //     //     )
    //     //     .pause();
    //   }
    //   newIdAndIndex = next;
    // });
    // *******
    ref.listen(shortIdSP, (previous, next) {
      if (previous != null) {
        prevId = previous;
      }
      newId = next;
    });
    final currentScreenIndex = ref.watch(currentScreenIndexSP);
    final shouldDisplaySubscription = ref.watch(pauseSP);
    // final shortPlayerController = ref.watch(shortPlayerControllerProvider(widget.));
    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (index) {
            // log('current short index: $index');
            // this works
            // showModalBottomSheet(
            //   context: context,
            //   builder: (context) => const Center(
            //     child: Text('huyna'),
            //   ),
            // );
            // TODO remove these (first 2, at least)
            // shortIndex = index;
            // shortIndexVN.value = index;
            ref.read(shortIndexSP.notifier).update((state) => index);
            ref.read(shortIdSP.notifier).update((state) => widget.shorts.baseInfo.data[index].id);
            final not = ref.read(shortSP.notifier);
            not.update(
              (state) => IdAndIndex(
                shortId: widget.shorts.baseInfo.data[index].id,
                shortIndex: index,
              ),
            );
            if (index > 0) {
              // final playerController = ref.watch(
              //   shortPlayerControllerProvider(
              //     shortId: widget.shorts.baseInfo.data[index].id,
              //     shortIndex: index,
              //   ),
              // );
              // // should i also add a listener or something
              // Future.microtask(() async {
              //   if (!playerController.isInitialised) {
              //     await playerController.initialise();
              //   }
              //   playerController.play();
              // });
              // *******
              // final playerController = ref.read(
              //   shortPlayerControllerProvider(
              //     shortId: widget.shorts.baseInfo.data[index].id,
              //     shortIndex: index,
              //   ).notifier,
              // );
              // // should i also add a listener or something
              // Future.microtask(() async {
              //   // if (!playerController.isInitialised) {
              //   //   await playerController.initialise();
              //   // }
              //   await playerController.initialize();
              //   playerController.play();
              // });
              // log('init: ${playerController.isInitialised}');
            }
            // final playerController = ref.watch(
            //   shortPlayerControllerProvider(
            //     shortId: widget.shorts.baseInfo.data[index].id,
            //     // shortIndex: index,
            //   ),
            // );
            // // this stops the player on previous page
            // playerController.pause();
            // log('player is playing video: ${playerController.isVideoPlaying}');
            // with this, the video isn't playing, but sound is
            // Future.microtask(
            //   () async {
            //     if (!playerController.isInitialised) {
            //       await playerController.initialise();
            //     }
            //     if (!playerController.isVideoPlaying) {
            //       playerController.play();
            //     }
            //   },
            // );
            // **** this works (although, it's not perfect)
            final oldPlayerController = ref.watch(
              // shortPlayerControllerProvider(shortId: oldIdAndIndex.shortId),
              shortPlayerControllerProvider(shortId: prevId),
            );
            // this stops previous short
            oldPlayerController.pause();
            final newPlayerController = ref.watch(
              // shortPlayerControllerProvider(shortId: newIdAndIndex.shortId),
              shortPlayerControllerProvider(shortId: newId),
            );
            // this plays the next short
            // i could also add listener here (or even remove the condition)
            if (newPlayerController.isInitialised) {
              newPlayerController.play();
            }
            // TODO add else here to initialize and then play
            // the short if it's not already initialized

            // if (!newPlayerController.isVideoPlaying) {
            //   newPlayerController.play();
            // }
            // ********
            // final controller = ref.read(
            //   shortPlayerControllerProvider(shortId: oldIdAndIndex.shortId).notifier,
            // );
            // controller.play();
            if (index == widget.shorts.baseInfo.data.length - 1) {
              widget.onLoadMoreShorts.call();
            }
          },
          scrollDirection: Axis.vertical,
          controller: pageController,
          // **********
          itemCount: widget.shorts.when(
            // + 1 makes it load another video for some reason
            loading: (baseInfo) => baseInfo.data.length,
            loaded: (baseInfo) => baseInfo.data.length,
            // do i even need + 1 here?
            error: (baseInfo, _) => baseInfo.data.length + 1,
          ),
          itemBuilder: (context, index) => widget.shorts.when(
            loading: (baseInfo) {
              if (index < baseInfo.data.length) {
                return ShortBodyPlayer(
                  short: baseInfo.data[index],
                  screenIndex: widget.screenIndex,
                  shortIndex: index,
                  lastId: newId,
                );
              } else {
                return const Center(
                  child: LoadingShortsBody(),
                );
              }
            },
            loaded: (baseInfo) => ShortBodyPlayer(
              short: baseInfo.data[index],
              screenIndex: widget.screenIndex,
              shortIndex: index,
              lastId: newId,
            ),
            error: (baseInfo, failure) {
              if (index < baseInfo.data.length) {
                return ShortBodyPlayer(
                  short: baseInfo.data[index],
                  screenIndex: widget.screenIndex,
                  shortIndex: index,
                  lastId: newId,
                );
              } else {
                return Center(
                  child: FailureTile(
                    failure: failure,
                    onTap: widget.onError,
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (shouldDisplaySubscription && widget.backButtonOn) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Shorts',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ] else if (widget.backButtonOn) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ] else if (shouldDisplaySubscription) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Shorts',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
              ],
              IconButton(
                onPressed: () => Helper.pressSearch(
                  context: context,
                  ref: ref,
                  screenIndex: widget.screenIndex,
                ),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.clear),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'this section is a work in progress, but you get a snack bar',
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('snack bar!'),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('show the snack bar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                // TODO change this
                onPressed: () => Helper.showOtherActions(context),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
