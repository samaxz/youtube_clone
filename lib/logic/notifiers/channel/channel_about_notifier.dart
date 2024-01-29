import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/channel/channel_about_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'channel_about_notifier.g.dart';

@riverpod
class ChannelAboutNotifier extends _$ChannelAboutNotifier {
  @override
  List<AsyncValue<About>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  Future<void> getAbout(
    String channelId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    final service = ref.read(youtubeServiceP);
    final about = await AsyncValue.guard(
      () => service.getChannelAbout(channelId),
    );
    state.last = about;

    state = List.from(state);
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO remove this
// class ChannelAboutNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelAboutNotifier(this._ref);
//
//   final Map<int, List<AsyncValue<About>>> state = {
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
//   Future<void> getAbout({
//     required int index,
//     required String channelId,
//     required bool reloading,
//   }) async {
//     if (reloading) {
//       state[index]!.add(const AsyncLoading());
//     } else {
//       state[index]!.last = const AsyncLoading();
//     }
//     // this is needed to show the transition from
//     // error to data
//     notifyListeners();
//
//     final about = await AsyncValue.guard(
//       () => _service.getChannelAbout(channelId),
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
//           state[index]!.last = about;
//           notifyListeners();
//         },
//       );
//     } else {
//       state[index]!.last = about;
//     }
//
//     // without this, the loading indicator of async loading
//     // won't be shown
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
// final channelAboutTabCNP = ChangeNotifierProvider(
//   (ref) => ChannelAboutNotifier(ref),
// );
