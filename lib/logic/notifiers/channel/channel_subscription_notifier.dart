import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';

part 'channel_subscription_notifier.g.dart';

// this is used for all screens, except for miniplayer screen
@riverpod
class ChannelSubscriptionNotifier extends _$ChannelSubscriptionNotifier {
  @override
  List<AsyncValue<bool>> build({
    required int screenIndex,
    required String channelId,
  }) {
    return [
      const AsyncLoading(),
    ];
  }

  // TODO use this in the future
  // void setFailureState(YoutubeFailure failure) {}

  // TODO change this in the future
  // this could also be used inside changeSubscriptionState()
  late bool shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;

  late AuthYoutubeService authService = ref.read(authYoutubeServiceP);
  // i think i could be watching the state inside build and then assign
  // a local variable to it
  late AuthState authState = ref.read(authNotifierProvider);

  Future<void> getSubscriptionState({bool isReloading = false}) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    // TODO change this in the future
    // final shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;

    if (shouldSkip) {
      // here, i could take the error from video details notifier and
      // put it here
      state.last = const AsyncError(
        'Error loading data',
        StackTrace.empty,
      );

      return;
    }

    final subscribed = await authService.subscribed(
      channelId: channelId,
      authState: authState,
    );

    state.last = AsyncData(subscribed);

    state = List.from(state);
  }

  // TODO add no inet connection here and handle other exceptions, cause
  // of the problems - see above
  Future<void> changeSubscriptionState() async {
    if (authState == const Authenticated()) {
      state.last = const AsyncData(true);

      final result = await authService.changeSubscription(
        channelId: channelId,
        authState: authState,
      );
      // TODO update notifier here for showing snack-bar if the result is negative

      state.last = AsyncData(result);

      state = List.from(state);
    } else if (authState == const Unauthenticated()) {
      ref.read(unauthAttemptSP.notifier).update((state) => true);
    }
  }
}
