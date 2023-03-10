import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_demo/data/models/playlist_model_new.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/widgets/channel/channel_sliver_appbar.dart';
import 'package:youtube_demo/widgets/channel/channel_video_card.dart';

// * used only inside channel's playlists with unofficial api
// * could also be called ChannelPlaylistScreen
class PlaylistScreenNew extends ConsumerStatefulWidget {
  final Playlist playlist;
  final int index;

  const PlaylistScreenNew({
    super.key,
    required this.playlist,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreenNew> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(playlistVideosNotifierProvider.notifier)
          .getPlaylistVideos(widget.playlist.id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(playlistVideosNotifierProvider);

    return videos.when(
      loaded: (videos) => CustomScrollView(
        slivers: [
          ChannelSliverAppbar(index: widget.index),
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
            // * i can extract it to a separate widget
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
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
                return ChannelVideoCard(
                  video: videos.data[index],
                  isPlaylistVideo: true,
                );
              },
            ),
          ),
        ],
      ),
      // TODO finish this
      error: (error, stackTrace) => Center(
        child: Text('error: $error'),
      ),
      loading: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
