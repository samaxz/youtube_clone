import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_notifier.dart';
import 'package:youtube_clone/logic/services/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/screens/channel_screen.dart';
import 'package:youtube_clone/ui/screens/playlist_screen.dart';
import 'package:youtube_clone/ui/widgets/bodies/home_screen_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';

part 'screens_manager.g.dart';

@riverpod
class ScreensManager extends _$ScreensManager {
  @override
  List<CustomScreen> build(int screenIndex) {
    return [
      screenIndex == 1 ? const CustomScreen.initialShort() : const CustomScreen.initial(),
    ];
  }

  bool shouldPush = false;

  void pushScreen(
    CustomScreen customScreen, {
    // this is used for search screen
    bool shouldPushNewScreen = true,
  }) {
    // shouldPush = true;
    shouldPush = shouldPushNewScreen;
    // log('pushScreen() got called');
    ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.min);

    // i can compare just id, no need to compare the entire class
    // if (state.isNotEmpty && state.last.screenTypeAndId == customScreen.screenTypeAndId) return;
    if (state.last.screenTypeAndId == customScreen.screenTypeAndId) return;

    state = List.from(state)..add(customScreen);

    log('screens manager state after pushing: $state');
  }

  void popScreen() {
    shouldPush = false;

    if (state.last.screenTypeAndId.screenType == ScreenType.channel) {
      ref.read(channelInfoNotifierProvider(screenIndex).notifier).removeLast();
    }
    // TODO remove data from other notifiers here too

    state = List.from(state)..removeLast();

    log('screens manager state after popping: $state');
  }
}
