import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'channel_home_notifier.g.dart';

@riverpod
class ChannelHomeNotifier extends _$ChannelHomeNotifier {
  @override
  List<AsyncValue<Uploads>> build(int screenIndex) {
    return [
      // used to avoid throws in build when watching the notifier
      const AsyncLoading(),
    ];
  }

  Future<void> getHomeTabContent(
    String channelId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    // this could be inside isReloading
    // TODO move this inside isReloading
    state = List.from(state);

    final service = ref.read(youtubeServiceP);
    final uploads = await AsyncValue.guard(
      () => service.getChannelUploads(channelId),
    );
    log('uploads: $uploads');
    state.last = uploads;

    state = List.from(state);
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO remove this
// @deprecated
// class ChannelHomeNotifierOld extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelHomeNotifierOld(this._ref);
//
//   final Map<int, List<AsyncValue<Uploads>>> _state = {
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
//   Map<int, List<AsyncValue<Uploads>>> get state => _state;
//
//   bool _disposed = false;
//
//   Future<void> getHomeTabContent({
//     required int index,
//     required String channelId,
//   }) async {
//     _state[index]!.add(const AsyncLoading());
//     final service = _ref.read(youtubeServiceP);
//     final uploads = await AsyncValue.guard(
//       () => service.getChannelUploads(channelId),
//     );
//     _state[index]!.last = uploads;
//     notifyListeners();
//   }
//
//   void removeLast(int index) {
//     _state[index]!.removeLast();
//     if (_state[index]!.last.isLoading) _state[index]!.removeLast();
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
// final channelHomeTabCNP = ChangeNotifierProvider(
//   (ref) {
//     ref.onDispose(() {
//       log('channelHomeTabCNP just got disposed');
//     });
//     return ChannelHomeNotifierOld(ref);
//   },
// );
//
// @deprecated
// class UploadsNotifier extends StateNotifier<AsyncValue<Uploads>> {
//   final YoutubeService _service;
//
//   UploadsNotifier(this._service)
//       : super(
//           // const BaseInfoState.loading(
//           //   BaseInfo(),
//           // ),
//           const AsyncValue.loading(),
//         );
//
//   bool _isLoading = false;
//
//   Future<void> getUploads(
//     String channelId, {
//     String? pageToken,
//   }) async {
//     if (_isLoading) return;
//
//     _isLoading = true;
//
//     final uploadsOrFailure = await _service.convertUploadsIdsToVideos(
//       channelId,
//     );
//
//     if (!mounted) return;
//
//     state = uploadsOrFailure.fold(
//       (l) => AsyncValue.error(
//         l,
//         StackTrace.current,
//       ),
//       (r) => AsyncValue.data(r),
//     );
//
//     _isLoading = false;
//   }
// }
