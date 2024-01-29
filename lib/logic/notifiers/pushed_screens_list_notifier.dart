import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/logic/services/custom_screen.dart';

part 'pushed_screens_list_notifier.g.dart';

// this is used for shorts
// TODO ultimately, delete this
@riverpod
class PushedScreensListNotifier extends _$PushedScreensListNotifier {
  @override
  Map<int, List<ScreenTypeAndId>> build() {
    return {
      0: [
        const ScreenTypeAndId.initial(),
      ],
      1: [
        const ScreenTypeAndId.initialShort(),
      ],
      3: [
        const ScreenTypeAndId.initial(),
      ],
      4: [
        const ScreenTypeAndId.initial(),
      ],
    };
  }

  void addScreen({
    List<ScreenTypeAndId>? pushedScreens,
    required ScreenTypeAndId newScreen,
    required int index,
  }) {
    state = {
      ...state,
      index: [
        ...state[index]!,
        newScreen,
      ],
    };
  }

  void removeLast(int index) {
    state = {
      ...state,
      index: [...state[index]!]..removeLast(),
    };
  }
}

// TODO delete this
// @deprecated
// class PushedScreensListNotifierOld extends ChangeNotifier {
//   final Map<int, List<ScreenTypeAndId>> _state = {
//     0: [],
//     1: [],
//     3: [],
//     4: [],
//   };
//
//   Map<int, List<ScreenTypeAndId>> get state => _state;
//
//   void addScreen({
//     required List<ScreenTypeAndId> pushedScreens,
//     required ScreenTypeAndId newScreen,
//     required int index,
//   }) {
//     _state[index]!.addAll([...pushedScreens, newScreen]);
//
//     notifyListeners();
//   }
// }
//
// // TODO delete this
// final pushedScreensListOldSP = StateProvider.autoDispose<Map<int, List<ScreenTypeAndId>>>(
//   (ref) {
//     final index = ref.watch(currentScreenIndexSP);
//
//     final pushedScreens = ref.watch(
//       pushedScreensCNP.select(
//         (value) => value.screens[index]!.map((element) => element.screenTypeAndId).toList(),
//       ),
//     );
//
//     return {
//       0: [
//         ...pushedScreens,
//       ],
//       1: [],
//       3: [],
//       4: [],
//     };
//   },
// );
