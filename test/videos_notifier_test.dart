import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/videos_service.dart';
import 'package:youtube_demo/services/notifiers/videos_notifier.dart';
import 'package:mocktail/mocktail.dart';

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

class MockVideosService extends Mock implements VideosService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('initial state is BaseInfoLoading', () {
    final mockVideosService = MockVideosService();
    final listener = Listener<BaseInfoState<Video>>();
    final container = createContainer();
    container.listen(
      videosNotifierProvider,
      listener,
      fireImmediately: true,
    );
    // verify the initial state
    verify(
      // the build method returns a value immediately, so i expect BaseInfoLoading<Video>
      () => listener(null, const BaseInfoLoading<Video>()),
    );
    verifyNoMoreInteractions(listener);
    verifyNever(mockVideosService.testVideos);
  });

  group('load videos', () {
    test('success', () async {
      final mockVideosService = MockVideosService();
      when(mockVideosService.testVideos).thenAnswer((_) => Future.value());
      final listener = Listener<BaseInfoState<Video>>();
      final container = createContainer(
        overrides: [
          videosServiceP.overrideWithValue(mockVideosService),
        ],
      );
      final videosNotifier = container.read(videosNotifierProvider.notifier);
      container.listen(
        videosNotifierProvider,
        listener,
        fireImmediately: true,
      );
      verify(() => listener(null, const BaseInfoLoading()));
      await videosNotifier.testVideos();
      verify(
        () => listener(
          const BaseInfoLoading(),
          const BaseInfoLoaded(BaseInfo()),
        ),
      );
      verifyNoMoreInteractions(listener);
      verify(mockVideosService.testVideos).called(1);
    });

    test('failure', () async {
      // setup
      final mockVideosService = MockVideosService();
      const failure = YoutubeFailure.noConnection();
      final container = createContainer(
        overrides: [
          videosServiceP.overrideWithValue(mockVideosService),
        ],
      );
      final listener = Listener<BaseInfoState<Video>>();
      container.listen(
        videosNotifierProvider,
        listener,
        fireImmediately: true,
      );
      // verify initial value from build method
      verify(() => listener(null, const BaseInfoLoading()));
      // run
      final videosNotifier = container.read(videosNotifierProvider.notifier);
      await videosNotifier.testVideos(failure: failure);
      // verify
      verify(
        () => listener(
          const BaseInfoLoading(),
          const BaseInfoError(
            failure: failure,
            baseInfo: BaseInfo(),
          ),
        ),
      );
      verifyNoMoreInteractions(listener);
      verify(mockVideosService.testVideos).called(1);
    });
  });
}
