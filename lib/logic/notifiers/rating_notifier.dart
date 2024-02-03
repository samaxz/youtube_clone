import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/rating_state.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'rating_notifier.g.dart';

// this is used for the mp screen
@riverpod
class RatingNotifier extends _$RatingNotifier {
  @override
  AsyncValue<RatingState> build(String videoId) {
    return const AsyncLoading();
  }

  late AuthYoutubeService authService = ref.read(authYoutubeServiceP);
  late AuthState authState = ref.read(authNotifierProvider);

  Future<void> getVideoRating() async {
    final rating = await AsyncValue.guard(
      () => authService.getVideoRating(videoId: videoId, authState: authState),
    );

    final videoDetailsNot = ref.read(videoDetailsNotifierProvider.notifier);

    state = rating
      ..maybeWhen(
        orElse: () {
          videoDetailsNot.shouldSkip = false;
        },
        error: (error, stackTrace) {
          final failure = error as YoutubeFailure;

          videoDetailsNot.shouldSkip = true;
          videoDetailsNot.setFailureState(failure.failureData.message!);
        },
      );
  }

  Future<void> like() async {
    if (authState == const Authenticated()) {
      state = const AsyncData(Liked());

      final likeVideo = await authService.likeVideo(
        videoId: videoId,
        authState: authState,
      );
      // TODO update notifier here for showing snack-bar if the result is negative

      state = AsyncData(likeVideo);
    } else if (authState == const Unauthenticated()) {
      ref.read(unauthAttemptSP.notifier).update((state) => true);
    }
  }

  Future<void> dislike() async {
    if (authState == const Authenticated()) {
      state = const AsyncData(Disliked());

      final dislikeVideo = await authService.dislikeVideo(
        videoId: videoId,
        authState: authState,
      );
      // TODO update notifier here for showing snack-bar if the result is negative

      state = AsyncData(dislikeVideo);
    } else if (authState == const Unauthenticated()) {
      ref.read(unauthAttemptSP.notifier).update((state) => true);
    }
  }
}

// TODO delete deprecated
// @deprecated
// class RatingNotifierOld extends StateNotifier<AsyncValue<RatingState>> {
//   final Ref _ref;
//   final AuthYoutubeService _authService;
//
//   RatingNotifierOld(
//     this._ref,
//     this._authService,
//   ) : super(
//           const AsyncValue.loading(),
//         );
//
//   bool _isLoading = false;
//
//   Future<void> getVideoRating({required String videoId}) async {
//     if (_isLoading) return;
//
//     _isLoading = true;
//
//     final authState = _ref.watch(authNotifierProvider);
//
//     final rating = await _authService.getVideoRating(
//       videoId,
//       authState: authState,
//     );
//
//     if (!mounted) return;
//
//     state = rating.when(
//       neither: () => const AsyncData(
//         RatingState.neither(),
//       ),
//       liked: () => const AsyncData(
//         RatingState.liked(),
//       ),
//       disliked: () => const AsyncData(
//         RatingState.disliked(),
//       ),
//     );
//
//     _isLoading = false;
//   }
//
//   Future<void> like(String videoId) async {
//     final authState = _ref.watch(authNotifierProvider);
//
//     authState.maybeWhen(
//       orElse: () {},
//       authenticated: () async {
//         if (!mounted) return;
//
//         state = AsyncValue.data(
//           await _authService.likeVideo(videoId: videoId, authState: authState),
//         );
//       },
//       unauthenticated: () {
//         return _ref.read(unauthAttemptSP.notifier).update((state) => true);
//       },
//     );
//   }
//
//   Future<void> dislike(String videoId) async {
//     final authState = _ref.watch(authNotifierProvider);
//
//     authState.maybeWhen(
//       orElse: () {},
//       authenticated: () async {
//         if (!mounted) return;
//
//         state = AsyncValue.data(
//           await _authService.dislikeVideo(
//             videoId: videoId,
//             authState: authState,
//           ),
//         );
//       },
//       unauthenticated: () {
//         return _ref.read(unauthAttemptSP.notifier).update((state) => true);
//       },
//     );
//   }
// }
