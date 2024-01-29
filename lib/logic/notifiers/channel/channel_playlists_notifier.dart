import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/playlist_model_new.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'channel_playlists_notifier.g.dart';

@riverpod
class ChannelPlaylistsNotifier extends _$ChannelPlaylistsNotifier {
  @override
  List<AsyncValue<List<Playlist>>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  Future<void> getChannelPlaylists(
    String channelId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    final service = ref.read(youtubeServiceP);
    final playlists = await AsyncValue.guard(
      () => service.getChannelPlaylists(channelId),
    );
    state.last = playlists;

    state = List.from(state);
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO remove this
// class ChannelPlaylistsNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelPlaylistsNotifier(this._ref);
//
//   final Map<int, List<AsyncValue<List<Playlist>>>> state = {
//     0: [
//       const AsyncLoading(),
//     ],
//     1: [
//       const AsyncLoading(),
//     ],
//     3: [
//       const AsyncLoading(),
//     ],
//     4: [
//       const AsyncLoading(),
//     ],
//   };
//
//   bool _disposed = false;
//
//   Future<void> getChannelPlaylists({
//     required int index,
//     required String channelId,
//   }) async {
//     state[index]!.add(const AsyncLoading());
//     final service = _ref.read(youtubeServiceP);
//     final playlists = await AsyncValue.guard(
//       () => service.getChannelPlaylists(channelId),
//     );
//
//     Future.delayed(
//       const Duration(seconds: 1),
//       () => state[index]!.last = const AsyncLoading(),
//     ).whenComplete(
//       () {
//         state[index]!.last = playlists;
//         notifyListeners();
//       },
//     );
//   }
//
//   void removeLast(int index) {
//     state[index]!.removeLast();
//     if (state[index]!.last.isLoading) state[index]!.removeLast();
//     notifyListeners();
//   }
//
//   @override
//   void notifyListeners() {
//     if (_disposed) return;
//     super.notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     _disposed = true;
//     super.dispose();
//   }
// }
//
// final channelPlaylistsTabCNP = ChangeNotifierProvider(
//   (ref) => ChannelPlaylistsNotifier(ref),
// );
