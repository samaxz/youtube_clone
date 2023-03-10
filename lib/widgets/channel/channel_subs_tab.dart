import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';
import 'package:youtube_demo/services/notifiers/channel/channel_subs_notifier.dart';
import 'package:youtube_demo/widgets/channel/channel_sub_card.dart';

class ChannelSubsTab extends ConsumerStatefulWidget {
  final String channelId;
  final int index;

  const ChannelSubsTab({
    super.key,
    required this.channelId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelSubsTabState();
}

class _ChannelSubsTabState extends ConsumerState<ChannelSubsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    ref
        .read(channelSubsTabCNP.notifier)
        .getChannelSubs(channelId: widget.channelId, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final subs = ref.watch(
      channelSubsTabCNP.select(
        (value) => value.state[widget.index]!.last,
      ),
    );

    return subs.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('oops, looks like it`s empty'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 50),
          itemCount: data.length,
          itemBuilder: (context, index) => ChannelSubCard(
            sub: data[index],
            channelId: data[index].channelId,
          ),
        );
      },
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final notifier = ref.read(channelSubsTabCNP.notifier);
                  notifier.getChannelSubs(
                    channelId: widget.channelId,
                    index: widget.index,
                  );
                },
                child: const Text('Tap to retry'),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
