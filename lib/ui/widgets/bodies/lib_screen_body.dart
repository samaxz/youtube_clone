import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/mp_subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';

class LibScreenBody extends ConsumerWidget {
  const LibScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO change this
    final subs = ref.watch(subscriptionsProvider);
    return subs.when(
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
                  onPressed: () {
                    Helper.authenticate(ref: ref, context: context);
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
      error: (failure, stackTrace) => FailureTile(
        failure: failure as YoutubeFailure,
        onTap: () => ref.read(subscriptionsProvider),
      ),
      loading: () => const LoadingVideosScreen(),
    );
  }
}
