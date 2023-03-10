import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_playlists_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_shorts_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_subs_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_uploads_notifier.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_videos_notifier.dart';

// * this class'll hold a channel's basic info on any nav bar tab
class ChannelInfoNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelInfoNotifier(this._ref);

  final Map<int, List<AsyncValue<Channel>>> _state = {
    // added these so i don't have any bad state no last element exception
    0: [
      const AsyncLoading(),
    ],
    1: [
      const AsyncLoading(),
    ],
    3: [
      const AsyncLoading(),
    ],
    4: [
      const AsyncLoading(),
    ],
  };

  Map<int, List<AsyncValue<Channel>>> get state => _state;

  Future<void> getChannelInfo({
    required String channelId,
    required int index,
  }) async {
    _state[index]!.add(const AsyncLoading());
    notifyListeners();
    final service = _ref.read(youtubeServiceP);
    final channelInfo = await AsyncValue.guard(
      () => service.getChannelInfo(channelId),
    );
    _state[index]!.last = channelInfo;

    notifyListeners();
  }

  void removeLast(int index) {
    _state[index]!.removeLast();
    notifyListeners();

    _ref.read(channelHomeTabCNP.notifier).removeLast(index);
    _ref.read(channelVideosTabCNP.notifier).removeLast(index);
    _ref.read(channelShortsTabCNP.notifier).removeLast(index);
    _ref.read(channelPlaylistsTabCNP.notifier).removeLast(index);
    _ref.read(channelCommunityTabCNP.notifier).removeLast(index);
    _ref.read(channelSubsTabCNP.notifier).removeLast(index);
  }
}

final channelInfoCNP = ChangeNotifierProvider(
  (ref) {
    ref.onDispose(() {
      // * this works just like dispose
      ref.invalidate(channelHomeTabCNP);
      ref.invalidate(channelVideosTabCNP);
      ref.invalidate(channelShortsTabCNP);
      ref.invalidate(channelPlaylistsTabCNP);
      ref.invalidate(channelCommunityTabCNP);
      ref.invalidate(channelSubsTabCNP);
    });
    return ChannelInfoNotifier(ref);
  },
);
