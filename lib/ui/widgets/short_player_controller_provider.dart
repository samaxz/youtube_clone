import 'package:pod_player/pod_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'short_player_controller_provider.g.dart';

@riverpod
class ShortPlayerController extends _$ShortPlayerController {
  @override
  PodPlayerController build(String shortId) {
    return PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: true,
      ),
    )..initialise();
  }
}
