import 'dart:math' as math;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/video_category_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/videos_service.dart';

part 'videos_notifier.g.dart';

@riverpod
class VideosNotifier extends _$VideosNotifier {
  @override
  BaseInfoState<Video> build() {
    return const BaseInfoLoading();
  }

  int categoryId = 0;
  bool shouldSkip = false;
  bool loadCategories = true;

  void setFailureState(YoutubeFailure failure) {
    state = BaseInfoError(
      baseInfo: state.baseInfo,
      failure: failure,
    );
  }

  // i could technically make this sync
  Future<void> getVideos({int? newCategoryId}) async {
    if (newCategoryId != null) {
      categoryId = newCategoryId;
    }

    final authState = ref.read(authNotifierProvider);
    authState.maybeWhen(
      orElse: () {},
      authenticated: _getLikedVideos,
      unauthenticated: _getPopularVideos,
    );
  }

  Future<void> _getLikedVideos() async {
    final authService = ref.read(authYoutubeServiceP);
    final videosOrFailure = await authService.getLikedVideos(
      pageToken: state.baseInfo.nextPageToken,
    );

    state = videosOrFailure.fold(
      (l) => BaseInfoError(baseInfo: state.baseInfo, failure: l),
      (r) => BaseInfoLoaded(
        BaseInfo(
          data: List.from(state.baseInfo.data)..addAll(r.data),
          nextPageToken: r.nextPageToken,
          nextPageAvailable: r.nextPageAvailable,
          totalPages: r.totalPages,
          itemsPerPage: r.itemsPerPage,
        ),
      ),
    );
  }

  Future<void> _getPopularVideos() async {
    // UPD decided not gonna use this
    // state = BaseInfoLoading(baseInfo: state.baseInfo);

    if (loadCategories) {
      await ref.read(videoCategoriesNotifierProvider.notifier).getVideoCategories();
    }

    if (shouldSkip) return;

    final service = ref.read(youtubeServiceP);
    final videosOrFailure = await service.getPopularVideos(
      videoCategoryId: '$categoryId',
      pageToken: state.baseInfo.nextPageToken,
    );

    state = videosOrFailure.fold(
      (l) => BaseInfoError(baseInfo: state.baseInfo, failure: l),
      (r) => BaseInfoLoaded(
        BaseInfo(
          data: List.from(state.baseInfo.data)..addAll(r.data),
          nextPageToken: r.nextPageToken,
          nextPageAvailable: r.nextPageAvailable,
          totalPages: r.totalPages,
          itemsPerPage: r.itemsPerPage,
        ),
      ),
    );
  }
}

// TODO delete this
// this is used exclusively for testing purposes
// @deprecated
// @riverpod
// class VideosNotifierTest extends _$VideosNotifierTest {
//   @override
//   BaseInfoState<Video> build() {
//     return const BaseInfoLoading();
//   }
//
//   Future<void> getVideos({
//     int categoryId = 0,
//     Mock? mock,
//     Future<dynamic> Function()? func,
//   }) async {
//     final videoService = ref.read(videosServiceP);
//     final loadVideos = await videoService.testVideos();
//     final randomNumber = math.Random().nextInt(2);
//     if (loadVideos == null && randomNumber == 0) {
//       await _getVideosFirst();
//     } else {
//       await _getVideosLast();
//     }
//   }
//
//   Future<void> _getVideosFirst() async {
//     Future.delayed(const Duration(milliseconds: 300));
//     state = const BaseInfoLoaded(BaseInfo());
//   }
//
//   Future<void> _getVideosLast() async {
//     Future.delayed(const Duration(milliseconds: 500));
//     state = const BaseInfoLoaded(BaseInfo());
//     // debugPrint('_getVideosLast() has been called inside VideosNotifierTest');
//   }
// }
