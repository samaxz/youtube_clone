import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_notifier.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';

class ShortsScreen extends ConsumerWidget {
  const ShortsScreen({super.key});

  Future<void> getShorts(WidgetRef ref) async {
    final notifier = ref.read(shortsNotifierProvider(1).notifier);
    await notifier.getShorts();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO remove this
    // ref.listen(pushedScreensCNP, (_, state) {
    //   if (!state.shouldPush[1]!) return;
    //
    //   Navigator.of(context)
    //       .push(
    //         MaterialPageRoute(
    //           builder: (context) => state.screens[1]!.last.screen,
    //         ),
    //       )
    //       .whenComplete(
    //         () => state.removeLastScreen(1),
    //       );
    // });

    ref.listen(screensManagerProvider(1), (_, state) {
      final notifier = ref.read(screensManagerProvider(1).notifier);

      if (!notifier.shouldPush) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });

    final shorts = ref.watch(shortsNotifierProvider(1)).last;

    return ShortsBody(
      screenIndex: 1,
      backButtonOn: false,
      shorts: shorts,
      onLoadVideos: () => getShorts(ref),
      onError: () => getShorts(ref),
    );
  }
}
