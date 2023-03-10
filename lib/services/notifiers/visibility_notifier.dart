import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisibilityNotifier extends StateNotifier<List<bool>> {
  VisibilityNotifier() : super([]);

  void toggleSelection(int index, {bool value = false}) {
    if (!mounted) return;

    // * this is used so that this doesn't get called when i scroll up
    if (index <= state.length) return;
    if (index > state.length) {
      state = List.from(state)
        ..addAll(
          List.generate(index - state.length + 1, (_) => false),
        );
    }
  }

  void changeValue(int index, {bool value = true}) {
    state = List.from(state)..[index] = value;
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
