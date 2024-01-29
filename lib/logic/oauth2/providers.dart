import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/oauth2/authenticator.dart';
import 'package:youtube_clone/logic/oauth2/dio_interceptors.dart';
import 'package:youtube_clone/logic/oauth2/secure_storage.dart';

final dioForAuthProvider = Provider<Dio>(
  (ref) => Dio(),
);

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final oAuth2InterceptorProvider = Provider<OAuth2Interceptor>(
  (ref) => OAuth2Interceptor(
    ref.watch(youtubeAuthenticatorProvider),
    ref.read(authNotifierProvider.notifier),
    ref.watch(dioForAuthProvider),
  ),
);

final credentialsStorageProvider = Provider<SecureCredentialsStorage>(
  (ref) => SecureCredentialsStorage(
    ref.watch(flutterSecureStorageProvider),
  ),
);

final youtubeAuthenticatorProvider = Provider<YoutubeAuthenticator>(
  (ref) => YoutubeAuthenticator(
    ref.watch(dioForAuthProvider),
    ref.watch(credentialsStorageProvider),
  ),
);

// final authNotifierProvider = StateNotifierProvider<AuthNotifierOld, AuthState>(
//   (ref) {
//     return AuthNotifierOld(
//       ref,
//       ref.watch(youtubeAuthenticatorProvider),
//     );
//   },
// );
