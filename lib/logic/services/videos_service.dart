import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// this is used for mocking tests
class VideosService {
  const VideosService();

  Future<bool?>? testVideos() async {
    debugPrint('getVideos() got called inside VideosService');
    await Future.delayed(const Duration(milliseconds: 300));
    final randomInt = Random().nextBool();
    if (randomInt) {
      return true;
    } else {
      return false;
    }
  }
}

final videosServiceP = Provider.autoDispose((ref) => const VideosService());
