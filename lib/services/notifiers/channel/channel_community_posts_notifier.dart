import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/community_post_model.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/common/youtube_service.dart';

class ChannelCommunityNotifier extends ChangeNotifier {
  final Ref _ref;

  ChannelCommunityNotifier(this._ref);

  final Map<int, List<AsyncValue<List<CommunityPost>>>> state = {
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

  bool _disposed = false;

  Future<void> getCommunityPosts({
    required int index,
    required String channelId,
  }) async {
    state[index]!.add(const AsyncLoading());
    final service = _ref.read(youtubeServiceP);
    final posts = await AsyncValue.guard(
      () => service.getChannelCommunityPosts(channelId),
    );
    state[index]!.last = posts;
    notifyListeners();
  }

  void removeLast(int index) {
    state[index]!.removeLast();
    if (state[index]!.last.isLoading) state[index]!.removeLast();
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

final channelCommunityTabCNP = ChangeNotifierProvider(
  (ref) => ChannelCommunityNotifier(ref),
);

@deprecated
class CommunityPostsNotifier
    extends StateNotifier<AsyncValue<List<CommunityPost>>> {
  final YoutubeService _service;

  CommunityPostsNotifier(this._service) : super(const AsyncLoading());

  bool _isLoading = false;

  Future<void> getCommunityPosts(String channelId) async {
    if (_isLoading) return;

    _isLoading = true;

    if (!mounted) return;

    state = await AsyncValue.guard(
      () => _service.getChannelCommunityPosts(channelId),
    );

    _isLoading = false;
  }
}
