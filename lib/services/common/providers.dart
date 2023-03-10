import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/widgets/my_miniplayer.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/data/models/channel/community_post_model.dart';
import 'package:youtube_demo/data/models/playlist_model_new.dart';
import 'package:youtube_demo/data/models/video/video_category_model.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_playlists_notifier.dart';
import 'package:youtube_demo/services/notifiers/comment_info_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_demo/services/notifiers/connectivity_notifier.dart';
import 'package:youtube_demo/services/notifiers/playlist_videos_notifier.dart';
import 'package:youtube_demo/services/notifiers/video_category_notifier_provider.dart';
import 'package:youtube_demo/services/notifiers/rating_notifier.dart';
import 'package:youtube_demo/services/notifiers/search_history_notifier.dart';
import 'package:youtube_demo/services/common/search_history_repository.dart';
import 'package:youtube_demo/services/notifiers/shorts_notifier.dart';
import 'package:youtube_demo/services/notifiers/subscription_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_uploads_notifier.dart';
import 'package:youtube_demo/services/notifiers/video_details_notifier.dart';
import 'package:youtube_demo/services/common/sembast_database.dart';
import 'package:youtube_demo/services/notifiers/videos_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

final dioP = Provider(
  (ref) => Dio(
    BaseOptions(),
  ),
);

final authDioP = Provider(
  (ref) => Dio()
    ..options = BaseOptions(
      // this is for checking valid status of dio requests
      // if they match any of these then there'll be no error
      validateStatus: (status) =>
          status != null && status >= 200 && status < 400,
    )
    ..interceptors.add(
      ref.read(oAuth2InterceptorProvider),
    ),
);

// ****************************************** //

final youtubeServiceP = Provider(
  (ref) => YoutubeService(
    ref.watch(dioP),
  ),
);

final authYoutubeServiceP = Provider(
  (ref) => AuthYoutubeService(
    ref.watch(authDioP),
  ),
);

// ****************************************** //

final selectedVideoSP = StateProvider<Video?>((ref) => null);

final miniPlayerControllerP = Provider.autoDispose(
  (ref) => MiniplayerController(),
);

final showSearchSP = StateProvider((ref) => false);

final fullScreenPressedSP = StateProvider((ref) => false);

// ****************************************** //

final commentsPressedSP = StateProvider((ref) => false);

final subscriptionSNP =
    StateNotifierProvider.autoDispose<SubscriptionNotifier, AsyncValue<bool>>(
  (ref) => SubscriptionNotifier(
    ref,
    ref.watch(authYoutubeServiceP),
  ),
);

final ratingFP = FutureProvider.autoDispose.family(
  (ref, Video video) async {
    final authService = ref.read(authYoutubeServiceP);
    final authState = ref.watch(authNP);
    final rating =
        await authService.getVideoRating(video.id, authState: authState);
    await ref
        .read(subscriptionSNP.notifier)
        .getSubscriptionState(channelId: video.snippet.channelId);

    return rating;
  },
);

// ****************************************** //

final connectivitySNP =
    StateNotifierProvider.autoDispose<ConnectivityNotifier, ConnectivityState>(
  (ref) => ConnectivityNotifier(),
);

final scrollControllerP = Provider.autoDispose((ref) => ScrollController());

// * default may very well be null, but for now i'll make it 0
final currentScreenIndexSP = StateProvider((ref) => 0);

// TODO get rid of this and make a mapped sp for all the screen
final pushedHomeChannelSP = StateProvider((ref) => false);

final selectedCategoryIdSP = StateProvider((ref) => 0);

// ****************************************** //

final videosNPOld =
    StateNotifierProvider.autoDispose<VideosNotifierOld, BaseInfoState<Video>>(
  (ref) => VideosNotifierOld(
    ref,
    ref.watch(youtubeServiceP),
    ref.watch(authYoutubeServiceP),
  ),
);

final videoDetailsNP = StateNotifierProvider.autoDispose<VideoInfoNotifier,
    AsyncValue<VideoDetails>>(
  (ref) => VideoInfoNotifier(
    ref,
    ref.watch(youtubeServiceP),
    ref.watch(authYoutubeServiceP),
  ),
);

final videoCategoryNP = StateNotifierProvider.autoDispose<
    VideoCategoriesNotifier, AsyncValue<List<VideoCategory>>>(
  (ref) => VideoCategoriesNotifier(
    ref.watch(youtubeServiceP),
  ),
);

final ratingSNP = StateNotifierProvider.autoDispose<RatingNotifierOld,
    AsyncValue<RatingState>>(
  (ref) => RatingNotifierOld(
    ref,
    ref.watch(authYoutubeServiceP),
  ),
);

final commentsSNP = StateNotifierProvider.autoDispose<CommentInfoNotifier,
    BaseInfoState<Comment>>(
  (ref) => CommentInfoNotifier(
    ref.watch(youtubeServiceP),
  ),
);

final uploadsNotifierProvider =
    StateNotifierProvider.autoDispose<UploadsNotifier, AsyncValue<Uploads>>(
  (ref) => UploadsNotifier(
    ref.watch(youtubeServiceP),
  ),
);

final shortsOldNP =
    StateNotifierProvider.autoDispose<ShortsNotifierOld, BaseInfoState<Video>>(
  (ref) => ShortsNotifierOld(
    ref.watch(youtubeServiceP),
    ref.watch(authYoutubeServiceP),
  ),
);

final channelPlaylistsNotifierProvider = StateNotifierProvider.autoDispose<
    ChannelPlaylistsNotifierOld, AsyncValue<List<Playlist>?>>(
  (ref) => ChannelPlaylistsNotifierOld(
    ref.watch(youtubeServiceP),
  ),
);

final playlistVideosNotifierProvider = StateNotifierProvider.autoDispose<
    PlaylistVideosNotifier, BaseInfoState<Video>>(
  (ref) => PlaylistVideosNotifier(
    ref.watch(youtubeServiceP),
  ),
);

final communityPostsNotifierProvider = StateNotifierProvider.autoDispose<
    CommunityPostsNotifier, AsyncValue<List<CommunityPost>>>(
  (ref) => CommunityPostsNotifier(
    ref.watch(youtubeServiceP),
  ),
);

// ****************************************** //

final sembastP = Provider(
  (ref) => SembastDatabase(),
);

final searchHistoryRepositoryP = Provider(
  (ref) => SearchHistoryRepository(
    ref.watch(sembastP),
  ),
);

final searchHistorySNP =
    StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>(
  (ref) => SearchHistoryNotifier(
    ref.watch(searchHistoryRepositoryP),
  ),
);

// *********** these are unauth providers ******************

final ytExplodeP = Provider(
  (ref) => explode.YoutubeExplode(),
);

// * not sure i need to use provider here, but whatever
final videoQualityFP = FutureProvider.autoDispose
    .family<Set<explode.VideoQuality>, explode.VideoId>(
  (ref, videoUrl) async {
    final ytExplode = ref.watch(ytExplodeP);
    final manifest = await ytExplode.videos.streamsClient.getManifest(videoUrl);
    log('manifest: $manifest');
    final videoQualities = manifest.muxed.getAllVideoQualities();
    log('video: $videoQualities');
    return videoQualities;
  },
);

Future<Set<explode.VideoQuality>> getVideoQualities(
  explode.VideoId videoUrl,
) async {
  final ytExplode = explode.YoutubeExplode();
  final manifest = await ytExplode.videos.streamsClient.getManifest(videoUrl);
  log('manifest: $manifest');
  final videoQualities = manifest.muxed.getAllVideoQualities();
  log('video: $videoQualities');
  return videoQualities;
}
