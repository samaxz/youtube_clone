import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/ui/widgets/bodies/common_body.dart';

class SubsScreen extends ConsumerWidget {
  const SubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(screensManagerProvider(3), (_, state) {
      final notifier = ref.read(screensManagerProvider(3).notifier);
      if (!notifier.shouldPush) return;
      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });
    return const CommonBody(index: 3);
  }
}
