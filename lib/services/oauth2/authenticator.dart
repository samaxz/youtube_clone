// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:youtube_demo/env/env.dart';
import 'package:youtube_demo/services/common/dio.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/oauth2/auth_failure.dart';
import 'package:youtube_demo/services/oauth2/secure_storage.dart';

class YoutubeAuthenticator {
  final Dio _dio;

  final SecureCredentialsStorage _credentialsStorage;

  const YoutubeAuthenticator(this._dio, this._credentialsStorage);

  static final _clientId = Env.clientId;

  static final _clientSecret = Env.clientSecret;

  static const String _viewYoutubeAccount =
      'https://www.googleapis.com/auth/youtube.readonly';

  static const String _manageYoutubeAccount =
      'https://www.googleapis.com/auth/youtube';

  static const String _manageYoutubeAccountSsl =
      'https://www.googleapis.com/auth/youtube.force-ssl';

  static const List<String> _scopes = [
    _viewYoutubeAccount,
    _manageYoutubeAccount,
    _manageYoutubeAccountSsl,
  ];

  static final _authorizationEndpoint = Uri.parse(
    'https://accounts.google.com/o/oauth2/auth?access_type=offline',
  );

  static final _tokenEndpoint = Uri.parse(
    'https://oauth2.googleapis.com/token',
  );

  static final redirectUrl = Uri.parse('http://localhost:3000/callback');

  // * this method will be called inside on request interceptor when there's no
  // internet connection to make sure that the user is logged in to redirect
  // him to the home screen
  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      final hasInternet = await Helper.hasInternet();

      if (storedCredentials != null && hasInternet) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);

          return failureOrCredentials.fold(
            (l) => null,
            (r) => r,
          );
        }
      }

      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() => getSignedInCredentials().then(
        (credentials) => credentials != null,
      );

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
      _clientId,
      _authorizationEndpoint,
      _tokenEndpoint,
      secret: _clientSecret,
    );
  }

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(
      redirectUrl,
      scopes: _scopes,
    );
  }

  // if signing in is successful, then user data will be saved to
  // the local storage and in the notifier the auth state will
  // be set to authenticated
  // if anything goes wrong, then the state in the notifier will
  // be failure
  Future<Either<AuthFailure, Unit>> handleAuthorizationResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final Client httpClient = await grant.handleAuthorizationResponse(
        queryParams,
      );
      await _credentialsStorage.save(httpClient.credentials);
      return right(unit);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<String?> getAccessToken() =>
      getSignedInCredentials().then((credentials) => credentials?.accessToken);

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final accessToken = await getAccessToken();

      final revocationEndpoint = Uri.parse(
        'https://oauth2.googleapis.com/revoke?token=$accessToken',
      );

      try {
        await _dio.postUri(
          revocationEndpoint,
          options: Options(
            // * don't know if i need this
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
          ),
        );
      } on DioException catch (e) {
        if (e.isNoConnectionError) {
          log('Token not revoked since there`s no internet connection');
        } else {
          log(
            e.toString(),
          );
          rethrow;
        }
      }
      return clearCredentialsStorage();
    } on PlatformException {
      return left(
        const AuthFailure.storage(),
      );
    }
  }

  // clearing credentials
  // deleting access token can result in auth failure
  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(
        const AuthFailure.storage(),
      );
    }
  }

  // refreshing access token whenever user has internet access
  // if access token is outdated, this method will update it
  Future<Either<AuthFailure, Credentials>> refresh(
    Credentials credentials,
  ) async {
    try {
      // * this requires internet connection
      final refreshCredentials = await credentials.refresh(
        identifier: _clientId,
        secret: _clientSecret,
        newScopes: _scopes,
      );
      await _credentialsStorage.save(refreshCredentials);
      return right(refreshCredentials);
    } on AuthorizationException catch (e) {
      return left(
        AuthFailure.server('${e.error}: ${e.description}'),
      );
    } on FormatException {
      return left(
        const AuthFailure.server(),
      );
    } on PlatformException {
      return left(
        const AuthFailure.storage(),
      );
    }
  }
}
