import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_info_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_shorts_notifier.dart';
import 'package:youtube_clone/logic/services/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/pushed_screens_list_notifier.dart';
import 'package:youtube_clone/ui/screens/channel_screen.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body_player.dart';

// TODO delete all of this
// this class'll hold all the pushed screens
// TODO restore this in case something goes wrong
// @Deprecated('Use ScreensManager instead')
// class PushedScreensCNP extends ChangeNotifier {
//   final Ref _ref;
//
//   PushedScreensCNP(this._ref);
//
//   final Map<int, List<CustomScreen>> _screens = {
//     0: [
//       CustomScreen.initial(),
//     ],
//     1: [
//       // added this just for when popping from the shorts
//       // screen so that this'll be be autoplayed
//       CustomScreen.initialShort(),
//     ],
//     3: [
//       CustomScreen.initial(),
//     ],
//     4: [
//       CustomScreen.initial(),
//     ],
//   };
//
//   Map<int, List<CustomScreen>> get screens => _screens;
//
//   final Map<int, bool> _shouldPush = {
//     0: false,
//     1: false,
//     3: false,
//     4: false,
//   };
//
//   Map<int, bool> get shouldPush => _shouldPush;
//
//   Future<void> pushScreen({
//     required int index,
//     required ScreenTypeAndId screenTypeAndId,
//   }) async {
//     final notifier = _ref.read(pushedScreensListNotifierProvider.notifier);
//     notifier.addScreen(newScreen: screenTypeAndId, index: index);
//
//     // not a single other screen should get pushed on a different screen index
//     for (int i = 0; i <= 4; i++) {
//       if (i == 2) continue;
//
//       _shouldPush[i] = false;
//     }
//
//     if (screenTypeAndId.screenType == ScreenType.short) {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: true});
//
//       _screens[index]!.add(
//         CustomScreen(
//           screenTypeAndId: screenTypeAndId,
//           screen: ShortsBody(
//             index: index,
//             shorts: const BaseInfoLoading(),
//             onLoadVideos: () {},
//             onError: () {
//               // this makes the screen empty and is generally not needed
//               final notifier = _ref.read(channelShortsTabCNP.notifier);
//               notifier.getShorts(
//                 index: index,
//                 channelId: screenTypeAndId.screenId,
//                 addState: true,
//               );
//             },
//           ),
//         ),
//       );
//     } else {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: false});
//
//       if (screenTypeAndId.screenType == ScreenType.channel) {
//         _screens[index]!.add(
//           CustomScreen(
//             screenTypeAndId: screenTypeAndId,
//             screen: ChannelScreen(
//               channelId: screenTypeAndId.screenId,
//               index: index,
//             ),
//           ),
//         );
//       }
//     }
//
//     notifyListeners();
//
//     _shouldPush[index] = true;
//
//     notifyListeners();
//   }
//
//   Future<void> addScreen({
//     required int index,
//     required CustomScreen customScreen,
//   }) async {
//     for (int i = 0; i <= 4; i++) {
//       if (i == 2) continue;
//
//       _shouldPush[i] = false;
//       notifyListeners();
//     }
//
//     if (customScreen.screenTypeAndId.screenType == ScreenType.short) {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: true});
//
//       return;
//     } else {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: false});
//     }
//
//     _screens[index]!.add(customScreen);
//   }
//
//   void removeLastScreen(int index) {
//     if (_screens[index]!.length == 1) return;
//
//     // this gets triggered including when i delete the last element, so,
//     // this is kinda necessary
//     for (int i = 0; i <= 4; i++) {
//       if (i == 2) continue;
//
//       _shouldPush[i] = false;
//
//       notifyListeners();
//     }
//
//     _screens[index]!.removeLast();
//     notifyListeners();
//
//     if (_screens[index]!.last.screenTypeAndId.screenType == ScreenType.channel) {
//       _ref.read(channelInfoCNP.notifier).removeLast(index);
//     }
//
//     // after popping the screen, if it's a short, then start playing
//     // the short, otherwise do nothing
//     if (_screens[index]!.last.screenTypeAndId.screenType == ScreenType.short) {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: true});
//     } else {
//       _ref.read(playShortSP.notifier).update((state) => {...state, index: false});
//     }
//   }
// }
//
// final pushedScreensCNP = ChangeNotifierProvider.autoDispose(
//   (ref) => PushedScreensCNP(ref),
// );
