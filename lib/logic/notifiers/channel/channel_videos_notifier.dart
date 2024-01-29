import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/youtube_service.dart';

part 'channel_videos_notifier.g.dart';

// this is used for channel's videos tab
@riverpod
class ChannelVideosNotifier extends _$ChannelVideosNotifier {
  @override
  List<AsyncValue<List<Video>>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  String channelId = '';
  bool displayFilters = false;

  // UULF - default (recent), UULP - popular
  Future<void> _loadVideos({
    required String videosId,
    String maxResults = '20',
  }) async {
    log('channel id: $channelId');
    final newVideosId = channelId.replaceRange(0, 2, videosId);
    log('new videos id: $newVideosId');

    final service = ref.read(youtubeServiceP);
    final videos = await AsyncValue.guard(
      () async {
        final videos = await service.getPlaylistVideos(newVideosId, maxResults: maxResults);

        if (videos.isEmpty) {
          displayFilters = false;
        } else {
          displayFilters = true;
        }

        return videos;
      },
    );

    state.last = videos.when(
      data: (data) {
        if (data.isEmpty) {
          displayFilters = false;
        } else {
          displayFilters = true;
        }

        return AsyncData(data);
      },
      error: (err, stack) {
        displayFilters = false;

        return AsyncError(err, stack);
      },
      loading: () {
        // this could be a problem
        displayFilters = true;

        return const AsyncLoading();
      },
    );

    state = List.from(state);
  }

  Future<void> getVideos(
    String newChannelId, {
    bool isReloading = false,
  }) async {
    // could also return from here
    // if (channelId != newChannelId) {
    //   channelId = newChannelId;
    // }
    channelId = newChannelId;

    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    await _loadVideos(videosId: 'UULF');
  }

  // this is for the popular videos filter on the
  // channel's videos tab (i think so, at least)
  // Future<void> getPopularVideos() async {
  //   state.last = const AsyncLoading();
  //
  //   final popVidsId = channelId.replaceRange(0, 2, 'UULP');
  //   final popVids = await AsyncValue.guard(
  //     () => service.getPlaylistVideos(popVidsId, maxResults: '20'),
  //   );
  //
  //   state.last = popVids;
  // }

  Future<void> switchVideos(bool isPopular) async {
    state.last = const AsyncLoading();

    await _loadVideos(videosId: isPopular ? 'UULP' : 'UULF');
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO remove this
// class ChannelVideosNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelVideosNotifier(this._ref);
//
//   final Map<int, List<AsyncValue<List<Video>>>> state = {
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
//   late final _service = _ref.read(youtubeServiceP);
//
//   Future<void> getVideos({
//     required int index,
//     required String channelId,
//     required bool shouldAdd,
//     required bool reloading,
//   }) async {
//     if (shouldAdd || reloading) {
//       state[index]!.add(const AsyncLoading());
//     } else {
//       state[index]!.last = const AsyncLoading();
//     }
//     notifyListeners();
//     final videosId = channelId.replaceRange(0, 2, 'UULF');
//
//     final videos = await AsyncValue.guard(
//       () => _service.getPlaylistVideos(videosId, maxResults: '20'),
//     );
//
//     if (reloading) {
//       Future.delayed(
//         const Duration(seconds: 1),
//         () {
//           state[index]!.last = const AsyncLoading();
//         },
//       ).whenComplete(
//         () {
//           state[index]!.last = videos;
//           notifyListeners();
//         },
//       );
//     } else {
//       state[index]!.last = videos;
//     }
//
//     notifyListeners();
//   }
//
//   Future<void> getPopularVideos({
//     required int index,
//     required String channelId,
//   }) async {
//     state[index]!.last = const AsyncLoading();
//     final popVidsId = channelId.replaceRange(0, 2, 'UULP');
//
//     final popVids = await AsyncValue.guard(
//       () => _service.getPlaylistVideos(popVidsId, maxResults: '20'),
//     );
//
//     state[index]!.last = popVids;
//
//     notifyListeners();
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
// final channelVideosTabCNP = ChangeNotifierProvider(
//   (ref) => ChannelVideosNotifier(ref),
// );
