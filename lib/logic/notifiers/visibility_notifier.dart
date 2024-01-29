import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisibilityNotifier extends StateNotifier<List<bool>> {
  VisibilityNotifier() : super([false]);

  // TODO remove value
  void toggleSelection(int index, {bool value = false}) {
    if (!mounted) return;

    // this is used so that this doesn't get called when i scroll up
    if (index <= state.length) return;

    state = List.from(state)
      ..addAll(
        List.generate(index - state.length + 1, (_) => false),
      );
  }

  void changeValue(int index, {bool value = true}) {
    state = List.from(state)..[index] = value;

    // state[index] = value;
    //
    // state = List.from(state);
  }

  bool isSelected(int index) {
    if (index >= state.length) {
      return false;
    }

    return state[index];
  }
}

final visibilitySNP = StateNotifierProvider<VisibilityNotifier, List<bool>>(
  (ref) => VisibilityNotifier(),
);
