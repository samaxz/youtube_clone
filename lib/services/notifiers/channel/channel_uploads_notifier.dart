import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';

part 'channel_uploads_notifier.g.dart';

@riverpod
class ChannelHomeNotifier extends _$ChannelHomeNotifier {
  @override
  Map<int, List<AsyncValue<Uploads>>> build() {
    return {
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
  }

  Future<void> getHomeTabContent({
    required int index,
    required String channelId,
  }) async {
    final service = ref.read(youtubeServiceP);
    final uploads = await AsyncValue.guard(
      () => service.getChannelUploads(channelId),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => state = {
        ...state,
        index: [
          ...state[index]!,
        ]..last = const AsyncLoading(),
      },
    ).whenComplete(() => state = {
          ...state,
          index: [
            ...state[index]!,
          ]..last = uploads
        });
  }

  void removeLast(int index) {
    state = {
      ...state,
      index: state[index]!..removeLast(),
    };
    // * doesn't remove the last / copied async loading without this
    if (state[index]!.last.isLoading) state[index]!.removeLast();
  }
}

@deprecated
class ChannelHomeNotifierOld extends ChangeNotifier {
  final Ref _ref;

  ChannelHomeNotifierOld(this._ref);

  final Map<int, List<AsyncValue<Uploads>>> _state = {
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

  Map<int, List<AsyncValue<Uploads>>> get state => _state;

  bool _disposed = false;

  Future<void> getHomeTabContent({
    required int index,
    required String channelId,
  }) async {
    _state[index]!.add(const AsyncLoading());
    final service = _ref.read(youtubeServiceP);
    final uploads = await AsyncValue.guard(
      () => service.getChannelUploads(channelId),
    );
    _state[index]!.last = uploads;
    notifyListeners();
  }

  void removeLast(int index) {
    _state[index]!.removeLast();
    if (_state[index]!.last.isLoading) _state[index]!.removeLast();
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

final channelHomeTabCNP = ChangeNotifierProvider(
  (ref) {
    ref.onDispose(() {
      log('channelHomeTabCNP just got disposed');
    });
    return ChannelHomeNotifierOld(ref);
  },
);

@deprecated
class UploadsNotifier extends StateNotifier<AsyncValue<Uploads>> {
  final YoutubeService _service;

  UploadsNotifier(this._service)
      : super(
          // const BaseInfoState.loading(
          //   BaseInfo(),
          // ),
          const AsyncValue.loading(),
        );

  bool _isLoading = false;

  Future<void> getUploads(
    String channelId, {
    String? pageToken,
  }) async {
    if (_isLoading) return;

    _isLoading = true;

    final uploadsOrFailure = await _service.convertUploadsIdsToVideos(
      channelId,
    );

    if (!mounted) return;

    state = uploadsOrFailure.fold(
      (l) => AsyncValue.error(
        l,
        StackTrace.current,
      ),
      (r) => AsyncValue.data(r),
    );

    _isLoading = false;
  }
}
