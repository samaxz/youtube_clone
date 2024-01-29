import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/bodies/common_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/subs_screen_body.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';

class SubsScreen extends ConsumerWidget {
  const SubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(pushedScreensCNP, (_, state) {
    //   if (!state.shouldPush[3]!) return;
    //
    //   Navigator.of(context)
    //       .push(
    //         MaterialPageRoute(
    //           builder: (context) => state.screens[3]!.last.screen,
    //         ),
    //       )
    //       .whenComplete(
    //         () => state.removeLastScreen(3),
    //       );
    // });

    ref.listen(screensManagerProvider(3), (_, state) {
      final notifier = ref.read(screensManagerProvider(3).notifier);

      if (!notifier.shouldPush) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });

    // final scrollController = ref.watch(subsScrollControllerP);

    return const CommonBody(
      index: 3,
      // scrollController: scrollController,
      // body: const SubsScreenBody(),
    );
  }
}
