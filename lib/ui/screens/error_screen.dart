import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';

class ErrorScreen extends ConsumerWidget {
  final int index;
  final YoutubeFailure failure;
  final VoidCallback onError;

  const ErrorScreen({
    super.key,
    required this.index,
    required this.failure,
    required this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            ChannelSliverAppbar(index: index),
          ],
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TODO delete this and use ifs like on channel tabs
                const Text('Error happened:'),
                const SizedBox(height: 10),
                Text(
                  failure.when(
                    // TODO handle null here
                    (failureData) => failure.failureData.message.toString(),
                    noConnection: (failureData) => failureData.message != null
                        ? failureData.message!
                        : 'No internet connection',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onBackground,
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onPressed: onError,
                  child: const Text('tap to retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
