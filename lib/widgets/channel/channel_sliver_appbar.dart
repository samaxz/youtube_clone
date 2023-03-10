import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';

class ChannelSliverAppbar extends ConsumerWidget {
  final int index;
  // * the reason why it's null, is cause the playlist screen
  // uses this appbar and it doesn't need to display the channel
  // info's title
  final Channel? channel;

  const ChannelSliverAppbar({
    super.key,
    required this.index,
    this.channel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: Text(channel?.snippet.title ?? ''),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          ref.read(pushedHomeChannelSP.notifier).update((state) => false);
        },
        icon: const Icon(
          Icons.chevron_left,
          size: 31,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.cast),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            useSafeArea: true,
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.clear),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'I don`t thinkg i`m gonna implement this to begin with',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () =>
              Helper.handleShowSearch(context: context, ref: ref, index: index),
        ),
        IconButton(
          // TODO create method for this
          onPressed: () => Helper.handleMoreVertPressed(
            context: context,
            ref: ref,
            screenIdAndActions: const ScreenIdAndActions(
              actions: ScreenActions.channel,
            ),
          ),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
