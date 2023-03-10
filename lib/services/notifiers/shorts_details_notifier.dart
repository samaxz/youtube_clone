import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart' as channel;
import 'package:youtube_demo/services/common/either_extension.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/video_details_notifier.dart';

part 'shorts_details_notifier.g.dart';

@riverpod
class ShortsDetailsNotifier extends _$ShortsDetailsNotifier {
  @override
  Map<int, AsyncValue<VideoDetails>> build() {
    // * not sure if i should populate the state with anything, but, whatever
    return {
      0: const AsyncLoading(),
      1: const AsyncLoading(),
      3: const AsyncLoading(),
      4: const AsyncLoading(),
    };
  }

  // * this'll get details for a short on a certain screen
  Future<void> getDetails({
    required String videoId,
    required String channelId,
    required int index,
  }) async {
    await ref.read(ratingSNP.notifier).getVideoRating(videoId: videoId);

    await ref
        .read(subscriptionSNP.notifier)
        .getSubscriptionState(channelId: channelId);

    final service = ref.watch(youtubeServiceP);

    final comments = await service.getVideoComments(videoId);

    // * i can create a method that checks this inside service and just
    // use it here
    if (comments.rightOrDefault == null) {
      final failure = AsyncError<VideoDetails>(
        comments.leftOrDefault!,
        StackTrace.current,
      );

      state = {
        ...state,
        index: failure,
      };
    } else {
      final success = AsyncData(
        VideoDetails(
          channel: channel.Channel(
            kind: 'kind',
            etag: 'etag',
            id: 'id',
            snippet: channel.Snippet(
              publishedAt: DateTime(2069),
              title: 'title',
              description: 'description',
              country: 'RU',
              customUrl: '',
              thumbnail: const channel.Thumbnials(
                defaultSize: null,
                medium: null,
                high: null,
              ),
            ),
            contentDetails: null,
            statistics: null,
          ),
          // * since i don't need it, i can simply just make it a basic
          // base info and ignore it
          videoInfo: const BaseInfo(),
          comments: comments.rightOrDefault!,
        ),
      );

      state = {
        ...state,
        index: success,
      };
    }
  }

  void invalidate(int index) {
    // * i hope this is right
    state = {
      ...state,
      index: const AsyncLoading(),
    };
  }
}
