import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/videos_notifier.dart';
import 'package:youtube_clone/logic/notifiers/visibility_notifier.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';
import 'package:youtube_clone/ui/widgets/video_tile.dart';

class HomeScreenBody extends ConsumerStatefulWidget {
  const HomeScreenBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends ConsumerState<HomeScreenBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> init() async {
    final videosNotifier = ref.read(videosNotifierProvider.notifier);
    await videosNotifier.getVideos();

    final visibilityNotifier = ref.read(visibilitySNP.notifier);
    visibilityNotifier.toggleSelection(20);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(init);
  }

  int lastIndex = 0;
  bool canLoadNextPage = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final videos = ref.watch(videosNotifierProvider);
    final selectedVideo = ref.watch(selectedVideoSP);
    final screenIndex = ref.watch(currentScreenIndexSP);
    final screensManager = ref.watch(screensManagerProvider(screenIndex));
    final lastPageEmpty = screensManager.last.screenTypeAndId.screenType == ScreenType.initial;
    final shouldAutoPlay = selectedVideo == null && screenIndex == 0 && lastPageEmpty;

    ref.listen(
      videosNotifierProvider,
      (_, state) {
        state.maybeWhen(
          orElse: () => canLoadNextPage = false,
          loaded: (videoInfo) => canLoadNextPage = videoInfo.nextPageAvailable,
        );
      },
    );

    // log('can load next page: $canLoadNextPage');

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;

        if (canLoadNextPage && metrics.pixels >= limit) {
          canLoadNextPage = false;

          // log('method for pagination should now be called');

          Future.microtask(ref.read(videosNotifierProvider.notifier).getVideos).then(
            (value) => ref.read(visibilitySNP.notifier).toggleSelection(lastIndex),
          );
        }

        return false;
      },
      child: RefreshIndicator(
        // only this works
        onRefresh: () => ref.refresh(videosNotifierProvider.notifier).getVideos(),
        child: InViewNotifierList(
          shrinkWrap: true,
          isInViewPortCondition: (deltaTop, deltaBottom, vpHeight) =>
              deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight),
          itemCount: videos.when(
            loading: (videosInfo) => videosInfo.data.length + 1,
            loaded: (videosInfo) => videosInfo.data.length,
            error: (videosInfo, _) => videosInfo.data.length + 1,
          ),
          builder: (context, index) {
            // TODO update the visibility NP here and not this local var
            // TODO prolly move this down into successful states
            lastIndex = index;

            return videos.when(
              loading: (videoInfo) {
                if (index < videoInfo.data.length) {
                  // TODO put this inside a separate widget
                  return InViewNotifierWidget(
                    id: videoInfo.data[index].id,
                    builder: (context, isInView, child) => VideoTile(
                      video: videoInfo.data[index],
                      isInView: isInView && shouldAutoPlay,
                      videoIndex: index,
                    ),
                  );
                } else {
                  return const LoadingVideosScreen();
                }
              },
              loaded: (videoInfo) {
                if (videoInfo.data.isEmpty) {
                  return const Center(
                    child: Text('oops, looks like it`s empty'),
                  );
                }

                return InViewNotifierWidget(
                  id: videoInfo.data[index].id,
                  builder: (context, isInView, child) => VideoTile(
                    videoIndex: index,
                    video: videoInfo.data[index],
                    isInView: isInView && shouldAutoPlay,
                    // TODO remove this
                    // isInView: false,
                  ),
                );
              },
              error: (videoInfo, failure) {
                if (index < videoInfo.data.length) {
                  return InViewNotifierWidget(
                    id: videoInfo.data[index].id,
                    builder: (context, isInView, child) => VideoTile(
                      video: videoInfo.data[index],
                      isInView: isInView && shouldAutoPlay,
                      videoIndex: index,
                    ),
                  );
                } else {
                  return FailureTile(
                    failure: failure,
                    onTap: () {
                      final notifier = ref.read(videosNotifierProvider.notifier);
                      notifier.getVideos();
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
