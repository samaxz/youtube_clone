// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/bodies/common_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/home_screen_body.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO uncomment this in case i need it
    // ref.listen(pushedScreensCNP, (_, state) {
    //   if (!state.shouldPush[0]!) return;
    //
    //   Navigator.of(context)
    //       .push(
    //         MaterialPageRoute(
    //           builder: (context) => state.screens[0]!.last.screen,
    //         ),
    //       )
    //       .whenComplete(
    //         () => state.removeLastScreen(0),
    //       );
    // });

    ref.listen(screensManagerProvider(0), (_, state) {
      final notifier = ref.read(screensManagerProvider(0).notifier);

      if (!notifier.shouldPush) return;

      // log('new screen got pushed from home screen');

      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });

    // final scrollController = ref.watch(homeScrollControllerP);

    return const CommonBody(
      index: 0,
      // displayExpandedHeight: true,
      // scrollController: scrollController,
      // body: const HomeScreenBody(),
    );
  }
}
