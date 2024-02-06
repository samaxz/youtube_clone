import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_subs_notifier.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_sub_card.dart';

class ChannelSubsTab extends ConsumerStatefulWidget {
  final String channelId;
  final int screenIndex;

  const ChannelSubsTab({
    super.key,
    required this.channelId,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelSubsTabState();
}

class _ChannelSubsTabState extends ConsumerState<ChannelSubsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadSubs({bool isReloading = false}) async {
    final notifier = ref.read(channelSubsNotifierProvider(widget.screenIndex).notifier);
    await notifier.getChannelSubs(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadSubs);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final subs = ref.watch(channelSubsNotifierProvider(widget.screenIndex)).last;

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
          itemBuilder: (context, index) {
            return ChannelSubCard(
              sub: data[index],
              screenIndex: widget.screenIndex,
            );
          },
        );
      },
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;
        final code = failure.failureData.code;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (code == 403) ...[
                const Text('too many requests, try again later'),
              ] else if (code == 404) ...[
                const Text('oops, looks like it`s empty'),
              ] else ...[
                const Text('unknown error, try again later'),
              ],
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => loadSubs(isReloading: true),
                child: const Text('tap to retry'),
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
