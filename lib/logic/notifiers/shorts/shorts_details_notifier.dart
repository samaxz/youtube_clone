import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart' as channel;
import 'package:youtube_clone/data/models/video/video_details.dart';
import 'package:youtube_clone/logic/notifiers/rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_rating_notifier.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/notifiers/video_details_notifier.dart';
import 'package:youtube_clone/logic/services/either_extension.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'shorts_details_notifier.g.dart';

@riverpod
class ShortsDetailsNotifier extends _$ShortsDetailsNotifier {
  @override
  List<AsyncValue<VideoDetails>> build(int screenIndex) {
    return [
      const AsyncLoading(),
    ];
  }

  bool shouldSkip = false;

  void setFailureState() {
    state.last = const AsyncError(
      'Failed to load data',
      StackTrace.empty,
    );

    state = List.from(state);
  }

  // this'll get details for a short on a certain screen
  Future<void> getDetails({
    required String videoId,
    required String channelId,
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    final notifier = ref.read(shortsRatingNotifierProvider(
      videoId: videoId,
      screenIndex: screenIndex,
    ).notifier);
    await notifier.getVideoRating();

    if (shouldSkip) return;

    final service = ref.read(youtubeServiceP);
    final channel = await service.getChannelInfoEither(channelId);
    final comments = await service.getVideoComments(videoId);

    // i can create a method that checks this inside service and just
    // use it here
    if (channel.rightOrDefault == null || comments.rightOrDefault == null) {
      final failure = AsyncError<VideoDetails>(
        comments.leftOrDefault!,
        StackTrace.current,
      );

      state.last = failure;
    } else {
      final success = AsyncData(
        VideoDetails(
          // UPD this is used for displaying channel data
          channelInfo: channel.rightOrDefault!,
          comments: comments.rightOrDefault!,
        ),
      );

      state.add(success);
    }

    state = List.from(state);
  }
}
