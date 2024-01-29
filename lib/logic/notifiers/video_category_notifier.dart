import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/data/models/video/video_category_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/videos_notifier.dart';

part 'video_category_notifier.g.dart';

// video categories for the initial home screen
@riverpod
class VideoCategoriesNotifier extends _$VideoCategoriesNotifier {
  @override
  AsyncValue<List<VideoCategory>> build() {
    return const AsyncLoading();
  }

  Future<void> getVideoCategories() async {
    final service = ref.read(youtubeServiceP);
    final categories = await AsyncValue.guard(service.getVideoCategories);
    final notifier = ref.read(videosNotifierProvider.notifier);

    state = categories
      ..maybeWhen(
        orElse: () {
          notifier.shouldSkip = false;
          notifier.loadCategories = false;
        },
        error: (error, stackTrace) {
          final failure = error as YoutubeFailure;

          notifier.shouldSkip = true;
          notifier.loadCategories = true;
          notifier.setFailureState(failure);
        },
      );
  }
}
