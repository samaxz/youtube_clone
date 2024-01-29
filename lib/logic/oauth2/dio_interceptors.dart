import 'package:dio/dio.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/oauth2/authenticator.dart';

class OAuth2Interceptor extends Interceptor {
  final YoutubeAuthenticator _authenticator;
  final AuthNotifier _authNotifier;
  final Dio _dio;

  const OAuth2Interceptor(
    this._authenticator,
    this._authNotifier,
    this._dio,
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // if credentials are null, then the user isn't signed in
    final credentials = await _authenticator.getSignedInCredentials();

    final modifiedOptions = options
      ..headers.addAll(
        credentials == null
            ? {}
            : {
                'Authorization': 'Bearer ${credentials.accessToken}',
                // dk why i added these 2 lines, but, whatever
                'Accept': 'application/json; charset=UTF-8',
                'Content-Type': 'application/json',
              },
      );

    handler.next(modifiedOptions);
  }

  // making an interceptor for invalid token if an error happens in a request
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final errorResponse = err.response;

    if (err.type == DioExceptionType.connectionError) {
      handler.next(err);
    }

    if (errorResponse != null && errorResponse.statusCode == 401) {
      // getting the credentials and updating them if the user has internet
      final credentials = await _authenticator.getSignedInCredentials();

      // refreshing won't work in my case - instead, i should do sign-out
      credentials != null && credentials.canRefresh
          ? await _authenticator.refresh(credentials)
          : await _authenticator.clearCredentialsStorage();

      await _authNotifier.checkAndUpdateAuthStatus();

      final refreshedCredentials = await _authenticator.getSignedInCredentials();

      if (refreshedCredentials != null) {
        handler.resolve(
          await _dio.fetch(
            errorResponse.requestOptions
              ..headers['Authorization'] = 'Bearer ${refreshedCredentials.accessToken}',
          ),
        );
      }
    } else {
      handler.next(err);
    }
  }
}
