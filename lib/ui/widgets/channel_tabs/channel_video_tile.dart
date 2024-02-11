import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';

class ChannelVideoTile extends ConsumerWidget {
  final Video video;
  final bool isPlaylistVideo;

  const ChannelVideoTile({
    super.key,
    required this.video,
    this.isPlaylistVideo = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Helper.handleVideoCardPressed(
          ref: ref,
          video: video,
        );
      },
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
                    child: video.snippet.thumbnails.standard != null
                        ? CachedNetworkImage(
                            imageUrl: video.snippet.thumbnails.standard!,
                            errorWidget: (context, url, error) =>
                                Image.asset(Helper.defaultThumbnail),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(Helper.defaultThumbnail),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        video.contentDetails?.duration != null
                            ? Helper.formatDuration(video.contentDetails!.duration!)
                            : '',
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Colors.white,
                        ),
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
                    video.snippet.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          video.statistics?.viewCount != null
                              ? Helper.numberFormatter(
                                  video.statistics!.viewCount!,
                                )
                              : 'unknown views',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const Text('  •  '),
                      Text(
                        timeago.format(video.snippet.publishedAt),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isPlaylistVideo) ...[
              const SizedBox(width: 7),
            ] else ...[
              const SizedBox(width: 17),
            ],
            GestureDetector(
              // TODO change this
              onTap: () => Helper.showOtherActions(context),
              child: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
