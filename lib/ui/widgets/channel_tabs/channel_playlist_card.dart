import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/models/playlist_model_new.dart';
import 'package:youtube_clone/ui/screens/playlist_screen_new.dart';
import 'package:youtube_clone/logic/services/common_classes.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';

class ChannelPlaylistCard extends ConsumerWidget {
  final Playlist playlist;
  final int index;

  const ChannelPlaylistCard({
    super.key,
    required this.playlist,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNP);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlaylistScreenNew(
            playlist: playlist,
            index: index,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 65,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: playlist.thumbnail == null
                        ? Image.asset(Helper.defaultThumbnail)
                        : CachedNetworkImage(
                            imageUrl: playlist.thumbnail!,
                            errorWidget: (context, url, error) =>
                                Image.asset(Helper.defaultThumbnail),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: 120,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Colors.brown.withOpacity(0.8),
                      ),
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.playlist_play,
                            size: 15,
                            // color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            playlist.videoCount != null
                                ? playlist.videoCount!.toString()
                                : 'unknown',
                            style: TextStyle(
                              fontSize: 11,
                              // color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title != null ? playlist.title! : 'unknown',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      // color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    playlist.author?.channelName != null
                        ? playlist.author!.channelName!
                        : 'unknown',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 17),
            GestureDetector(
              // TODO change this
              onTap: () => Helper.handleMoreVertPressed(
                context: context,
                ref: ref,
                screenIdAndActions: const ScreenIdAndActions(
                  actions: ScreenActions.playlistChannel,
                ),
              ),
              child: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
