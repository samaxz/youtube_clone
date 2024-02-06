import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/screens/miniplayer_screen.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';

final playerExpandProgressVN = ValueNotifier<double>(60);

class CustomMiniplayer extends ConsumerStatefulWidget {
  final Video? video;

  const CustomMiniplayer({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomMiniplayerState();
}

class _CustomMiniplayerState extends ConsumerState<CustomMiniplayer> {
  static const double playerMinHeight = 60;
  late double playerMaxHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    playerMaxHeight = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    log('dispose() got called inside custom miniplayer`s state');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final miniplayerController = ref.watch(miniPlayerControllerP);

    return Miniplayer(
      valueNotifier: playerExpandProgressVN,
      onDismissed: () {
        // without this, the mp doesn't dismiss
        ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.dismiss);
        ref.read(selectedVideoSP.notifier).update((state) => null);
        // log('onDismissed() got called inside custom miniplayer`s state');
      },
      controller: miniplayerController,
      minHeight: playerMinHeight,
      maxHeight: playerMaxHeight,
      builder: (height, percentage) {
        if (widget.video == null) return const SizedBox();

        return MiniplayerScreen(
          height: height,
          percentage: percentage,
          video: widget.video!,
        );
      },
    );
  }
}
