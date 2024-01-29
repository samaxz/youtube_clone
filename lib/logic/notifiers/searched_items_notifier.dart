// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';

import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'searched_items_notifier.g.dart';

// this mixin should have every single field of all
// the unions it'll be used with
mixin Item {
  String get kind;
  String get id;
}

@riverpod
class SearchItemsNotifier extends _$SearchItemsNotifier {
  @override
  Map<int, List<BaseInfoState<Item>>> build() {
    return {
      0: [
        const BaseInfoLoading(),
      ],
      1: [
        const BaseInfoLoading(),
      ],
      3: [
        const BaseInfoLoading(),
      ],
      4: [
        const BaseInfoLoading(),
      ],
    };
  }

  Future<void> searchItems({
    required String query,
    required int index,
  }) async {
    final service = ref.watch(youtubeServiceP);
    final itemsOrFailure = await service.searchItems(
      query,
      pageToken: state[index]!.last.baseInfo.nextPageToken,
    );

    state = itemsOrFailure.fold(
      (l) => {
        ...state,
        index: [
          ...state[index]!,
        ]..last = BaseInfoError(
            baseInfo: state[index]!.last.baseInfo,
            failure: l,
          ),
      },
      (r) => {
        ...state,
        index: [
          ...state[index]!,
        ]..last = BaseInfoLoaded(
            BaseInfo(
              data: [
                ...state[index]!.last.baseInfo.data,
                ...r.data,
              ],
              nextPageToken: r.nextPageToken,
              totalPages: r.totalPages,
              itemsPerPage: r.itemsPerPage,
            ),
          ),
      },
    );
  }
}
