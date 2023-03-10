// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

part 'shorts_notifier.g.dart';

@riverpod
class ShortsNotifier extends _$ShortsNotifier {
  late final _authService = ref.read(authYoutubeServiceP);
  late final _service = ref.read(youtubeServiceP);

  // * builds the initial state
  @override
  Map<int, List<BaseInfoState<Video>>> build() {
    return {
      0: [
        const BaseInfoLoading(),
      ],
      1: [
        const BaseInfoLoading(),
      ],
      3: [
        const BaseInfoLoading(),
      ],
      4: [
        const BaseInfoLoading(),
      ],
    };
  }

  Future<void> getShorts() async {
    await ref.read(authNP.notifier).checkAndUpdateAuthStatus();
    final authState = ref.watch(authNP);
    authState.maybeWhen(
      orElse: () {},
      authenticated: () => _getLikedShorts(),
      unauthenticated: () => _getPopularShorts(),
    );
  }

  // * i take shorts from channel screen, put them here and the
  // just watch them inside shorts body player with index
  Future<void> getChannelShorts({
    required BaseInfoState<Video> shortsInfo,
    required int index,
  }) async {
    state = {
      ...state,
      index: [
        ...state[index]!,
        shortsInfo,
      ],
    };
  }

  Future<void> _getLikedShorts() async {
    final shortsOrFailure = await _authService.getLikedVideos(
      pageToken: state[1]!.last.baseInfo.nextPageToken,
    );

    state = {
      ...state,
      1: [
        ...state[1]!,
        shortsOrFailure.fold(
          (l) => BaseInfoState.error(
            baseInfo: state[1]!.last.baseInfo,
            failure: l,
          ),
          (r) => BaseInfoState.loaded(
            BaseInfo(
              data: [
                ...state[1]!.last.baseInfo.data,
                ...r.data,
              ],
              itemsPerPage: r.itemsPerPage,
              nextPageAvailable: r.nextPageAvailable,
              nextPageToken: r.nextPageToken,
              totalPages: r.totalPages,
            ),
          ),
        ),
      ],
    };
  }

  Future<void> _getPopularShorts() async {
    final shortsOrFailure = await _service.getPopularVideos(
      maxResults: '3',
      pageToken: state[1]!.last.baseInfo.nextPageToken,
    );

    state = {
      ...state,
      1: [
        ...state[1]!,
        shortsOrFailure.fold(
          (l) => BaseInfoState.error(
            baseInfo: state[1]!.last.baseInfo,
            failure: l,
          ),
          (r) => BaseInfoState.loaded(
            BaseInfo(
              data: [
                ...state[1]!.last.baseInfo.data,
                ...r.data,
              ],
              itemsPerPage: r.itemsPerPage,
              nextPageAvailable: r.nextPageAvailable,
              nextPageToken: r.nextPageToken,
              totalPages: r.totalPages,
            ),
          ),
        ),
      ]
    };
  }
}

@deprecated
class ShortsNotifierOld extends StateNotifier<BaseInfoState<Video>> {
  final YoutubeService _service;
  final AuthYoutubeService _authService;

  ShortsNotifierOld(
    this._service,
    this._authService,
  ) : super(const BaseInfoLoading());

  bool _isLoading = false;

  Future<void> getShorts(
    AuthState authState,
  ) async {
    authState.maybeWhen(
      orElse: () {},
      authenticated: () => _getLikedShorts(),
      unauthenticated: () => _getPopularShorts(),
    );
  }

  Future<void> _getLikedShorts() async {
    if (_isLoading) return;

    _isLoading = true;

    final shortsOrFailure = await _authService.getLikedShorts(
      nextPageToken: state.baseInfo.nextPageToken,
    );

    if (!mounted) return;

    state = shortsOrFailure.fold(
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
          itemsPerPage: r.itemsPerPage,
          nextPageAvailable: r.nextPageAvailable,
          nextPageToken: r.nextPageToken,
          totalPages: r.totalPages,
        ),
      ),
    );

    _isLoading = false;
  }

  Future<void> _getPopularShorts() async {
    if (_isLoading) return;

    _isLoading = true;

    final shortsOrFailure = await _service.getPopularShorts(
      pageToken: state.baseInfo.nextPageToken,
    );

    if (!mounted) return;

    state = shortsOrFailure.fold(
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
          itemsPerPage: r.itemsPerPage,
          nextPageAvailable: r.nextPageAvailable,
          nextPageToken: r.nextPageToken,
          totalPages: r.totalPages,
        ),
      ),
    );

    _isLoading = false;
  }
}
