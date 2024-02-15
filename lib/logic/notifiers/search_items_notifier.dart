// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';

import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'search_items_notifier.g.dart';

// this mixin should have every single field of all
// the unions it'll be used with
mixin Item {
  String get kind;
  String get id;
}

// this solves the problem of results reloading after popping back
// to the search items list
@Riverpod(keepAlive: true)
class SearchItemsNotifier extends _$SearchItemsNotifier {
  @override
  List<BaseInfoState<Item>> build(int screenIndex) {
    return [
      const BaseInfoLoading(),
    ];
  }

  Future<void> searchItems({
    required String query,
    required int screenIndex,
    bool added = false,
  }) async {
    final service = ref.watch(youtubeServiceP);
    final itemsOrFailure = await service.searchItems(
      query,
      pageToken: state.last.baseInfo.nextPageToken,
    );

    state = itemsOrFailure.fold(
      (l) => [
        ...state,
        BaseInfoError(
          baseInfo: state.last.baseInfo,
          failure: l,
        ),
      ],
      (r) => [
        ...state,
        BaseInfoLoaded(
          BaseInfo(
            data: [
              ...state.last.baseInfo.data,
              ...r.data,
            ],
            nextPageToken: r.nextPageToken,
            totalPages: r.totalPages,
            itemsPerPage: r.itemsPerPage,
          ),
        ),
      ],
    );

    // log('SearchItemsNotifier state after searchItems($query, $screenIndex): $state');
    // log('SearchItemsNotifier state length after searchItems($query, $screenIndex): ${state.length}');
  }

  void removeLast() {
    // this is to prevent bad state inside search items list's build()
    if (state.length == 1) return;

    state = List.from(state)..removeLast();

    // log('SearchItemsNotifier state after removeLast(): $state');
    // log('SearchItemsNotifier state length after removeLast(): ${state.length}');
  }
}