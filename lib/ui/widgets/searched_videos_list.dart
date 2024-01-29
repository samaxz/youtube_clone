import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/searched_items_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/search_playlist.dart';
import 'package:youtube_clone/ui/widgets/search_sub.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';
import 'package:youtube_clone/ui/widgets/video_tile.dart';

part 'searched_videos_list.g.dart';

// this could be a state provider
// what is this?
@riverpod
class SearchIndex extends _$SearchIndex {
  // i could've made it null, but didn't want to deal with it later on
  // TODO change this to be something different - make it a family
  // modifier that is responsible for setting the search index where
  // it's used, not just a single index
  @override
  int build() => 0;

  void setSearchIndex(int index) => state = index;
}

class SearchItem extends ConsumerWidget {
  final String kind;
  final Item item;
  final bool isInViewToo;

  const SearchItem({
    super.key,
    required this.kind,
    required this.item,
    required this.isInViewToo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchIndex = ref.watch(searchIndexProvider);

    return kind == 'youtube#video'
        ? InViewNotifierWidget(
            id: item.id,
            builder: (context, isInView, child) => VideoTile(
              video: item as Video,
              isInView: isInView && isInViewToo,
            ),
          )
        : kind == 'youtube#playlist'
            ? SearchPlaylist(
                playlist: item as Playlist,
                index: searchIndex,
              )
            : SearchSub(
                sub: item as Channel,
                channelId: item.id,
              );
  }
}

class SearchedVideosList extends ConsumerStatefulWidget {
  final String query;
  final int index;

  const SearchedVideosList({
    super.key,
    required this.query,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedVideosListState();
}

class _SearchedVideosListState extends ConsumerState<SearchedVideosList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(searchItemsNotifierProvider.notifier)
          .searchItems(query: widget.query, index: widget.index),
    );
  }

  bool canLoadNextPage = false;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(searchItemsNotifierProvider)[widget.index]!.last;
    final selectedVideo = ref.watch(selectedVideoSP);
    final screenIndex = ref.watch(currentScreenIndexSP);
    ref.listen(searchItemsNotifierProvider, (_, state) {
      state[widget.index]!.last.when(
            loading: (searchItemsInfo) => canLoadNextPage = false,
            loaded: (searchItemsInfo) => canLoadNextPage = true,
            error: (searchItemsInfo, failure) => canLoadNextPage = false,
          );
    });

    return RefreshIndicator(
      onRefresh: () => ref
          .refresh(searchItemsNotifierProvider.notifier)
          .searchItems(query: widget.query, index: widget.index),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;
          if (canLoadNextPage && metrics.pixels >= limit) {
            canLoadNextPage = false;

            Future.microtask(
              () => ref
                  .read(searchItemsNotifierProvider.notifier)
                  .searchItems(query: widget.query, index: widget.index),
            );
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
                  isInViewToo: selectedVideo == null && screenIndex == widget.index,
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
                isInViewToo: selectedVideo == null && screenIndex == widget.index,
              );
            },
            error: (searchItemsInfo, failure) {
              if (index < searchItemsInfo.data.length) {
                return SearchItem(
                  kind: searchItemsInfo.data[index].kind,
                  item: searchItemsInfo.data[index],
                  isInViewToo: selectedVideo == null && screenIndex == widget.index,
                );
              } else {
                return FailureTile(
                  failure: failure,
                  onTap: () => ref
                      .read(searchItemsNotifierProvider.notifier)
                      .searchItems(query: widget.query, index: widget.index),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
