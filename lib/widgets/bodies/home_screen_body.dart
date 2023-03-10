import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/notifiers.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/notifiers/rating_notifier.dart';
import 'package:youtube_demo/services/notifiers/videos_notifier.dart';
import 'package:youtube_demo/services/notifiers/visibility_notifier.dart';
import 'package:youtube_demo/widgets/failure_tile.dart';
import 'package:youtube_demo/widgets/shimmers/loading_videos_screen.dart';
import 'package:youtube_demo/widgets/video_card.dart';

class HomeScreenBody extends ConsumerStatefulWidget {
  const HomeScreenBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends ConsumerState<HomeScreenBody>
    with AutomaticKeepAliveClientMixin {
  bool canLoadNextPage = false;

  int lastIndex = 0;

  late final ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  Future<void> initHomeScreenBody() async {
    final videosNot = ref.read(videosNotifierProvider.notifier);
    final visibilityNot = ref.read(visibilitySNP.notifier);
    videosNot.getVideos().then((value) => visibilityNot.toggleSelection(20));
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    Future.microtask(initHomeScreenBody);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final videos = ref.watch(videosNotifierProvider);
    final selectedVideo = ref.watch(selectedVideoSP);
    final currentScreenIndex = ref.watch(currentScreenIndexSP);
    final lastPageEmpty = ref.watch(
      pushedScreensCNP.select(
        (value) =>
            value.screens[0]!.last.screenTypeAndId.screenType ==
            ScreenType.initial,
      ),
    );
    final categoryId = ref.watch(selectedCategoryIdSP);
    final shouldAutoPlay =
        selectedVideo == null && currentScreenIndex == 0 && lastPageEmpty;

    ref.listen(
      videosNotifierProvider,
      (_, state) {
        state.when(
          loading: (_) => canLoadNextPage = false,
          loaded: (videoInfo) => canLoadNextPage = videoInfo.nextPageAvailable,
          error: (_, __) => canLoadNextPage = false,
        );
      },
    );

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;
        if (canLoadNextPage && metrics.pixels >= limit) {
          canLoadNextPage = false;

          Future.microtask(
            () => ref
                .read(videosNotifierProvider.notifier)
                .getVideos(categoryId: categoryId),
          );

          Future.microtask(
            () => ref.read(visibilitySNP.notifier).toggleSelection(lastIndex),
          );
        }
        metrics.maxScrollExtent;
        metrics.viewportDimension;
        metrics.pixels;

        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => ref
            .refresh(videosNotifierProvider.notifier)
            .getVideos(categoryId: categoryId),
        child: InViewNotifierList(
          shrinkWrap: true,
          isInViewPortCondition: (deltaTop, deltaBottom, vpHeight) =>
              deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight),
          itemCount: videos.when(
            loading: (videoInfo) => videoInfo.data.length + 1,
            loaded: (videoInfo) => videoInfo.data.length,
            error: (videoInfo, _) => videoInfo.data.length + 1,
          ),
          builder: (context, index) {
            lastIndex = index;
            return videos.when(
              loading: (videoInfo) {
                if (index < videoInfo.data.length) {
                  // TODO put this inside a separate widget
                  return InViewNotifierWidget(
                    id: videoInfo.data[index].id,
                    builder: (context, isInView, child) => VideoCard(
                      video: videoInfo.data[index],
                      isInView: isInView && shouldAutoPlay,
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
                  builder: (context, isInView, child) => VideoCard(
                    elementAt: index,
                    video: videoInfo.data[index],
                    isInView: isInView && shouldAutoPlay,
                    onTap: () {
                      ref
                          .read(ratingSNP.notifier)
                          .getVideoRating(videoId: videoInfo.data[index].id);
                      ref
                          .read(ratingNotifierProvider.notifier)
                          .getVideoRating(videoId: videoInfo.data[index].id);
                    },
                  ),
                );
              },
              error: (videoInfo, failure) {
                if (index < videoInfo.data.length) {
                  return InViewNotifierWidget(
                    id: videoInfo.data[index].id,
                    builder: (context, isInView, child) {
                      return VideoCard(
                        video: videoInfo.data[index],
                        isInView: isInView && shouldAutoPlay,
                      );
                    },
                  );
                } else {
                  return FailureTile(
                    failure: failure,
                    onTap: () {
                      final not = ref.read(videosNotifierProvider.notifier);
                      not.getVideos(categoryId: categoryId);
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
