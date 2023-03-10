import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';

class CommentInfoNotifier extends StateNotifier<BaseInfoState<Comment>> {
  final YoutubeService _service;

  CommentInfoNotifier(this._service) : super(const BaseInfoLoading());

  bool _isLoading = false;

  Future<void> getComments(String videoId) async {
    if (_isLoading) return;

    _isLoading = true;

    final commentsOrFailure = await _service.getVideoComments(
      videoId,
      pageToken: state.baseInfo.nextPageToken,
    );

    if (!mounted) return;

    state = commentsOrFailure.fold(
      (l) => BaseInfoState.error(
        baseInfo: state.baseInfo,
        failure: l,
      ),
      (r) => BaseInfoState.loaded(
        BaseInfo(
          data: [
            ...state.baseInfo.data,
            ...r.data,
          ],
          nextPageToken: r.nextPageToken,
          nextPageAvailable: r.nextPageAvailable,
          totalPages: r.totalPages,
          itemsPerPage: r.itemsPerPage,
          disabled: r.disabled,
        ),
      ),
    );

    _isLoading = false;
  }
}
