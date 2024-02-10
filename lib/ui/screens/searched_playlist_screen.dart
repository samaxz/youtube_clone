import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/logic/notifiers/playlist/channel_playlist_notifier.dart';
import 'package:youtube_clone/logic/notifiers/playlist/searched_playlist_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_video_tile.dart';

// this widget is used for displaying searched playlists
class SearchedPlaylistScreen extends ConsumerStatefulWidget {
  final Playlist playlist;
  final int screenIndex;

  const SearchedPlaylistScreen({
    super.key,
    required this.playlist,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedPlaylistScreenState();
}

class _SearchedPlaylistScreenState extends ConsumerState<SearchedPlaylistScreen> {
  void randomPressButton() {
    final videos = ref.read(channelPlaylistNotifierProvider).last;

    Helper.handleVideoCardPressed(
      ref: ref,
      video: videos.baseInfo.data[Random().nextInt(videos.baseInfo.data.length)],
    );
  }

  void firstPressButton() {
    final videos = ref.read(channelPlaylistNotifierProvider).last;

    Helper.handleVideoCardPressed(
      ref: ref,
      video: videos.baseInfo.data.first,
    );
  }

  Future<void> loadPlaylistVideos({bool isReloading = false}) async {
    final notifier = ref.read(searchedPlaylistNotifierProvider.notifier);
    await notifier.getPlaylistVideos(widget.playlist.id, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadPlaylistVideos);
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(channelPlaylistNotifierProvider).last;

    return videos.when(
      loaded: (videos) => CustomScrollView(
        slivers: [
          ChannelSliverAppbar(index: widget.screenIndex),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: 80,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: widget.playlist.snippet.thumbnail.high != null
                        ? CachedNetworkImageProvider(
                            widget.playlist.snippet.thumbnail.high!,
                          )
                        : Image.asset(Helper.defaultThumbnail).image,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            // i can extract it to a separate widget
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.playlist.snippet.title),
                          const SizedBox(height: 5),
                          Text(widget.playlist.snippet.channelTitle ?? ''),
                          Text(
                            widget.playlist.itemCount != null
                                ? '${widget.playlist.itemCount!} videos'
                                : 'unknown',
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        enableFeedback: false,
                        radius: 20,
                        customBorder: const CircleBorder(),
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved to library'),
                          ),
                        ),
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.transparent,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(MdiIcons.plusBoxMultipleOutline),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(MdiIcons.shareOutline),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 165,
                        child: TextButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: firstPressButton,
                          onLongPress: firstPressButton,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MdiIcons.play,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Play all',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 165,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.grey.shade800),
                          ),
                          onPressed: randomPressButton,
                          onLongPress: randomPressButton,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MdiIcons.shuffleVariant,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Shuffle',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverList.builder(
              itemCount: videos.data.length,
              itemBuilder: (_, index) => ChannelVideoTile(
                video: videos.data[index],
                isPlaylistVideo: true,
              ),
            ),
          ),
        ],
      ),
      error: (_, failure) {
        final code = failure.failureData.code;

        return Center(
          child: Column(
            children: [
              // not sure these codes are accurate, but, we'll see
              if (code == 403) ...[
                const Text('too many requests, try again later'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => loadPlaylistVideos(isReloading: true),
                  child: const Text('tap to retry'),
                ),
              ] else if (code == 404) ...[
                const Text('oops, looks like it`s empty'),
              ] else ...[
                const Text('unknown error, try again later'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => loadPlaylistVideos(isReloading: true),
                  child: const Text('tap to retry'),
                ),
              ],
            ],
          ),
        );
      },
      loading: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(
              Icons.chevron_left,
              size: 31,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
