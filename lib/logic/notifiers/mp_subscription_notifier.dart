// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/subscription_model.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'mp_subscription_notifier.g.dart';

// subscription state
class SubState {
  final List<Subscription> subs;
  final bool authenticated;

  const SubState({
    required this.subs,
    required this.authenticated,
  });
}

// this is for displaying all the user's subs on the subs screen
@riverpod
Future<SubState> subscriptions(SubscriptionsRef ref) async {
  final authService = ref.read(authYoutubeServiceP);
  final authState = ref.watch(authNotifierProvider);
  late SubState state;

  if (authState == const Unauthenticated()) {
    state = const SubState(subs: [], authenticated: false);
  } else if (authState == const Authenticated()) {
    final subs = await authService.getSubscriptions();
    state = SubState(subs: subs, authenticated: true);
  }

  return state;
}

// this is used for the miniplayer screen
@riverpod
class MiniplayerSubscriptionNotifier extends _$MiniplayerSubscriptionNotifier {
  @override
  AsyncValue<bool> build(String channelId) {
    return const AsyncLoading();
  }

  // late bool shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;

  late AuthYoutubeService authService = ref.read(authYoutubeServiceP);
  // i think i could be watching the state inside build and then assign
  // a local variable to it
  late AuthState authState = ref.read(authNotifierProvider);

  Future<void> getSubscriptionState() async {
    // log('getSubscriptionState() got called');

    state = const AsyncLoading();

    final shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;
    // log('should skip inside subs notifier: $shouldSkip');

    if (shouldSkip) {
      // here, i could take the error from video details notifier and
      // put it here
      state = const AsyncError(
        'Error loading data',
        StackTrace.empty,
      );

      return;
    }

    final subscribed = await authService.subscribed(
      channelId: channelId,
      authState: authState,
    );
    // log('subscribed inside subs notifier is: $subscribed');

    state = AsyncData(subscribed);
    // log('state inside subs notifier is: $state');
  }

  Future<void> changeSubscriptionState() async {
    if (authState == const Authenticated()) {
      state = const AsyncData(true);

      final result = await authService.changeSubscription(
        channelId: channelId,
        authState: authState,
      );
      // TODO update notifier here for showing snack-bar if the result is negative

      state = AsyncData(result);
    } else if (authState == const Unauthenticated()) {
      ref.read(unauthAttemptSP.notifier).update((state) => true);
    }
  }
}
