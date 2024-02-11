import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/searched_items_notifier.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/search_playlist.dart';
import 'package:youtube_clone/ui/widgets/search_sub.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';
import 'package:youtube_clone/ui/widgets/video_tile.dart';

class SearchItem extends ConsumerWidget {
  final String kind;
  final Item item;
  final bool isInViewToo;
  final int videoIndex;
  final int screenIndex;

  const SearchItem({
    super.key,
    required this.kind,
    required this.item,
    required this.isInViewToo,
    required this.videoIndex,
    required this.screenIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return kind == 'youtube#video'
        ? InViewNotifierWidget(
            id: item.id,
            builder: (context, isInView, child) => VideoTile(
              video: item as Video,
              isInView: isInView && isInViewToo,
              videoIndex: videoIndex,
            ),
          )
        : kind == 'youtube#playlist'
            ? SearchPlaylist(
                playlist: item as Playlist,
                // screenIndex: searchIndex,
                screenIndex: screenIndex,
              )
            : SearchSub(
                sub: item as Channel,
                channelId: item.id,
                screenIndex: screenIndex,
              );
  }
}

// can turn this into consumer widget
class SearchedItemsList extends ConsumerStatefulWidget {
  final String query;
  final int screenIndex;

  const SearchedItemsList({
    super.key,
    required this.query,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedItemsListState();
}

class _SearchedItemsListState extends ConsumerState<SearchedItemsList> {
  Future<void> searchItems() async {
    final notifier = ref.read(searchItemsNotifierProvider(widget.screenIndex).notifier);
    await notifier.searchItems(
      query: widget.query,
      screenIndex: widget.screenIndex,
    );
  }

  bool canLoadNextPage = false;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(searchItemsNotifierProvider(widget.screenIndex)).last;
    final selectedVideo = ref.watch(selectedVideoSP);
    final screenIndex = ref.watch(currentScreenIndexSP);
    final isInViewToo = selectedVideo == null && screenIndex == widget.screenIndex;

    ref.listen(
      searchItemsNotifierProvider(widget.screenIndex),
      (_, state) {
        state.last.maybeWhen(
          orElse: () => canLoadNextPage = false,
          loaded: (_) => canLoadNextPage = true,
        );
      },
    );

    return RefreshIndicator(
      // not gonna set isReloading to true
      onRefresh: () => searchItems(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;
          if (canLoadNextPage && metrics.pixels >= limit) {
            canLoadNextPage = false;

            Future.microtask(searchItems);
          }

          return false;
        },
        child: InViewNotifierList(
          isInViewPortCondition: (deltaTop, deltaBottom, vpHeight) =>
              deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight),
          shrinkWrap: true,
          itemCount: items.when(
            loading: (baseInfo) => baseInfo.data.length + 1,
            loaded: (baseInfo) => baseInfo.data.length,
            error: (baseInfo, _) => baseInfo.data.length + 1,
          ),
          builder: (context, index) => items.when(
            loading: (searchItemsInfo) {
              if (index < searchItemsInfo.data.length) {
                return SearchItem(
                  kind: searchItemsInfo.data[index].kind,
                  item: searchItemsInfo.data[index],
                  isInViewToo: isInViewToo,
                  videoIndex: index,
                  screenIndex: widget.screenIndex,
                );
              } else {
                return const LoadingVideosScreen();
              }
            },
            loaded: (searchItemsInfo) {
              if (searchItemsInfo.data.isEmpty) {
                return const Center(
                  child: Text('oops, looks like it`s empty'),
                );
              }

              return SearchItem(
                kind: searchItemsInfo.data[index].kind,
                item: searchItemsInfo.data[index],
                isInViewToo: isInViewToo,
                videoIndex: index,
                screenIndex: widget.screenIndex,
              );
            },
            error: (searchItemsInfo, failure) {
              if (index < searchItemsInfo.data.length) {
                return SearchItem(
                  kind: searchItemsInfo.data[index].kind,
                  item: searchItemsInfo.data[index],
                  isInViewToo: isInViewToo,
                  videoIndex: index,
                  screenIndex: widget.screenIndex,
                );
              } else {
                return FailureTile(
                  failure: failure,
                  onTap: () {
                    final not = ref.read(searchItemsNotifierProvider(widget.screenIndex).notifier);
                    not.removeLast();
                    not.searchItems(query: widget.query, screenIndex: widget.screenIndex);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
