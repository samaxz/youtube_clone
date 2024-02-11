// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:youtube_clone/data/models/playlist/playlist_model.dart';
import 'package:youtube_clone/ui/screens/channel_screen.dart';
import 'package:youtube_clone/ui/screens/searched_playlist_screen.dart';
import 'package:youtube_clone/ui/widgets/searched_items_list.dart';

enum ScreenType {
  // initial is the home page for all the bottom nav bar indexes,
  // except for 1, which is short
  initial,
  channel,
  playlist,
  short,
  search,
}

// i don't really need this
// TODO delete this
class ChannelScreenType extends ScreenTypeAndId {
  final String channelId;

  const ChannelScreenType({required this.channelId})
      : super(
          screenId: channelId,
          screenType: ScreenType.channel,
        );
}

// this wll be passed inside pushScreen to determine which screen
// type i'll push to
// TODO use freezed here
class ScreenTypeAndId {
  final ScreenType screenType;
  final String screenId;

  const ScreenTypeAndId({
    required this.screenType,
    required this.screenId,
  });

  const ScreenTypeAndId.initial()
      : screenType = ScreenType.initial,
        screenId = 'initial';

  const ScreenTypeAndId.initialShort()
      : screenType = ScreenType.short,
        screenId = 'initial short';

  const ScreenTypeAndId.channel(String channelId)
      : screenId = channelId,
        screenType = ScreenType.channel;

  const ScreenTypeAndId.short(String shortId)
      : screenId = shortId,
        screenType = ScreenType.short;

  // and wtf do i do with this? it doesn't take any id. or does it?
  // i could probably use the query as the id, idk - besides, i
  // don't wanna push to search screen, it kinda pushes there automatically
  // but i can't quite pass it in here, so, for now it'll just be some dummy text
  const ScreenTypeAndId.search(String query)
      : screenId = query,
        screenType = ScreenType.search;

  const ScreenTypeAndId.searchedPlaylist(String playlistId)
      : screenId = playlistId,
        screenType = ScreenType.playlist;

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
  String toString() => 'ScreenTypeAndId(screenType: $screenType, screenId: $screenId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenTypeAndId &&
          runtimeType == other.runtimeType &&
          screenType == other.screenType &&
          screenId == other.screenId;

  @override
  int get hashCode => screenType.hashCode ^ screenId.hashCode;
}

// this is the main class that's used as the change notifier's state
class CustomScreen {
  final ScreenTypeAndId screenTypeAndId;
  // this'll be pushed
  // i could also force it to be passed inside ui
  final Widget screen;

  const CustomScreen({
    required this.screenTypeAndId,
    required this.screen,
  });

  // this is for all the non-shorts initial screens
  const CustomScreen.initial()
      : screenTypeAndId = const ScreenTypeAndId.initial(),
        screen = const Center(
          child: Text('this is initial screen, you`re not supposed to see this :/'),
        );

  const CustomScreen.initialShort()
      : screenTypeAndId = const ScreenTypeAndId.initialShort(),
        screen = const Center(
          child: Text('this is initial shorts screen, you`re not supposed to see this :/'),
        );
  // ***********

  CustomScreen.channel({
    required String channelId,
    required int screenIndex,
  })  : screenTypeAndId = ScreenTypeAndId.channel(channelId),
        screen = ChannelScreen(
          channelId: channelId,
          screenIndex: screenIndex,
        );

  CustomScreen.short({
    required String shortId,
    // can only be passed from outside
    required this.screen,
  }) : screenTypeAndId = ScreenTypeAndId.short(shortId);

  CustomScreen.search({
    required String query,
    required int screenIndex,
  })  : screenTypeAndId = ScreenTypeAndId.search(query),
        screen = SearchedItemsList(
          query: query,
          screenIndex: screenIndex,
        );

  CustomScreen.searchedPlaylist({
    required Playlist playlist,
    required int screenIndex,
  })  : screenTypeAndId = ScreenTypeAndId.searchedPlaylist(playlist.id),
        screen = SearchedPlaylistScreen(
          playlist: playlist,
          screenIndex: screenIndex,
        );

  CustomScreen copyWith({
    ScreenTypeAndId? screenTypeAndId,
    Widget? screen,
  }) {
    return CustomScreen(
      screenTypeAndId: screenTypeAndId ?? this.screenTypeAndId,
      screen: screen ?? this.screen,
    );
  }

  @override
  String toString() {
    return 'CustomScreen{screenTypeAndId: $screenTypeAndId, screen: $screen}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomScreen &&
          runtimeType == other.runtimeType &&
          screenTypeAndId == other.screenTypeAndId &&
          screen == other.screen;

  @override
  int get hashCode => screenTypeAndId.hashCode ^ screen.hashCode;
}
