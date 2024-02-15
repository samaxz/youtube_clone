import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'search_playlist_notifier.g.dart';

// this is used for SearchPlaylistScreen
@riverpod
class SearchPlaylistNotifier extends _$SearchPlaylistNotifier {
  @override
  List<BaseInfoState<Video>> build(int screenIndex) {
    return [
      const BaseInfoLoading(),
    ];
  }

  Future<void> getPlaylistVideos(
    String playlistId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const BaseInfoLoading();
    } else {
      state.add(const BaseInfoLoading());
    }

    state = List.from(state);

    final service = ref.read(youtubeServiceP);
    final playlistItems = await service.convertPlaylistItemsToVideos(playlistId);

    state = playlistItems.fold(
      (l) => [
        ...state,
        BaseInfoError(baseInfo: state.last.baseInfo, failure: l),
      ],
      (r) => [
        ...state,
        BaseInfoLoaded(
          BaseInfo(data: r),
        ),
      ],
    );

    log('SearchPlaylistNotifier state after getPlaylistVideos($playlistId): $state');
  }
}
