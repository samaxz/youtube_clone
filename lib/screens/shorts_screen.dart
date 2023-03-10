import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/notifiers/shorts_notifier.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body.dart';

class ShortsScreen extends ConsumerWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shorts = ref.watch(shortsNotifierProvider)[1]!.last;

    ref.listen(pushedScreensCNP, (_, state) {
      if (!state.shouldPush[1]!) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => state.screens[1]!.last.screenAndData.screen,
            ),
          )
          .whenComplete(
            () => state.removeLastScreen(1),
          );
    });

    return ShortsBody(
      index: 1,
      backButtonOn: false,
      shorts: shorts,
      onLoadVideos: () {
        final notifier = ref.read(shortsNotifierProvider.notifier);
        notifier.getShorts();
      },
      onError: () {
        final notifier = ref.read(shortsNotifierProvider.notifier);
        notifier.getShorts();
      },
    );
  }
}
