import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';

class ChannelShortsCard extends ConsumerWidget {
  final Video short;
  final VoidCallback onTap;

  const ChannelShortsCard({
    super.key,
    required this.short,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNP);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        width: 40,
        child: Stack(
          children: [
            short.snippet.thumbnails.medium == null
                ? Image.asset(Helper.defaultThumbnail)
                : CachedNetworkImage(
                    imageUrl: short.snippet.thumbnails.medium!,
                    // this is kinda useless
                    errorWidget: (context, url, error) => Image.asset(Helper.defaultThumbnail),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            Positioned(
              top: -5,
              right: -5,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40),
                child: InkWell(
                  enableFeedback: false,
                  // TODO make this work for different types of videos
                  onTap: () => Helper.showDownloadPressed(
                    context: context,
                    ref: ref,
                    videoId: short.id,
                  ),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // this is responsible for the splash radius
                  child: Ink(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.more_vert,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Text(
                short.statistics?.viewCount != null
                    ? '${Helper.numberFormatter(short.statistics!.viewCount!)} views'
                    : 'unknown views',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
