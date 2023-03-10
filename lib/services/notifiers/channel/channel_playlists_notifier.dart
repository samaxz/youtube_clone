import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/playlist_model_new.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';

class ChannelPlaylistsNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelPlaylistsNotifier(this._ref);

  final Map<int, List<AsyncValue<List<Playlist>>>> state = {
    0: [
      const AsyncLoading(),
    ],
    1: [
      const AsyncLoading(),
    ],
    3: [
      const AsyncLoading(),
    ],
    4: [
      const AsyncLoading(),
    ],
  };

  bool _disposed = false;

  Future<void> getChannelPlaylists({
    required int index,
    required String channelId,
  }) async {
    state[index]!.add(const AsyncLoading());
    final service = _ref.read(youtubeServiceP);
    final playlists = await AsyncValue.guard(
      () => service.getChannelPlaylists(channelId),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => state[index]!.last = const AsyncLoading(),
    ).whenComplete(
      () {
        state[index]!.last = playlists;
        notifyListeners();
      },
    );
  }

  void removeLast(int index) {
    state[index]!.removeLast();
    if (state[index]!.last.isLoading) state[index]!.removeLast();
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

final channelPlaylistsTabCNP = ChangeNotifierProvider(
  (ref) => ChannelPlaylistsNotifier(ref),
);

@deprecated
class ChannelPlaylistsNotifierOld
    extends StateNotifier<AsyncValue<List<Playlist>?>> {
  final YoutubeService _service;

  ChannelPlaylistsNotifierOld(this._service)
      : super(
          const AsyncValue.loading(),
        );

  bool _isLoading = false;

  Future<void> getChannelPlaylists(String channelId) async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final channelPlaylists = await _service.getChannelPlaylists(channelId);
      if (!mounted) return;
      state = AsyncValue.data(channelPlaylists);
    } on Exception catch (e) {
      if (!mounted) return;
      state = AsyncValue.error(e, StackTrace.current);
    }

    _isLoading = false;
  }
}
