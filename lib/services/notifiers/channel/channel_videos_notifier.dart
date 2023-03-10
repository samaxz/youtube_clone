import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/providers.dart';

class ChannelVideosNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelVideosNotifier(this._ref);

  final Map<int, List<AsyncValue<List<Video>>>> state = {
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

  late final _service = _ref.read(youtubeServiceP);

  Future<void> getVideos({
    required int index,
    required String channelId,
    required bool shouldAdd,
    required bool reloading,
  }) async {
    if (shouldAdd || reloading) {
      state[index]!.add(const AsyncLoading());
    } else {
      state[index]!.last = const AsyncLoading();
    }
    notifyListeners();
    final videosId = channelId.replaceRange(0, 2, 'UULF');

    final videos = await AsyncValue.guard(
      () => _service.getPlaylistVideos(videosId, maxResults: '20'),
    );

    if (reloading) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          state[index]!.last = const AsyncLoading();
        },
      ).whenComplete(
        () {
          state[index]!.last = videos;
          notifyListeners();
        },
      );
    } else {
      state[index]!.last = videos;
    }

    notifyListeners();
  }

  Future<void> getPopularVideos({
    required int index,
    required String channelId,
  }) async {
    state[index]!.last = const AsyncLoading();
    final popVidsId = channelId.replaceRange(0, 2, 'UULP');

    final popVids = await AsyncValue.guard(
      () => _service.getPlaylistVideos(popVidsId, maxResults: '20'),
    );

    state[index]!.last = popVids;

    notifyListeners();
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

final channelVideosTabCNP = ChangeNotifierProvider(
  (ref) => ChannelVideosNotifier(ref),
);
