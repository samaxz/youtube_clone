import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/videos_service.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'dart:math' as math;
import 'package:mocktail/mocktail.dart';

part 'videos_notifier.g.dart';

@riverpod
class VideosNotifier extends _$VideosNotifier {
  @override
  BaseInfoState<Video> build() {
    return const BaseInfoLoading();
  }

  Future<void> getVideos({
    int categoryId = 0,
  }) async {
    await ref.read(authNotifierProvider.notifier).checkAndUpdateAuthStatus();
    // final authState = ref.watch(authNotifierProvider);
    final authState =
        await ref.read(authNotifierProvider.notifier).getAuthState();

    authState.maybeWhen(
      orElse: () {},
      authenticated: _getLikedVideos,
      unauthenticated: () => _getPopularVideos(categoryId),
    );
  }

  Future<void> _getLikedVideos() async {
    final authService = ref.read(authYoutubeServiceP);

    final videosOrFailure = await authService.getLikedVideos(
      pageToken: state.baseInfo.nextPageToken,
    );

    state = videosOrFailure.fold(
      (l) => BaseInfoState.error(baseInfo: state.baseInfo, failure: l),
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
        ),
      ),
    );

    // log('_getLikedVideos() has been called');
  }

  Future<void> _getPopularVideos(int categoryId) async {
    final service = ref.read(youtubeServiceP);

    await ref.read(videoCategoryNP.notifier).getVideoCategories();

    final videosOrFailure = await service.getPopularVideos(
      pageToken: state.baseInfo.nextPageToken,
      videoCategoryId: categoryId.toString(),
    );

    // log('videosOrFailure has been instantiated inside VideosNotifier()');

    state = videosOrFailure.fold(
      (l) => BaseInfoState.error(baseInfo: state.baseInfo, failure: l),
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
        ),
      ),
    );

    // log('_getPopularVideos() inside VideosNotifier has been called');
  }

  // *** this is used for testing purposes only
  Future<void> testVideos({YoutubeFailure? failure}) async {
    final videoService = ref.read(videosServiceP);
    // this will always be null, cause of the Mock under the hood thingies
    final loadVideos = await videoService.testVideos();
    final randomNumber = math.Random().nextInt(2);
    if (loadVideos == null && randomNumber == 0) {
      await _getVideosFirst(failure: failure);
    } else {
      await _getVideosLast(failure: failure);
    }
  }

  Future<void> _getVideosFirst({YoutubeFailure? failure}) async {
    Future.delayed(const Duration(milliseconds: 300));
    if (failure != null) {
      state = BaseInfoError(
        baseInfo: const BaseInfo(),
        failure: failure,
      );
      // debugPrint('state is now $state');
    } else {
      state = const BaseInfoLoaded(BaseInfo());
    }
  }

  Future<void> _getVideosLast({YoutubeFailure? failure}) async {
    Future.delayed(const Duration(milliseconds: 500));
    if (failure != null) {
      state = BaseInfoError(
        baseInfo: const BaseInfo(),
        failure: failure,
      );
      // debugPrint('state is now $state');
    } else {
      state = const BaseInfoLoaded(BaseInfo());
    }
  }
}

// this is used exclusively for testing purposes
@deprecated
@riverpod
class VideosNotifierTest extends _$VideosNotifierTest {
  @override
  BaseInfoState<Video> build() {
    return const BaseInfoLoading();
  }

  Future<void> getVideos({
    int categoryId = 0,
    Mock? mock,
    Future<dynamic> Function()? func,
  }) async {
    final videoService = ref.read(videosServiceP);
    final loadVideos = await videoService.testVideos();
    final randomNumber = math.Random().nextInt(2);
    if (loadVideos == null && randomNumber == 0) {
      await _getVideosFirst();
    } else {
      await _getVideosLast();
    }
  }

  Future<void> _getVideosFirst() async {
    Future.delayed(const Duration(milliseconds: 300));
    state = const BaseInfoLoaded(BaseInfo());
  }

  Future<void> _getVideosLast() async {
    Future.delayed(const Duration(milliseconds: 500));
    state = const BaseInfoLoaded(BaseInfo());
    // debugPrint('_getVideosLast() has been called inside VideosNotifierTest');
  }
}

@deprecated
class VideosNotifierOld extends StateNotifier<BaseInfoState<Video>> {
  final Ref _ref;
  final YoutubeService _service;
  final AuthYoutubeService _authService;

  VideosNotifierOld(
    this._ref,
    this._service,
    this._authService,
  ) : super(const BaseInfoLoading());

  bool _isLoading = false;

  Future<void> getVideos({
    AuthState? authState,
    int categoryId = 0,
  }) async {
    await _ref.read(authNP.notifier).checkAndUpdateAuthStatus();
    final authState = _ref.read(authNP);

    authState.maybeWhen(
      orElse: () {},
      authenticated: _getLikedVideos,
      unauthenticated: () => _getPopularVideos(categoryId),
    );
  }

  Future<void> _getLikedVideos() async {
    if (_isLoading) return;

    _isLoading = true;

    final videosOrFailure = await _authService.getLikedVideos(
      pageToken: state.baseInfo.nextPageToken,
    );

    if (!mounted) return;

    state = videosOrFailure.fold(
      (l) => BaseInfoState.error(baseInfo: state.baseInfo, failure: l),
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
        ),
      ),
    );

    // log('_getLikedVideos() has been called');

    _isLoading = false;
  }

  Future<void> _getPopularVideos(int categoryId) async {
    if (_isLoading) return;

    _isLoading = true;

    await _ref.read(videoCategoryNP.notifier).getVideoCategories();

    if (!mounted) return;

    final videosOrFailure = await _service.getPopularVideos(
      pageToken: state.baseInfo.nextPageToken,
      videoCategoryId: categoryId.toString(),
    );

    // log('videosOrFailure has been instantiated inside VideosNotifier()');

    if (!mounted) return;

    state = videosOrFailure.fold(
      (l) => BaseInfoState.error(baseInfo: state.baseInfo, failure: l),
      (r) => BaseInfoState.loaded(
        BaseInfo(
          data: [
            ...state.baseInfo.data,
            ...r.data,
          ],
          // * doesn't work
          // data: r.data + state.baseInfo.data,
          nextPageToken: r.nextPageToken,
          nextPageAvailable: r.nextPageAvailable,
          totalPages: r.totalPages,
          itemsPerPage: r.itemsPerPage,
        ),
      ),
    );

    // log('_getPopularVideos() inside VideosNotifier has been called');

    _isLoading = false;
  }
}
