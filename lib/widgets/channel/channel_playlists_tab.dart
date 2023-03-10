import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_playlists_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_playlist_card.dart';

class ChannelPlaylistsTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelPlaylistsTab({
    super.key,
    required this.channelId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaylistsChannelTabState();
}

class _PlaylistsChannelTabState extends ConsumerState<ChannelPlaylistsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    ref
        .read(channelPlaylistsTabCNP.notifier)
        .getChannelPlaylists(channelId: widget.channelId, index: widget.index);
  }

  String? value = 'Date added (newest)';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final playlists = ref.watch(
      channelPlaylistsTabCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: ${error.failureData.message}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final notifier = ref.read(channelPlaylistsTabCNP.notifier);
                  notifier.getChannelPlaylists(
                    channelId: widget.channelId,
                    index: widget.index,
                  );
                },
                child: const Text('Tap to retry'),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
