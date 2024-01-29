import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/services/youtube_service.dart';

// TODO create and use generator
@deprecated
class PlaylistVideosNotifier extends StateNotifier<BaseInfoState<Video>> {
  final YoutubeService _service;

  PlaylistVideosNotifier(this._service) : super(const BaseInfoLoading());

  bool _isLoading = false;

  Future<void> getPlaylistVideos(String playlistId) async {
    if (_isLoading) return;

    _isLoading = true;

    final playlistItems = await _service.convertPlaylistItemsToVideos(playlistId);

    state = playlistItems.fold(
      (l) => BaseInfoState.error(baseInfo: state.baseInfo, failure: l),
      // since there's no pagination, i'll leave it as it is
      (r) => BaseInfoState.loaded(
        BaseInfo(data: r),
      ),
    );

    _isLoading = false;
  }
}
