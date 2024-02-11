import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_clone/data/models/playlist_model_new.dart';
import 'package:youtube_clone/logic/notifiers/playlist/channel_playlist_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_video_tile.dart';

// used inside channel's playlists tab
class ChannelPlaylistScreen extends ConsumerStatefulWidget {
  final Playlist playlist;
  final int screenIndex;

  const ChannelPlaylistScreen({
    super.key,
    required this.playlist,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelPlaylistScreenState();
}

class _ChannelPlaylistScreenState extends ConsumerState<ChannelPlaylistScreen> {
  Future<void> loadPlaylistVideos({bool isReloading = false}) async {
    final notifier = ref.read(channelPlaylistNotifierProvider.notifier);
    await notifier.getPlaylistVideos(widget.playlist.id!);
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
                    image: widget.playlist.thumbnail != null
                        ? CachedNetworkImageProvider(widget.playlist.thumbnail!)
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
                          Text(widget.playlist.title ?? ''),
                          const SizedBox(height: 5),
                          Text(widget.playlist.author?.channelName ?? ''),
                          Text('${widget.playlist.videoCount} videos'),
                        ],
                      ),
                      const Spacer(),
                      Icon(MdiIcons.plusBoxMultipleOutline),
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
                          onPressed: () {},
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
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {},
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
              itemBuilder: (context, index) {
                return ChannelVideoTile(
                  video: videos.data[index],
                  isPlaylistVideo: true,
                );
              },
            ),
          ),
        ],
      ),
      error: (error, stackTrace) => Center(
        child: Text('error: $error'),
      ),
      loading: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
