import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/services/oauth2/auth_failure.dart';
import 'package:youtube_demo/services/oauth2/authenticator.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';

part 'auth_notifier.g.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = Initial;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.failure(AuthFailure authFailure) = FailureAuthState;
}

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

// TODO use this instead of the outdated notifier below
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const Initial();
  }

  late YoutubeAuthenticator authenticator =
      ref.read(youtubeAuthenticatorProvider);

  Future<void> checkAndUpdateAuthStatus() async {
    state = (await authenticator.isSignedIn())
        ? const Authenticated()
        : const Unauthenticated();
    // log('now auth state is: $state');
  }

  Future<AuthState> getAuthState() async {
    state = (await authenticator.isSignedIn())
        ? const Authenticated()
        : const Unauthenticated();

    return state;
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = authenticator.createGrant();

    final redirectUrl = await authorizationCallback(
      authenticator.getAuthorizationUrl(grant),
    );

    final failureOrSuccess = await authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );

    state = failureOrSuccess.fold(
      (l) => FailureAuthState(l),
      (r) => const Authenticated(),
    );

    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await authenticator.signOut();

    state = failureOrSuccess.fold(
      (l) => FailureAuthState(l),
      (r) => const Unauthenticated(),
    );
  }
}

// TODO probably delete this in the future
@deprecated
class AuthNotifierOld extends StateNotifier<AuthState> {
  final Ref _ref;
  final YoutubeAuthenticator _authenticator;

  AuthNotifierOld(
    this._ref,
    this._authenticator,
  ) : super(
          const AuthState.initial(),
        );

  Future<void> checkAndUpdateAuthStatus() async {
    if (!mounted) return;

    state = (await _authenticator.isSignedIn())
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = _authenticator.createGrant();
    final redirectUrl = await authorizationCallback(
      _authenticator.getAuthorizationUrl(grant),
    );

    final failureOrSuccess = await _authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );

    state = failureOrSuccess.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.authenticated(),
    );

    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();

    state = failureOrSuccess.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.unauthenticated(),
    );
  }
}
