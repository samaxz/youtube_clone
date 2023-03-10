import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/providers.dart';

class ChannelShortsNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelShortsNotifier(this._ref);

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

  Future<void> getShorts({
    required int index,
    required String channelId,
    required bool addState,
  }) async {
    if (addState) {
      state[index]!.add(const AsyncLoading());
    } else {
      state[index]!.last = const AsyncLoading();
    }
    final shortsId = channelId.replaceRange(0, 2, 'UUSH');

    final shorts = await AsyncValue.guard(
      () => _service.getPlaylistVideos(shortsId, maxResults: '20'),
    );

    state[index]!.last = shorts;
    notifyListeners();
  }

  Future<void> getPopularShorts({
    required int index,
    required String channelId,
  }) async {
    state[index]!.last = const AsyncLoading();
    final popShortsId = channelId.replaceRange(0, 2, 'UUPS');

    final popShorts = await AsyncValue.guard(
      () => _service.getPlaylistVideos(popShortsId, maxResults: '20'),
    );

    state[index]!.last = popShorts;
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

final channelShortsTabCNP = ChangeNotifierProvider(
  (ref) => ChannelShortsNotifier(ref),
);
