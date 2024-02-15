import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/logic/notifiers/playlist/search_playlist_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_video_tile.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';

// this widget is used for displaying search playlists
class SearchPlaylistScreen extends ConsumerStatefulWidget {
  final Playlist playlist;
  final int screenIndex;

  const SearchPlaylistScreen({
    super.key,
    required this.playlist,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPlaylistScreenState();
}

class _SearchPlaylistScreenState extends ConsumerState<SearchPlaylistScreen> {
  void playAll() {
    final videos = ref.read(searchPlaylistNotifierProvider(widget.screenIndex)).last;
    Helper.pressVideoCard(
      ref: ref,
      newVideo: videos.baseInfo.data.first,
    );
  }

  void shuffle() {
    final videos = ref.read(searchPlaylistNotifierProvider(widget.screenIndex)).last;
    final randomNum = math.Random().nextInt(videos.baseInfo.data.length);
    Helper.pressVideoCard(
      ref: ref,
      newVideo: videos.baseInfo.data[randomNum],
    );
  }

  Future<void> loadPlaylistVideos({bool isReloading = false}) async {
    final notifier = ref.read(searchPlaylistNotifierProvider(widget.screenIndex).notifier);
    await notifier.getPlaylistVideos(widget.playlist.id, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadPlaylistVideos);
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(searchPlaylistNotifierProvider(widget.screenIndex)).last;
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
                        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
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
                      InkWell(
                        enableFeedback: false,
                        radius: 20,
                        customBorder: const CircleBorder(),
                        onTap: () => Helper.share(
                          context: context,
                          id: widget.playlist.id,
                          isVideoId: false,
                        ),
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.transparent,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(MdiIcons.shareOutline),
                          ),
                        ),
                      ),
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).buttonTheme.colorScheme?.onSurface,
                            ),
                          ),
                          onPressed: playAll,
                          onLongPress: playAll,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MdiIcons.play,
                                color: Theme.of(context).colorScheme.secondaryContainer,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Play all',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 165,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.secondaryContainer,
                            ),
                          ),
                          onPressed: shuffle,
                          onLongPress: shuffle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MdiIcons.shuffleVariant,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Shuffle',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
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
              color: Theme.of(context).buttonTheme.colorScheme?.onSurface,
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
