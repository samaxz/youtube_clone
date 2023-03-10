import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/video/video_category_model.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';

class VideoCategoriesNotifier
    extends StateNotifier<AsyncValue<List<VideoCategory>>> {
  final YoutubeService _service;

  VideoCategoriesNotifier(this._service)
      : super(
          const AsyncValue.loading(),
        );

  bool _isLoading = false;

  Future<void> getVideoCategories() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final categories = await _service.getVideoCategories();
      if (!mounted) return;
      state = AsyncValue.data(categories);
    } on Exception catch (e) {
      if (!mounted) return;
      state = AsyncValue.error(e, StackTrace.current);
    }

    _isLoading = false;
  }
}
