// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_demo/data/models/channel/community_post_model.dart';
import 'package:youtube_demo/data/models/playlist_model_new.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/screens/channel_screen.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/searched_items_notifier.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body_player.dart';

@deprecated
class CustomScreensChangeNotifier extends ChangeNotifier {
  final Ref _ref;

  CustomScreensChangeNotifier(this._ref);

  final Map<int, List<CustomScreen>> state = {
    0: [],
    1: [],
    3: [],
    4: [],
  };

  Map<int, bool> shouldPush = {
    0: true,
    1: true,
    3: true,
    4: true,
  };

  Map<int, bool> shouldPop = {
    0: true,
    1: true,
    3: true,
    4: true,
  };

  Future<void> pushScreen({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    shouldPush[index] = true;

    // * this is needed
    state[index]!.add(CustomScreen.initial());

    if (screenTypeAndId.screenType == ScreenType.short) {
      _ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: true});
    } else {
      _ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: false});
    }

    final screen = _getScreen(
      index: index,
      screenTypeAndId: screenTypeAndId,
    );

    final screenAndData = ScreenAndData(screen: screen);

    final newScreen = CustomScreen(
      screenTypeAndId: screenTypeAndId,
      screenAndData: screenAndData,
    );

    state[index]!.last = newScreen;
    shouldPush[index] = true;

    if (state[index]!.length > 1) {
      shouldPop[index] = true;
    } else {
      shouldPop[index] = false;
    }

    notifyListeners();

    log('state is:');
    for (final element in state.entries) {
      log(element.key.toString());
      for (final el in element.value) {
        log(el.screenAndData.toString());
      }
      log(' ');
    }
  }

  Future<void> replaceScreen({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    if (!await Helper.hasInternet()) return;

    shouldPush[index] = false;

    shouldPop[index] = false;

    if (screenTypeAndId.screenType == ScreenType.short) {
      _ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: true});
    } else {
      _ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: false});
    }

    final data = await _getScreenData(screenTypeAndId: screenTypeAndId);

    state[index]!.last.screenAndData.data = data;

    notifyListeners();

    log('state is:');
    for (final element in state.entries) {
      log(element.key.toString());
      for (final el in element.value) {
        log(el.screenAndData.toString());
      }
      log(' ');
    }
  }

  void removeLast(int index) {
    state[index]!.removeLast();
    notifyListeners();
  }

  Future<void> getScreenData({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    final data = await _getScreenData(screenTypeAndId: screenTypeAndId);

    if (screenTypeAndId.screenType == ScreenType.channel) {
      final channelInfo = await getChannelInfo(
        channelId: screenTypeAndId.screenId,
        index: index,
      );

      state[index]!
          .last
          .screenAndData
          .data
          ?.channelTabsData
          ?.infoAndAbout
          .info = channelInfo;
    }

    state[index]!.last.screenAndData.data = data;

    shouldPush[index] = false;

    notifyListeners();
  }

  Future<AsyncValue<Channel>> getChannelInfo({
    required String channelId,
    required int index,
  }) async {
    final service = _ref.read(youtubeServiceP);
    final channelInfo = await AsyncValue.guard(
      () => service.getChannelInfo(channelId),
    );

    return channelInfo;
  }

  Future<ScreenData> _getScreenData({
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    final service = _ref.read(youtubeServiceP);
    late final ScreenData screenData;
    if (screenTypeAndId.screenType == ScreenType.channel) {
      final info = await AsyncValue.guard<Channel>(
        () => service.getChannelInfo(screenTypeAndId.screenId),
      );

      final playlists = await AsyncValue.guard<List<Playlist>>(
        () => service.getChannelPlaylists(screenTypeAndId.screenId),
      );

      final communityPosts = await AsyncValue.guard<List<CommunityPost>>(
        () => service.getChannelCommunityPosts(screenTypeAndId.screenId),
      );

      screenData = ScreenData(
        channelTabsData: ChannelTabsData(
          infoAndAbout: InfoAndAbout(info: info),
          videos: const AsyncLoading(),
          // * this is unofficial api
          playlists: playlists,
          // * this is too
          communityPosts: communityPosts,
          // * so is this
          subscriptions: const AsyncLoading(),
        ),
      );
    }

    return screenData;
  }

  Widget _getScreen({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
    ScreenData? data,
  }) {
    late final Widget screen;
    if (screenTypeAndId.screenType == ScreenType.channel) {
      screen = ChannelScreen(
        channelId: screenTypeAndId.screenId,
        index: index,
        // channel: data as AsyncValue<Channel>,
        channel: data?.channelTabsData!.infoAndAbout.info,
      );
    }

    return screen;
  }
}

// this is outdated and wrong, don't use this
final customScreensCNP = ChangeNotifierProvider(
  (ref) => CustomScreensChangeNotifier(ref),
);

enum ScreenType {
  // * initial is the home page for all the bottom nav bar indexes
  initial,
  channel,
  playlist,
  short,
  search,
}

// * this wll be passed inside pushScreen to determine which screen
// type i'll push to
class ScreenTypeAndId {
  final ScreenType screenType;
  final String screenId;

  const ScreenTypeAndId({required this.screenType, required this.screenId});

  const ScreenTypeAndId.initial()
      : screenType = ScreenType.initial,
        screenId = '';

  const ScreenTypeAndId.initialShort()
      : screenType = ScreenType.short,
        screenId = '';

  ScreenTypeAndId copyWith({
    ScreenType? screenType,
    String? screenId,
  }) {
    return ScreenTypeAndId(
      screenType: screenType ?? this.screenType,
      screenId: screenId ?? this.screenId,
    );
  }

  @override
  String toString() =>
      'ScreenTypeAndId(screenType: $screenType, screenId: $screenId)';
}

@deprecated
class ScreenData {
  final ChannelTabsData? channelTabsData;

  const ScreenData({this.channelTabsData});

  @override
  String toString() => 'ScreenData(channelTabsData: $channelTabsData)';
}

// ! use this instead, along with the change notifier provider
// TODO remove data from here and rename the class
class ScreenAndData {
  ScreenData? data;
  final Widget screen;

  ScreenAndData({this.data, required this.screen});

  ScreenAndData.initial()
      : data = ScreenData(channelTabsData: ChannelTabsData.initial()),
        screen = const SizedBox.shrink();

  @override
  String toString() => 'ScreenAndData(data: $data, screen: $screen)';

  ScreenAndData copyWith({
    ScreenData? data,
    Widget? screen,
  }) {
    return ScreenAndData(
      data: data ?? this.data,
      screen: screen ?? this.screen,
    );
  }
}

// * this is the main class that's used as the change notifier's state
class CustomScreen {
  final ScreenTypeAndId screenTypeAndId;
  ScreenAndData screenAndData;

  CustomScreen({
    required this.screenTypeAndId,
    required this.screenAndData,
  });

  // * this is for all the non-shorts screens
  CustomScreen.initial()
      : screenTypeAndId = const ScreenTypeAndId.initial(),
        screenAndData = ScreenAndData.initial();

  CustomScreen.initialShort()
      : screenTypeAndId = const ScreenTypeAndId.initialShort(),
        screenAndData = ScreenAndData.initial();

  CustomScreen copyWith({
    ScreenTypeAndId? screenTypeAndId,
    ScreenAndData? screenAndData,
  }) {
    return CustomScreen(
      screenTypeAndId: screenTypeAndId ?? this.screenTypeAndId,
      screenAndData: screenAndData ?? this.screenAndData,
    );
  }

  @override
  String toString() =>
      'CustomScreen(screenTypeAndId: $screenTypeAndId, screenAndData: $screenAndData)';
}

@deprecated
class InfoAndAbout {
  AsyncValue<Channel> info;

  InfoAndAbout({required this.info});

  @override
  String toString() => 'InfoAndAbout(info: $info)';
}

@deprecated
class ChannelTabsData {
  // channel info: title, description, subs count...
  InfoAndAbout infoAndAbout;
  AsyncValue<List<Video>> videos;
  AsyncValue<List<Playlist>> playlists;
  AsyncValue<List<CommunityPost>> communityPosts;
  AsyncValue<List<ChannelSubscription>> subscriptions;

  ChannelTabsData({
    required this.infoAndAbout,
    required this.videos,
    required this.playlists,
    required this.communityPosts,
    required this.subscriptions,
  });

  ChannelTabsData.initial()
      : infoAndAbout = InfoAndAbout(info: const AsyncLoading()),
        videos = const AsyncLoading(),
        playlists = const AsyncLoading(),
        communityPosts = const AsyncLoading(),
        subscriptions = const AsyncLoading();

  @override
  String toString() {
    return 'ChannelTabsData(infoAndAbout: $infoAndAbout, videos: $videos, playlists: $playlists, communityPosts: $communityPosts, subscriptions: $subscriptions)';
  }
}

// *******************************

// * should delete these eventually
// TODO delete these
final replaceErrorRouteSP = StateProvider(
  (ref) => {
    0: false,
    1: false,
    3: false,
    4: false,
  },
);

final shouldPushRouteSP = StateProvider(
  (ref) => {
    0: true,
    1: true,
    3: true,
    4: true,
  },
);
// ************************

final customScreensNP = NotifierProvider.autoDispose<CustomScreensNotifier,
    Map<int, List<CustomScreen>>>(CustomScreensNotifier.new);

@deprecated
class CustomScreensNotifier
    extends AutoDisposeNotifier<Map<int, List<CustomScreen>>> {
  @override
  Map<int, List<CustomScreen>> build() {
    return {
      0: [],
      1: [],
      3: [],
      4: [],
    };
  }

  final Map<int, bool> shouldReplace = {
    0: false,
    1: false,
    3: false,
    4: false,
  };

  final Map<int, String?> _channelId = {
    0: 'null',
    1: 'null',
    3: 'null',
    4: 'null',
  };

  Map<int, String?> get lastChannelId => _channelId;

  set lastChannelId(Map<int, String?> value) => _channelId;

  void removeLastChannelId(int index) {
    _channelId[index] = null;
  }

  // *********
  final Map<int, List<String?>> _channelIds = {
    0: [],
    1: [],
    3: [],
    4: [],
  };

  Map<int, List<String?>> get lastChannelIds => _channelIds;

  void removeLastChannelIds(int index) {
    _channelIds[index]?.removeLast();
  }
  // ************

  Future<void> pushScreen({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    if (screenTypeAndId.screenType == ScreenType.short) {
      ref.read(playShortSP.notifier).update((state) => {...state, index: true});
    } else {
      ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: false});
    }

    final data = await _getScreenData(
      index: index,
      screenTypeAndId: screenTypeAndId,
    );

    final screen = _getScreen(
      index: index,
      screenTypeAndId: screenTypeAndId,
      data: data,
    );

    final screenAndData = ScreenAndData(data: ScreenData(), screen: screen);

    final newScreen = CustomScreen(
      screenTypeAndId: screenTypeAndId,
      screenAndData: screenAndData,
    );

    state = {
      ...state,
      index: [
        ...state[index]!,
        newScreen,
      ],
    };

    log('state is:');
    for (final element in state.entries) {
      log(element.key.toString());
      for (final el in element.value) {
        log('${el.screenTypeAndId.screenType}: ${el.screenAndData.data}');
      }
      log(' ');
    }
  }

  Future<void> replaceScreen({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    if (!await Helper.hasInternet()) return;

    if (screenTypeAndId.screenType == ScreenType.short) {
      ref.read(playShortSP.notifier).update((state) => {...state, index: true});
    } else {
      ref
          .read(playShortSP.notifier)
          .update((state) => {...state, index: false});
    }

    ref
        .read(shouldPushRouteSP.notifier)
        .update((state) => {...state, index: false});

    ref
        .read(replaceErrorRouteSP.notifier)
        .update((state) => {...state, index: true});

    shouldReplace[index] = true;

    final data = await _getScreenData(
      index: index,
      screenTypeAndId: screenTypeAndId,
    );

    final screen = _getScreen(
      index: index,
      data: data,
      screenTypeAndId: screenTypeAndId,
    );

    final screenAndData = ScreenAndData(data: ScreenData(), screen: screen);

    final newScreen = CustomScreen(
      screenTypeAndId: screenTypeAndId,
      screenAndData: screenAndData,
    );

    final temp = Map.of(state);

    state = {
      ...state,
      index: [
        ...state[index]!,
      ],
    };

    shouldReplace[index] = false;

    ref
        .read(shouldPushRouteSP.notifier)
        .update((state) => {...state, index: true});

    ref
        .read(replaceErrorRouteSP.notifier)
        .update((state) => {...state, index: false});
    // ********
  }

  void removeLast(int index) {
    state = {
      ...state,
      index: state[index]!..removeLast(),
    };
  }

  Future<AsyncValue<Item>> _getScreenData({
    required int index,
    required ScreenTypeAndId screenTypeAndId,
  }) async {
    final service = ref.read(youtubeServiceP);
    late final AsyncValue<Item> data;
    if (screenTypeAndId.screenType == ScreenType.channel) {
      data = await AsyncValue.guard<Channel>(
        () => service
            .getChannelInfo(screenTypeAndId.screenId)
            .then((value) => value),
      );
    }

    return data;
  }

  Widget _getScreen({
    required int index,
    required AsyncValue<Item> data,
    required ScreenTypeAndId screenTypeAndId,
  }) {
    late final Widget screen;
    if (screenTypeAndId.screenType == ScreenType.channel) {
      screen = ChannelScreen(
        index: index,
        channelId: screenTypeAndId.screenId,
      );
    }

    return screen;
  }
}
