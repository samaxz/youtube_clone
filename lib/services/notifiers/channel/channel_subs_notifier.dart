import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_demo/services/common/providers.dart';

class ChannelSubsNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelSubsNotifier(this._ref);

  final Map<int, List<AsyncValue<List<ChannelSubscription>>>> state = {
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

  Future<void> getChannelSubs({
    required int index,
    required String channelId,
  }) async {
    state[index]!.add(const AsyncLoading());
    final service = _ref.read(youtubeServiceP);
    final subs = await AsyncValue.guard(
      () => service.getChannelSubscriptions(channelId),
    );
    state[index]!.last = subs;
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

final channelSubsTabCNP = ChangeNotifierProvider(
  (ref) => ChannelSubsNotifier(ref),
);
