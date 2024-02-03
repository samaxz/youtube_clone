import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';

import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/bodies/common_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/lib_screen_body.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_videos_screen.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO remove this
    // ref.listen(pushedScreensCNP, (_, state) {
    //   if (!state.shouldPush[4]!) return;
    //
    //   Navigator.of(context)
    //       .push(
    //         MaterialPageRoute(
    //           builder: (context) => state.screens[4]!.last.screen,
    //         ),
    //       )
    //       .whenComplete(
    //         () => state.removeLastScreen(4),
    //       );
    // });

    ref.listen(screensManagerProvider(4), (_, state) {
      final notifier = ref.read(screensManagerProvider(4).notifier);

      if (!notifier.shouldPush) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });

    // final scrollController = ref.watch(libScrollControllerP);

    return const CommonBody(
      index: 4,
      // scrollController: scrollController,
      // body: LibScreenBody(),
    );
  }
}
