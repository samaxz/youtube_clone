import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_about_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_community_posts_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_playlists_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_shorts_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_subs_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_home_notifier.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_videos_notifier.dart';

part 'channel_info_notifier.g.dart';

@riverpod
class ChannelInfoNotifier extends _$ChannelInfoNotifier {
  @override
  List<AsyncValue<Channel>> build(int screenIndex) {
    ref.onDispose(() {
      ref.invalidate(channelHomeNotifierProvider);
      ref.invalidate(channelVideosNotifierProvider);
      ref.invalidate(channelShortsNotifierProvider);
      ref.invalidate(channelPlaylistsNotifierProvider);
      ref.invalidate(channelCommunityNotifierProvider);
      ref.invalidate(channelSubsNotifierProvider);
      ref.invalidate(channelAboutNotifierProvider);
    });

    return [
      // this is used to avoid last element throws in build
      // when watching channel info
      const AsyncLoading(),
    ];
  }

  Future<void> getChannelInfo(
    String channelId, {
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    final service = ref.read(youtubeServiceP);
    final channelInfo = await AsyncValue.guard(
      () => service.getChannelInfo(channelId),
    );
    // log('channel info: $channelInfo');
    state.last = channelInfo;

    state = List.from(state);

    log('ChannelInfoNotifier after getChannelInfo(): $state');
  }

  // only if the last screen is channel, i wanna call this method
  void removeLast() {
    state = List.from(state)..removeLast();

    ref.read(channelHomeNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelVideosNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelShortsNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelPlaylistsNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelCommunityNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelSubsNotifierProvider(screenIndex).notifier).removeLast();
    ref.read(channelAboutNotifierProvider(screenIndex).notifier).removeLast();

    log('ChannelInfoNotifier after removeLast(): $state');
  }
}

// TODO delete this
// this class'll hold a channel's basic info on any nav bar tab
// class ChannelInfoNotifier extends ChangeNotifier {
//   final Ref _ref;
//
//   ChannelInfoNotifier(this._ref);
//
//   final Map<int, List<AsyncValue<Channel>>> _state = {
//     // added these so i don't have any bad state no last element exception
//     0: [
//       const AsyncLoading(),
//     ],
//     1: [
//       const AsyncLoading(),
//     ],
//     3: [
//       const AsyncLoading(),
//     ],
//     4: [
//       const AsyncLoading(),
//     ],
//   };
//
//   Map<int, List<AsyncValue<Channel>>> get state => _state;
//
//   Future<void> getChannelInfo({
//     required String channelId,
//     required int index,
//   }) async {
//     _state[index]!.add(const AsyncLoading());
//     notifyListeners();
//     final service = _ref.read(youtubeServiceP);
//     final channelInfo = await AsyncValue.guard(
//       () => service.getChannelInfo(channelId),
//     );
//     _state[index]!.last = channelInfo;
//
//     notifyListeners();
//   }
//
//   void removeLast(int index) {
//     _state[index]!.removeLast();
//     notifyListeners();
//
//     // _ref.read(channelHomeTabCNP.notifier).removeLast(index);
//     // _ref.read(channelHomeNotifierProvider.notifier).removeLast(index);
//     _ref.read(channelHomeNotifierProvider(index).notifier).removeLast();
//     // _ref.read(channelVideosTabCNP.notifier).removeLast(index);
//     _ref.read(channelVideosNotifierProvider(index).notifier).removeLast();
//     _ref.read(channelShortsTabCNP.notifier).removeLast(index);
//     _ref.read(channelPlaylistsTabCNP.notifier).removeLast(index);
//     _ref.read(channelCommunityTabCNP.notifier).removeLast(index);
//     _ref.read(channelSubsTabCNP.notifier).removeLast(index);
//   }
// }
//
// final channelInfoCNP = ChangeNotifierProvider(
//   (ref) {
//     ref.onDispose(() {
//       // this works just like dispose
//       // ref.invalidate(channelHomeTabCNP);
//       ref.invalidate(channelHomeNotifierProvider);
//       // ref.invalidate(channelVideosTabCNP);
//       ref.invalidate(channelVideosNotifierProvider);
//       ref.invalidate(channelShortsTabCNP);
//       ref.invalidate(channelPlaylistsTabCNP);
//       ref.invalidate(channelCommunityTabCNP);
//       ref.invalidate(channelSubsTabCNP);
//     });
//     return ChannelInfoNotifier(ref);
//   },
// );
