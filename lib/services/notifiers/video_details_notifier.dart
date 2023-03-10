// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart'
    as channel_model;
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/either_extension.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

part 'video_details_notifier.g.dart';

// * for video details
class VideoDetails {
  final channel_model.Channel channel;
  final BaseInfo<Video> videoInfo;
  final BaseInfo<Comment> comments;

  const VideoDetails({
    required this.channel,
    required this.videoInfo,
    required this.comments,
  });

  @override
  String toString() =>
      'VideoDetails(channel: $channel, videoInfo: $videoInfo, comments: $comments)';
}

@riverpod
class VideoDetailsNotifier extends _$VideoDetailsNotifier {
  @override
  AsyncValue<VideoDetails> build() {
    return const AsyncLoading();
  }

  Future<void> getDetails({
    required String videoId,
    required String channelId,
  }) async {
    final authState = ref.watch(authNP);
    final authService = ref.watch(authYoutubeServiceP);
    final service = ref.watch(youtubeServiceP);

    await ref.read(ratingSNP.notifier).getVideoRating(videoId: videoId);

    await ref
        .read(subscriptionSNP.notifier)
        .getSubscriptionState(channelId: channelId);
    late final Either<YoutubeFailure, BaseInfo<Video>> videosOrFailure;
    if (authState == const Authenticated()) {
      videosOrFailure = await authService.getLikedVideos();
    } else if (authState == const Unauthenticated()) {
      videosOrFailure = await service.getPopularVideos();
    }

    final channel = await service.getChannelInfoEither(channelId);
    final comments = await service.getVideoComments(videoId);

    if (channel.rightOrDefault == null ||
        comments.rightOrDefault == null ||
        videosOrFailure.rightOrDefault == null) {
      state = AsyncError<VideoDetails>(
        channel.leftOrDefault!,
        StackTrace.current,
      );
    } else {
      state = AsyncData(
        VideoDetails(
          channel: channel.rightOrDefault!,
          videoInfo: videosOrFailure.rightOrDefault!,
          comments: comments.rightOrDefault!,
        ),
      );
    }
  }
}

// ***************************************************************
@Deprecated('this is outdated, use VideoDetailsNotifier instead')
class VideoInfoNotifier extends StateNotifier<AsyncValue<VideoDetails>> {
  final Ref _ref;
  final YoutubeService _service;
  final AuthYoutubeService _authService;

  VideoInfoNotifier(
    this._ref,
    this._service,
    this._authService,
  ) : super(const AsyncLoading());

  bool _isLoading = false;

  Future<void> getDetails({
    // TODO deletet this
    AuthState? authState,
    required String videoId,
    required String channelId,
  }) async {
    if (_isLoading) return;

    _isLoading = true;

    late final Either<YoutubeFailure, BaseInfo<Video>> videosOrFailure;

    final authState = _ref.watch(authNP);

    if (authState == const AuthState.authenticated()) {
      videosOrFailure = await _authService.getLikedVideos();
    } else if (authState == const AuthState.unauthenticated()) {
      videosOrFailure = await _service.getPopularVideos();
    }

    await _ref.read(ratingSNP.notifier).getVideoRating(videoId: videoId);

    await _ref
        .read(subscriptionSNP.notifier)
        .getSubscriptionState(channelId: channelId);

    await decideStuff(channelId);

    if (!_isLoading) return;

    final channel = await _getChannelInfo(channelId);

    final comments = await _getComments(videoId);

    if (!mounted) return;

    state = videosOrFailure.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(
        VideoDetails(
          channel: channel,
          comments: comments,
          videoInfo: BaseInfo(
            data: [
              ...state.value?.videoInfo.data ?? [],
              ...r.data,
            ],
            nextPageToken: r.nextPageToken,
            nextPageAvailable: r.nextPageAvailable,
            totalPages: r.totalPages,
            itemsPerPage: r.itemsPerPage,
          ),
        ),
      ),
    );

    _isLoading = false;
  }

  Future<void> decideStuff(String channelId) async {
    final channelInfo = await _getVideoInfoFold(channelId);

    if (channelInfo.rightOrDefault != null) return;

    if (!mounted) return;

    state = AsyncError(channelInfo.leftOrDefault!, StackTrace.current);

    _isLoading = false;
  }

  Future<channel_model.Channel> _getChannelInfo(String channelId) async {
    late final channel_model.Channel channel;

    final channelOrFailure = await _service.getChannelInfoEither(channelId);
    if (mounted) {
      if (channelOrFailure.rightOrDefault == null) {
        state = AsyncError(
          const YoutubeFailure.noConnection(),
          StackTrace.current,
        );
      }
    }

    channel = channelOrFailure.fold(
      (l) => channel_model.Channel(
        kind: 'kind',
        etag: 'etag',
        id: 'id',
        snippet: channel_model.Snippet(
          publishedAt: DateTime(2020),
          title: 'title',
          description: 'description',
          customUrl: null,
          thumbnail: const channel_model.Thumbnials(
            defaultSize: null,
            high: null,
            medium: null,
          ),
          country: null,
        ),
        contentDetails: null,
        statistics: null,
      ),
      (r) => r,
    );

    return channel;
  }

  Future<Either<YoutubeFailure, channel_model.Channel>> _getVideoInfoFold(
    String channelId,
  ) async {
    final channel = await _service.getChannelInfoEither(channelId);

    return channel;
  }

  Future<void> tryLoadingComments(String videoId) async {}

  Future<BaseInfo<Comment>> _getComments(String videoId) async {
    final commentsOrFailure = await _service.getVideoComments(videoId);
    final comments = commentsOrFailure.rightOrDefault!;

    return comments;
  }
}
