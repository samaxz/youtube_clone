// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'shorts_notifier.g.dart';

@riverpod
class ShortsNotifier extends _$ShortsNotifier {
  @override
  List<BaseInfoState<Video>> build(int screenIndex) {
    return [
      const BaseInfoLoading(),
    ];
  }

  // TODO make this sync
  Future<void> getShorts() async {
    final authState = ref.read(authNotifierProvider);
    authState.when(
      initial: () {},
      authenticated: _getLikedShorts,
      unauthenticated: _getPopularShorts,
      // TODO make this show a snack bar with failure message
      failure: (failure) {},
    );
    // log('getShorts() inside ShortsNotifier');
  }

  Future<void> _getLikedShorts() async {
    final authService = ref.read(authYoutubeServiceP);
    final shortsOrFailure = await authService.getLikedVideos(
      pageToken: state.last.baseInfo.nextPageToken,
    );

    state = shortsOrFailure.fold(
      (l) => [
        ...state,
        BaseInfoError(
          baseInfo: state.last.baseInfo,
          failure: l,
        ),
      ],
      (r) => [
        ...state,
        BaseInfoLoaded(
          // TODO add additional fields if necessary
          BaseInfo(
            data: r.data,
            nextPageToken: r.nextPageToken,
            nextPageAvailable: r.nextPageAvailable,
          ),
        ),
      ],
    );
  }

  Future<void> _getPopularShorts() async {
    final service = ref.read(youtubeServiceP);
    final shortsOrFailure = await service.getPopularVideos(
      pageToken: state.last.baseInfo.nextPageToken,
    );

    state = shortsOrFailure.fold(
      (l) => [
        ...state,
        BaseInfoError(
          baseInfo: state.last.baseInfo,
          failure: l,
        ),
      ],
      (r) => [
        ...state,
        BaseInfoLoaded(
          // TODO add additional fields if necessary
          BaseInfo(
            data: r.data,
            nextPageToken: r.nextPageToken,
            nextPageAvailable: r.nextPageAvailable,
          ),
        ),
      ],
    );
  }
}
