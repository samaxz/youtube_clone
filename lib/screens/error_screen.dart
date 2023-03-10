import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/widgets/channel/channel_sliver_appbar.dart';

class ErrorScreen extends ConsumerWidget {
  final YoutubeFailure failure;
  final VoidCallback onError;

  const ErrorScreen({
    super.key,
    required this.failure,
    required this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentScreenIndexSP);

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
                const Text('Error happened:'),
                const SizedBox(height: 10),
                Text(
                  failure.when(
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
                  child: const Text('Tap to retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
