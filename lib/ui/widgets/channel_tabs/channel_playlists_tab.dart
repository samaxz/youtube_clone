import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_playlists_notifier.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_playlist_card.dart';

class ChannelPlaylistsTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelPlaylistsTab({
    super.key,
    required this.channelId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaylistsChannelTabState();
}

class _PlaylistsChannelTabState extends ConsumerState<ChannelPlaylistsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadPlaylists({bool isReloading = false}) async {
    final notifier = ref.read(channelPlaylistsNotifierProvider(widget.index).notifier);
    await notifier.getChannelPlaylists(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadPlaylists);
  }

  String? value = 'Date added (newest)';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final playlists = ref.watch(channelPlaylistsNotifierProvider(widget.index)).last;

    return playlists.when(
      data: (playlists) {
        if (playlists.isEmpty) {
          return const Center(
            child: Text('oops, looks like it`s empty'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 55),
          itemCount: playlists.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return DropdownButton<String>(
                value: value,
                onChanged: (newValue) => setState(() => value = newValue),
                items: ['Date added (newest)', 'Last video added']
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              );
            }

            return ChannelPlaylistCard(
              playlist: playlists[index - 1],
              index: widget.index,
            );
          },
        );
      },
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;

        return Center(
          child: TextButton(
            onPressed: () => loadPlaylists(isReloading: true),
            child: const Text('Tap to retry'),
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text('Error: ${error.failureData.message}'),
          //     const SizedBox(height: 10),
          //     ElevatedButton(
          //       onPressed: () => getPlaylists(isReloading: true),
          //       child: const Text('Tap to retry'),
          //     ),
          //   ],
          // ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
