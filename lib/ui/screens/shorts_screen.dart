import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_notifier.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';

class ShortsScreen extends ConsumerStatefulWidget {
  const ShortsScreen({super.key});

  @override
  ConsumerState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends ConsumerState<ShortsScreen> {
  Future<void> getShorts() async {
    final notifier = ref.read(shortsNotifierProvider(1).notifier);
    await notifier.getShorts();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getShorts);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(screensManagerProvider(1), (_, state) {
      final notifier = ref.read(screensManagerProvider(1).notifier);
      if (!notifier.shouldPush) return;
      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });
    final shorts = ref.watch(shortsNotifierProvider(1)).last;
    return ShortsBody(
      screenIndex: 1,
      backButtonOn: false,
      shorts: shorts,
      onLoadMoreShorts: getShorts,
      onError: getShorts,
    );
  }
}
