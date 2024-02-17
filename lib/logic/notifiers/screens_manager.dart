import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/search_items_notifier.dart';
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
    // this param, when set to false, is used for search screen
    bool shouldPushNewScreen = true,
  }) {
    shouldPush = shouldPushNewScreen;
    ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.min);
    if (state.last.screenTypeAndId == customScreen.screenTypeAndId) return;
    state = List.from(state)..add(customScreen);
    // log('screens manager state after pushing: $state');
  }

  void popScreen() {
    // to prevent removing state when pressing back arrow inside search delegate
    if (state.length == 1) return;
    shouldPush = false;
    if (state.last.screenTypeAndId.screenType == ScreenType.channel) {
      ref.read(channelInfoNotifierProvider(screenIndex).notifier).removeLast();
    } else if (state.last.screenTypeAndId.screenType == ScreenType.search) {
      ref.read(searchItemsNotifierProvider(screenIndex).notifier).removeLast();
    }
    // TODO remove data from other notifiers here too
    state = List.from(state)..removeLast();
    // log('screens manager state after popping: $state');
  }
}
