import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_demo/data/models/playlist/playlist_model.dart';
import 'package:youtube_demo/screens/channel_screen.dart';
import 'package:youtube_demo/screens/playlist_screen.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/helper_class.dart';

class SearchPlaylist extends ConsumerWidget {
  final Playlist playlist;
  final int index;

  const SearchPlaylist({
    super.key,
    required this.playlist,
    required this.index,
  });

  void goToChannel(BuildContext context) {
    if (playlist.snippet.channelId != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChannelScreen(
            channelId: playlist.snippet.channelId!,
            index: index,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlaylistScreen(
            playlist: playlist,
            index: index,
          ),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              playlist.snippet.thumbnail.high == null
                  ? Image.asset(Helper.defaultThumbnail)
                  : CachedNetworkImage(
                      imageUrl: playlist.snippet.thumbnail.high!,
                      errorWidget: (context, url, error) =>
                          Image.asset(Helper.defaultThumbnail),
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              SizedBox(
                height: 220,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 20,
                    color: Colors.brown.withOpacity(0.8),
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.playlist_play,
                            size: 20,
                          ),
                          const Spacer(),
                          Text(
                            playlist.itemCount != null
                                ? '${playlist.itemCount} videos'
                                : 'unknown videos',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => goToChannel(context),
                  onLongPress: () => goToChannel(context),
                  child: const CircleAvatar(
                    foregroundImage: AssetImage(Helper.defaultPfp),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          playlist.snippet.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          playlist.snippet.channelTitle != null
                              ? playlist.snippet.channelTitle!
                              : 'unknown',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Helper.handleMoreVertPressed(
                    context: context,
                    ref: ref,
                    screenIdAndActions: const ScreenIdAndActions(
                      actions: ScreenActions.playlist,
                    ),
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
