import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show ScrollController;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/info/common_classes.dart';
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/comment_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/connectivity_notifier.dart';
import 'package:youtube_clone/logic/notifiers/search_history_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/oauth2/providers.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/services/search_history_repository.dart';
import 'package:youtube_clone/logic/services/sembast_database.dart';
import 'package:youtube_clone/logic/services/youtube_service.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

final dioP = Provider(
  (ref) => Dio(
    BaseOptions(
      // this is a temporary solution to the 404 exception in logs
      validateStatus: (code) => code != null && code >= 200 && code < 400 || code == 404,
    ),
  ),
);

final authDioP = Provider(
  (ref) => Dio()
    ..options = BaseOptions(
      // this is for checking valid status of dio requests
      // if they match any of these, then there'll be no error
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

// UPD looks like it can't function without family arg
// this is used for hiding bottom nav bar when search suggestions are shown
final isShowingSearchSP = StateProvider.family(
  (ref, int screenIndex) => false,
);

// this is rating for the selected video inside miniplayer
final ratingFP = FutureProvider.autoDispose.family(
  (ref, Video video) async {
    final authService = ref.read(authYoutubeServiceP);
    final authState = ref.read(authNotifierProvider);
    final rating = await authService.getVideoRating(
      videoId: video.id,
      authState: authState,
    );

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

// ************************
// should probably rename it to screenIndexSP
final currentScreenIndexSP = StateProvider((ref) => 0);

// TODO delete this and use generator instead
final commentsSNP = StateNotifierProvider.autoDispose<CommentInfoNotifier, BaseInfoState<Comment>>(
  (ref) => CommentInfoNotifier(
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

final searchHistorySNP = StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>(
  (ref) => SearchHistoryNotifier(
    ref.watch(searchHistoryRepositoryP),
  ),
);

// ************************
final ytExplodeP = Provider(
  (ref) => explode.YoutubeExplode(),
);

// not sure i need to use provider here, but whatever
final videoQualityFP =
    FutureProvider.autoDispose.family<Set<explode.VideoQuality>, explode.VideoId>(
  (ref, videoUrl) async {
    // log('1: start of the future provider');
    final ytExplode = ref.watch(ytExplodeP);
    // log('2: ytExplode has been initialized');
    final manifest = await ytExplode.videos.streamsClient.getManifest(videoUrl);
    // log('3: manifest: $manifest');
    final videoQualities = manifest.muxed.getAllVideoQualities();
    // log('4: video: $videoQualities');

    // ref.onDispose(() { videoQualities.cl});

    // final videoQualities = await getVideoQualities(videoUrl);

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

// *******************
// this'll be initialized inside ProviderScope in main.dart
final sharedPrefsP = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final showOptionsSP = StateProvider<ShowOptions>((ref) => const Neither());

final unauthAttemptSP = StateProvider((ref) => false);
