import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/screens/authorization_screen.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/notifiers/subscription_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_demo/widgets/bodies/common_body.dart';
import 'package:youtube_demo/widgets/failure_tile.dart';
import 'package:youtube_demo/widgets/shimmers/loading_videos_screen.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subs = ref.watch(subscriptionsProvider);

    ref.listen(pushedScreensCNP, (_, state) {
      if (!state.shouldPush[4]!) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => state.screens[4]!.last.screenAndData.screen,
            ),
          )
          .whenComplete(
            () => state.removeLastScreen(4),
          );
    });

    return CommonBody(
      index: 4,
      // TODO put this in a separate widget
      body: subs.when(
        data: (data) {
          if (!data.authenticated) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'oops, looks like you`re unauthorized, so the list is empty',
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authNP.notifier).signIn(
                        (authorizationUrl) {
                          final completer = Completer<Uri>();
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => AuthorizationScreen(
                                authorizationUrl: authorizationUrl,
                                onAuthorizationCodeRedirectAttempt:
                                    (redirectedUrl) {
                                  completer.complete(redirectedUrl);
                                },
                              ),
                            ),
                          );

                          return completer.future;
                        },
                      );

                      if (!context.mounted) return;

                      Navigator.of(context).popUntil((route) => route.isFirst);

                      ref
                          .read(pushedHomeChannelSP.notifier)
                          .update((state) => false);
                    },
                    child: const Text('authorize'),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('this is a work in progress'),
          );
        },
        error: (error, stackTrace) => FailureTile(
          failure: error as YoutubeFailure,
          onTap: () => ref.read(subscriptionsProvider),
        ),
        loading: () => const LoadingVideosScreen(),
      ),
    );
  }
}
