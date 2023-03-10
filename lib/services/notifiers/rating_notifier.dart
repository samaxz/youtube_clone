import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/screens/nav_screen.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

part 'rating_notifier.freezed.dart';
part 'rating_notifier.g.dart';

@freezed
class RatingState with _$RatingState {
  const RatingState._();

  const factory RatingState.neither() = Neither;
  const factory RatingState.liked() = Liked;
  const factory RatingState.disliked() = Disliked;
}

@riverpod
class RatingNotifier extends _$RatingNotifier {
  @override
  AsyncValue<RatingState> build() {
    return const AsyncLoading();
  }

  late final authService = ref.read(authYoutubeServiceP);

  Future<void> getVideoRating({required String videoId}) async {
    final authState = ref.read(authNP);

    state = await AsyncValue.guard(
      () => authService.getVideoRating(
        videoId,
        authState: authState,
      ),
    );
  }
}

@deprecated
class RatingNotifierOld extends StateNotifier<AsyncValue<RatingState>> {
  final Ref _ref;
  final AuthYoutubeService _authService;

  RatingNotifierOld(
    this._ref,
    this._authService,
  ) : super(
          const AsyncValue.loading(),
        );

  bool _isLoading = false;

  Future<void> getVideoRating({required String videoId}) async {
    if (_isLoading) return;

    _isLoading = true;

    final authState = _ref.watch(authNP);

    final rating = await _authService.getVideoRating(
      videoId,
      authState: authState,
    );

    if (!mounted) return;

    state = rating.when(
      neither: () => const AsyncData(
        RatingState.neither(),
      ),
      liked: () => const AsyncData(
        RatingState.liked(),
      ),
      disliked: () => const AsyncData(
        RatingState.disliked(),
      ),
    );

    _isLoading = false;
  }

  Future<void> like(String videoId) async {
    final authState = _ref.watch(authNP);

    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        if (!mounted) return;

        state = AsyncValue.data(
          await _authService.likeVideo(videoId: videoId, authState: authState),
        );
      },
      unauthenticated: () {
        return _ref.read(unauthAttemptSP.notifier).update((state) => true);
      },
    );
  }

  Future<void> dislike(String videoId) async {
    final authState = _ref.watch(authNP);

    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        if (!mounted) return;

        state = AsyncValue.data(
          await _authService.dislikeVideo(
            videoId: videoId,
            authState: authState,
          ),
        );
      },
      unauthenticated: () {
        return _ref.read(unauthAttemptSP.notifier).update((state) => true);
      },
    );
  }
}
