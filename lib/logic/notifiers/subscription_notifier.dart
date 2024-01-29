// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/subscription_model.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/auth_youtube_service.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'subscription_notifier.g.dart';

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

// this is for checking if the user is subbed to the channel or not
// (this'll be used inside the mp, shorts and channel screens)
// this'll be used on all sorts of screens
// based on the provided channel id, the user is either subbed or not
// to the channel
// this is used for the miniplayer screen
@riverpod
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  List<AsyncValue<bool>> build(String channelId) {
    return [
      const AsyncLoading(),
    ];
  }

  // late bool shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;

  late AuthYoutubeService authService = ref.read(authYoutubeServiceP);
  // i think i could be watching the state inside build and then assign
  // a local variable to it
  late AuthState authState = ref.read(authNotifierProvider);

  Future<void> getSubscriptionState({bool isReloading = false}) async {
    log('getSubscriptionState() got called');

    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    final shouldSkip = ref.read(videoDetailsNotifierProvider.notifier).shouldSkip;

    if (shouldSkip) {
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

  Future<void> changeSubscriptionState() async {
    authState.maybeWhen(
      orElse: () {},
      authenticated: () async {
        state.last = const AsyncLoading();

        state.last = AsyncData(
          await authService.changeSubscription(
            channelId: channelId,
            authState: authState,
          ),
        );

        state = List.from(state);
      },
      unauthenticated: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
    );
  }
}

// TODO delete this
// class SubscriptionNotifier extends StateNotifier<AsyncValue<bool>> {
//   final Ref _ref;
//   final AuthYoutubeService _authService;
//
//   SubscriptionNotifier(
//     this._ref,
//     this._authService,
//   ) : super(
//           const AsyncValue.loading(),
//         );
//
//   bool _isLoading = false;
//
//   late final authState = _ref.read(authNotifierProvider);
//
//   Future<void> getSubscriptionState({
//     required String channelId,
//   }) async {
//     if (_isLoading) return;
//
//     _isLoading = true;
//
//     final subscribed = await _authService.subscribed(
//       channelId: channelId,
//       authState: authState,
//     );
//
//     if (!mounted) return;
//
//     state = AsyncData(subscribed);
//
//     _isLoading = false;
//   }
//
//   Future<void> changeSubscriptionState(String channelId) async {
//     authState.maybeWhen(
//       orElse: () {},
//       authenticated: () async {
//         if (!mounted) return;
//
//         state = AsyncValue.data(
//           await _authService.changeSubscription(
//             channelId,
//             state.value!,
//             authState: authState,
//           ),
//         );
//       },
//       unauthenticated: () => _ref.read(unauthAttemptSP.notifier).update((state) => true),
//     );
//   }
// }
