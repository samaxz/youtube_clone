import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';

class SearchPlaylist extends ConsumerStatefulWidget {
  final Playlist playlist;
  final int screenIndex;

  const SearchPlaylist({
    super.key,
    required this.playlist,
    required this.screenIndex,
  });

  @override
  ConsumerState createState() => _SearchPlaylistState();
}

class _SearchPlaylistState extends ConsumerState<SearchPlaylist> {
  void goToChannel(WidgetRef ref) {
    if (widget.playlist.snippet.channelId != null) {
      final notifier = ref.read(screensManagerProvider(widget.screenIndex).notifier);
      notifier.pushScreen(
        CustomScreen.channel(
          channelId: widget.playlist.snippet.channelId!,
          screenIndex: widget.screenIndex,
        ),
      );
    }
  }

  Color generateRandomColor({bool withOpacity = true}) {
    final randomNum = math.Random().nextInt(Colors.primaries.length);
    late final Color generatedColor;
    if (withOpacity) {
      generatedColor = Colors.primaries[randomNum].withOpacity(0.2);
    } else {
      generatedColor = Colors.primaries[randomNum];
    }
    return generatedColor;
  }

  late final Color randomColor;

  @override
  void initState() {
    super.initState();
    randomColor = generateRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          final notifier = ref.read(screensManagerProvider(widget.screenIndex).notifier);
          notifier.pushScreen(
            CustomScreen.searchPlaylist(
              playlist: widget.playlist,
              screenIndex: widget.screenIndex,
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                widget.playlist.snippet.thumbnail.high == null
                    ? Image.asset(Helper.defaultThumbnail)
                    : CachedNetworkImage(
                        imageUrl: widget.playlist.snippet.thumbnail.high!,
                        errorWidget: (context, url, error) {
                          return Image.asset(Helper.defaultThumbnail);
                        },
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
                      color: generateRandomColor(),
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
                              widget.playlist.itemCount != null
                                  ? '${widget.playlist.itemCount} videos'
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
                    onTap: () => goToChannel(ref),
                    onLongPress: () => goToChannel(ref),
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
                            widget.playlist.snippet.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.playlist.snippet.channelTitle != null
                                ? widget.playlist.snippet.channelTitle!
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
                    // TODO change this
                    onTap: () => Helper.showOtherActions(context),
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
      ),
    );
  }
}
