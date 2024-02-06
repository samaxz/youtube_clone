import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'channel_subs_notifier.g.dart';

@riverpod
class ChannelSubsNotifier extends _$ChannelSubsNotifier {
  @override
  List<AsyncValue<List<ChannelSubscription>>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  Future<void> getChannelSubs(
    String channelId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    // TODO add this to every other channel tab notifier that uses list
    state = List.from(state);

    final service = ref.read(youtubeServiceP);
    final subs = await AsyncValue.guard(
      () => service.getChannelSubscriptions(channelId),
    );
    // log('subs: $subs');
    state.last = subs;

    state = List.from(state);
  }

  void removeLast() => state = List.from(state)..removeLast();
}

// TODO remove this
// class ChannelSubsNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelSubsNotifier(this._ref);
//
//   final Map<int, List<AsyncValue<List<ChannelSubscription>>>> state = {
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
//   Future<void> getChannelSubs({
//     required int index,
//     required String channelId,
//   }) async {
//     state[index]!.add(const AsyncLoading());
//     final service = _ref.read(youtubeServiceP);
//     final subs = await AsyncValue.guard(
//       () => service.getChannelSubscriptions(channelId),
//     );
//     state[index]!.last = subs;
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
// final channelSubsTabCNP = ChangeNotifierProvider(
//   (ref) => ChannelSubsNotifier(ref),
// );
