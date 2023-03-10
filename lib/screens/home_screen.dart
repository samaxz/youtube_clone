// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/services/notifiers/pushed_screens_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_demo/widgets/bodies/common_body.dart';
import 'package:youtube_demo/widgets/bodies/home_screen_body.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(pushedScreensCNP, (_, state) {
      if (!state.shouldPush[0]!) return;

      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => state.screens[0]!.last.screenAndData.screen,
            ),
          )
          .whenComplete(
            () => state.removeLastScreen(0),
          );
    });

    return const CommonBody(
      displayExpandedHeight: true,
      body: HomeScreenBody(),
      index: 0,
    );
  }
}
