import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';

// this appbar is used for both channel and playlist screens
class ChannelSliverAppbar extends ConsumerWidget {
  final int index;
  // the reason why it's null, is cause the playlist screen
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
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.chevron_left,
          size: 31,
          color: Theme.of(context).buttonTheme.colorScheme?.onSurface,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cast,
            color: Theme.of(context).buttonTheme.colorScheme?.onSurface,
          ),
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
                        'I don`t think i`m gonna implement this to begin with',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).buttonTheme.colorScheme?.onSurface,
          ),
          onPressed: () => Helper.handleShowSearch(
            context: context,
            ref: ref,
            screenIndex: index,
          ),
        ),
        IconButton(
          // TODO change this
          onPressed: () => Helper.showOtherActions(context),
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).buttonTheme.colorScheme?.onSurface,
          ),
        ),
      ],
    );
  }
}
