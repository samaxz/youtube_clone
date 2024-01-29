import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sliver_appbar.dart';

class NotificationsScreen extends ConsumerWidget {
  final int index;

  const NotificationsScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        ChannelSliverAppbar(index: index),
      ],
      body: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('I don`t thinkg i`m gonna implement this to begin with'),
          ),
        ),
      ),
    );
  }
}
