import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show ScrollController;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_category_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/comment_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/connectivity_notifier.dart';
import 'package:youtube_clone/logic/notifiers/playlist_videos_notifier.dart';
import 'package:youtube_clone/logic/notifiers/search_history_notifier.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/video_category_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/oauth2/providers.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/services/common_classes.dart';
import 'package:youtube_clone/logic/services/search_history_repository.dart';
import 'package:youtube_clone/logic/services/sembast_database.dart';
import 'package:youtube_clone/logic/services/service_interceptor.dart';
import 'package:youtube_clone/logic/services/youtube_service.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

final dioP = Provider(
  (ref) => Dio(
    BaseOptions(
      // this is a temporary solution to the 404 exception
      validateStatus: (code) => code != null && code >= 200 && code < 400 || code == 404,
    ),
  ),
  // ..interceptors.add(
  //   InterceptorsWrapper(
  //     onError: (exception, handler) {
  //       log('onError() fired inside InterceptorsWrapper');
  //
  //       // handler.reject(exception);
  //       // handler.next(exception);
  //       // if (exception.response != null) handler.resolve(exception.response!);
  //     },
  //   ),
  // ),
  // TODO delete this
  // ..interceptors.add(
  //   ref.read(serviceInterceptorProvider),
  // ),
);

final authDioP = Provider(
  (ref) => Dio()
    ..options = BaseOptions(
      // this is for checking valid status of dio requests
      // if they match any of these then there'll be no error
      validateStatus: (status) => status != null && status >= 200 && status < 400,
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

// this is of type map, so that i know what screens
// are currently showing the search
// TODO get rid of the family and ints index
// UPD nope, looks like it can't function without family arg
final isShowingSearchSP = StateProvider.family<bool, int>(
  // (ref, index) => {
  //   0: false,
  //   1: false,
  //   3: false,
  //   4: false,
  // },
  (ref, screenIndex) => false,
);

// final fullScreenPressedSP = StateProvider((ref) => false);

// ****************************************** //

// final commentsPressedSP = StateProvider((ref) => false);

// TODO make this a family provider for each video and short - make
// its param based off of (video (short) id) channel id of the video/short
// final subscriptionSNP = StateNotifierProvider.autoDispose<SubscriptionNotifier, AsyncValue<bool>>(
//   (ref) => SubscriptionNotifier(
//     ref,
//     ref.watch(authYoutubeServiceP),
//   ),
// );

// this is rating for the selected video in the miniplayer
// TODO make this usable for both video inside the mp (and shorts),
// not possible with shorts, cause they are a list
// UPD wtf is this anyway?
final ratingFP = FutureProvider.autoDispose.family(
  (ref, Video video) async {
    final authService = ref.read(authYoutubeServiceP);
    final authState = ref.read(authNotifierProvider);
    final rating = await authService.getVideoRating(
      videoId: video.id,
      authState: authState,
    );
    // await ref
    //     .read(subscriptionSNP.notifier)
    //     .getSubscriptionState(channelId: video.snippet.channelId);

    return rating;
  },
);

// ****************************************** //

final connectivitySNP = StateNotifierProvider.autoDispose<ConnectivityNotifier, ConnectivityState>(
  (ref) => ConnectivityNotifier(),
);

// this is used for bottom nav bar to scroll all the way
// to the top when user clicks on a bottom nav bar item
final homeScrollControllerP = Provider.autoDispose(
  (ref) => ScrollController(),
);

final subsScrollControllerP = Provider.autoDispose(
  (ref) => ScrollController(),
);

final libScrollControllerP = Provider.autoDispose(
  (ref) => ScrollController(),
);

// default may very well be null, but for now i'll make it 0
final currentScreenIndexSP = StateProvider((ref) => 0);

// TODO get rid of this and make a mapped sp for all the screen
// final pushedHomeChannelSP = StateProvider((ref) => false);

// final selectedCategoryIdSP = StateProvider((ref) => 0);

// ****************************************** //

// final videosNPOld = StateNotifierProvider.autoDispose<VideosNotifierOld, BaseInfoState<Video>>(
//   (ref) => VideosNotifierOld(
//     ref,
//     ref.watch(youtubeServiceP),
//     ref.watch(authYoutubeServiceP),
//   ),
// );

// final videoDetailsNP =
//     StateNotifierProvider.autoDispose<VideoInfoNotifierOld, AsyncValue<VideoDetails>>(
//   (ref) => VideoInfoNotifierOld(
//     ref,
//     ref.watch(youtubeServiceP),
//     ref.watch(authYoutubeServiceP),
//   ),
// );

// final videoCategoryNP =
//     StateNotifierProvider.autoDispose<VideoCategoriesNotifier, AsyncValue<List<VideoCategory>>>(
//   (ref) => VideoCategoriesNotifier(
//     ref.watch(youtubeServiceP),
//   ),
// );

// final ratingSNP = StateNotifierProvider.autoDispose<RatingNotifierOld, AsyncValue<RatingState>>(
//   (ref) => RatingNotifierOld(
//     ref,
//     ref.watch(authYoutubeServiceP),
//   ),
// );

// TODO add family modifier
final commentsSNP = StateNotifierProvider.autoDispose<CommentInfoNotifier, BaseInfoState<Comment>>(
  (ref) => CommentInfoNotifier(
    ref.watch(youtubeServiceP),
  ),
);

// final uploadsNotifierProvider =
//     StateNotifierProvider.autoDispose<UploadsNotifier, AsyncValue<Uploads>>(
//   (ref) => UploadsNotifier(
//     ref.watch(youtubeServiceP),
//   ),
// );

final playlistVideosNotifierProvider =
    StateNotifierProvider.autoDispose<PlaylistVideosNotifier, BaseInfoState<Video>>(
  (ref) => PlaylistVideosNotifier(
    ref.watch(youtubeServiceP),
  ),
);

// final communityPostsNotifierProvider =
//     StateNotifierProvider.autoDispose<CommunityPostsNotifier, AsyncValue<List<CommunityPost>>>(
//   (ref) => CommunityPostsNotifier(
//     ref.watch(youtubeServiceP),
//   ),
// );

// ****************************************** //

final sembastP = Provider(
  (ref) => SembastDatabase(),
);

final searchHistoryRepositoryP = Provider(
  (ref) => SearchHistoryRepository(
    ref.watch(sembastP),
  ),
);

final searchHistorySNP = StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>(
  (ref) => SearchHistoryNotifier(
    ref.watch(searchHistoryRepositoryP),
  ),
);

final ytExplodeP = Provider(
  (ref) => explode.YoutubeExplode(),
);

// not sure i need to use provider here, but whatever
final videoQualityFP =
    FutureProvider.autoDispose.family<Set<explode.VideoQuality>, explode.VideoId>(
  (ref, videoUrl) async {
    final ytExplode = ref.read(ytExplodeP);
    final manifest = await ytExplode.videos.streamsClient.getManifest(videoUrl);
    // log('manifest: $manifest');
    final videoQualities = manifest.muxed.getAllVideoQualities();
    // log('video: $videoQualities');

    return videoQualities;
  },
);

// Future<Set<explode.VideoQuality>> getVideoQualities(
//   explode.VideoId videoUrl,
// ) async {
//   final ytExplode = explode.YoutubeExplode();
//   final manifest = await ytExplode.videos.streamsClient.getManifest(videoUrl);
//   // log('manifest: $manifest');
//   final videoQualities = manifest.muxed.getAllVideoQualities();
//   // log('video: $videoQualities');
//
//   return videoQualities;
// }

final sharedPrefsP = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final showOptionsSP = StateProvider<ShowOptions>((ref) => const Neither());

final unauthAttemptSP = StateProvider((ref) => false);

final selectedShortSP = StateProvider((ref) => false);

final dismissSP = StateProvider((ref) => false);
