import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/rating_state.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_details_notifier.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'shorts_rating_notifier.g.dart';

// this notifier is used inside the short body player screens
@riverpod
class ShortsRatingNotifier extends _$ShortsRatingNotifier {
  @override
  List<AsyncValue<RatingState>> build({
    required String videoId,
    required int screenIndex,
  }) {
    return [
      const AsyncLoading(),
    ];
  }

  late AuthYoutubeService authService = ref.read(authYoutubeServiceP);
  late AuthState authState = ref.read(authNotifierProvider);

  Future<void> getVideoRating() async {
    final rating = await AsyncValue.guard(
      () => authService.getVideoRating(
        videoId: videoId,
        authState: authState,
      ),
    );

    final shortsDetailsNot = ref.read(shortsDetailsNotifierProvider(screenIndex).notifier);

    state = [
      ...state,
      rating
        ..maybeWhen(
          orElse: () {
            shortsDetailsNot.shouldSkip = false;
          },
          error: (error, stackTrace) {
            shortsDetailsNot.shouldSkip = true;
            shortsDetailsNot.setFailureState();
          },
        ),
    ];
  }

  Future<void> like() async {
    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        state = [
          ...state,
          AsyncValue.data(
            await authService.likeVideo(videoId: videoId, authState: authState),
          ),
        ];
      },
      unauthenticated: () {
        ref.read(unauthAttemptSP.notifier).update((state) => true);
      },
    );
  }

  Future<void> dislike() async {
    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        state = [
          ...state,
          AsyncValue.data(
            await authService.dislikeVideo(
              videoId: videoId,
              authState: authState,
            ),
          ),
        ];
      },
      unauthenticated: () {
        ref.read(unauthAttemptSP.notifier).update((state) => true);
      },
    );
  }
}
