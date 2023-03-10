// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:youtube_demo/data/models/subscription_model.dart';
import 'package:youtube_demo/screens/nav_screen.dart';
import 'package:youtube_demo/services/common/auth_youtube_service.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

part 'subscription_notifier.g.dart';

class SubState {
  final List<Subscription> subs;
  final bool authenticated;

  const SubState({
    required this.subs,
    required this.authenticated,
  });
}

// * this is for displaying all the subs on the subs screen
@riverpod
Future<SubState> subscriptions(
  SubscriptionsRef ref,
) async {
  final authService = ref.watch(authYoutubeServiceP);
  final authState = ref.watch(authNP);
  SubState state = const SubState(subs: [], authenticated: false);

  return authState.maybeWhen(
    orElse: () => state = const SubState(subs: [], authenticated: false),
    authenticated: () async {
      final subs = await authService.getSubscriptions();
      return state = SubState(subs: subs, authenticated: true);
    },
  );
}

class SubscriptionNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref _ref;
  final AuthYoutubeService _authService;

  SubscriptionNotifier(
    this._ref,
    this._authService,
  ) : super(
          const AsyncValue.loading(),
        );

  bool _isLoading = false;

  late final authState = _ref.watch(authNP);

  Future<void> getSubscriptionState({
    required String channelId,
  }) async {
    if (_isLoading) return;

    _isLoading = true;

    final subscribed = await _authService.subscribed(
      channelId: channelId,
      authState: authState,
    );

    if (!mounted) return;

    state = AsyncData(subscribed);

    _isLoading = false;
  }

  Future<void> changeSubscriptionState(String channelId) async {
    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        if (!mounted) return;

        state = AsyncValue.data(
          await _authService.changeSubscription(
            channelId,
            state.value!,
            authState: authState,
          ),
        );
      },
      unauthenticated: () =>
          _ref.read(unauthAttemptSP.notifier).update((state) => true),
    );
  }
}
