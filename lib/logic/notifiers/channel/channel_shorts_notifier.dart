import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/youtube_service.dart';

part 'channel_shorts_notifier.g.dart';

@riverpod
class ChannelShortsNotifier extends _$ChannelShortsNotifier {
  @override
  // TODO make this return base info state, instead of async value
  // for loading shorts inside its tab
  List<AsyncValue<List<Video>>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  String channelId = '';
  late YoutubeService service = ref.read(youtubeServiceP);

  // UUSH - default, UUPS - popular
  Future<void> _loadShorts({
    required String shortsId,
    String maxResults = '20',
  }) async {
    state = List.from(state);

    final newShortsId = channelId.replaceRange(0, 2, shortsId);
    final shorts = await AsyncValue.guard(
      () => service.getPlaylistVideos(newShortsId, maxResults: maxResults),
    );
    state.last = shorts;

    state = List.from(state);
  }

  // this is used for getting default channel shorts category
  Future<void> getShorts(
    String newChannelId, {
    bool isReloading = false,
  }) async {
    channelId = newChannelId;

    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    await _loadShorts(shortsId: 'UUSH');
  }

  // i should just create a method called
  // this could also take in int if there are more than
  // 2 choices
  Future<void> switchCategory(bool isPopular) async {
    state.last = const AsyncLoading();

    await _loadShorts(shortsId: isPopular ? 'UUPS' : 'UUSH');
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO delete this
// class ChannelShortsNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelShortsNotifier(this._ref);
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
//   Future<void> getShorts({
//     required int index,
//     required String channelId,
//     required bool addState,
//   }) async {
//     if (addState) {
//       state[index]!.add(const AsyncLoading());
//     } else {
//       state[index]!.last = const AsyncLoading();
//     }
//     final shortsId = channelId.replaceRange(0, 2, 'UUSH');
//
//     final shorts = await AsyncValue.guard(
//       () => _service.getPlaylistVideos(shortsId, maxResults: '20'),
//     );
//
//     state[index]!.last = shorts;
//     notifyListeners();
//   }
//
//   Future<void> getPopularShorts({
//     required int index,
//     required String channelId,
//   }) async {
//     state[index]!.last = const AsyncLoading();
//     final popShortsId = channelId.replaceRange(0, 2, 'UUPS');
//
//     final popShorts = await AsyncValue.guard(
//       () => _service.getPlaylistVideos(popShortsId, maxResults: '20'),
//     );
//
//     state[index]!.last = popShorts;
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
// final channelShortsTabCNP = ChangeNotifierProvider(
//   (ref) => ChannelShortsNotifier(ref),
// );
