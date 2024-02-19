import 'dart:developer';

import 'package:pod_player/pod_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';

part 'short_player_controller_provider.g.dart';

final shortPlayerControllerSP = Provider.family(
  (ref, IdAndIndex idAndIndex) => PodPlayerController(
    playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${idAndIndex.shortId}'),
    podPlayerConfig: const PodPlayerConfig(
      autoPlay: false,
      // autoPlay: true,
      isLooping: true,
    ),
  ),
);

@riverpod
class ShortPlayerController extends _$ShortPlayerController {
  // @override
  // Future<PodPlayerController> build({
  //   required String shortId,
  //   required int shortIndex,
  // }) async {
  //   final controller = PodPlayerController(
  //     playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
  //     podPlayerConfig: const PodPlayerConfig(
  //       autoPlay: false,
  //       // autoPlay: true,
  //       isLooping: true,
  //     ),
  //     // )..initialise();
  //   );
  //   await controller.initialise();
  //   return controller;
  //   // return PodPlayerController(
  //   //   playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
  //   //   podPlayerConfig: const PodPlayerConfig(
  //   //     autoPlay: false,
  //   //     // autoPlay: true,
  //   //     isLooping: true,
  //   //   ),
  //   //   // )..initialise();
  //   // );
  //   // return null;
  // }

  @override
  PodPlayerController build({
    required String shortId,
    // i don't need this
    // required int shortIndex,
  }) {
    return PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
      podPlayerConfig: const PodPlayerConfig(
        // autoPlay: false,
        autoPlay: true,
        isLooping: true,
      ),
    )..initialise();
    // );
  }

  // Future<void> initNew(String shortId) async {
  //   state = PodPlayerController(
  //     playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
  //     podPlayerConfig: const PodPlayerConfig(
  //       autoPlay: false,
  //       // autoPlay: true,
  //       isLooping: true,
  //     ),
  //   )..initialise();
  //   log('gloc');
  // }

  Future<void> initialize() async {
    if (!state.isInitialised) {
      state = state..initialise();
    }
    // state = state..initialise();
  }

  void play() {
    // if (!state.isInitialised) {
    //   state = state..initialise();
    // }
    // state = state..play();
    state.play();
    log('controller is now playing from inside controller provider');
  }

  // void pause() {
  //   state = state..pause();
  // }

  // no need to make this async
  // Future<void> initializeController(String shortId) async {
  //   state = PodPlayerController(
  //     playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$shortId'),
  //     podPlayerConfig: const PodPlayerConfig(
  //       // autoPlay: false,
  //       autoPlay: true,
  //       isLooping: true,
  //     ),
  //   )..initialise();
  // }
}

@riverpod
class AnotherShortPlayerController extends _$AnotherShortPlayerController {
  @override
  PodPlayerController? build() {
    return null;
  }

  Future<void> initController() async {}
}
