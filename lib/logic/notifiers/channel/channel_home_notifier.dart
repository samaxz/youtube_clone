import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/data/info/common_classes.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

part 'channel_home_notifier.g.dart';

@riverpod
class ChannelHomeNotifier extends _$ChannelHomeNotifier {
  @override
  List<AsyncValue<Uploads>> build(int screenIndex) {
    return [
      // used to avoid throws in build when watching the notifier
      const AsyncLoading(),
    ];
  }

  Future<void> getHomeTabContent(
    String channelId, {
    bool isReloading = false,
  }) async {
    if (isReloading) {
      state.last = const AsyncLoading();
    } else {
      state.add(const AsyncLoading());
    }

    // this could be inside isReloading
    // TODO move this inside isReloading
    state = List.from(state);

    final service = ref.read(youtubeServiceP);
    final uploads = await AsyncValue.guard(
      () => service.getChannelUploads(channelId),
    );
    // log('uploads: $uploads');
    state.last = uploads;

    state = List.from(state);
  }

  void removeLast() => state = List.from(state)..removeLast();
}
