import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';

class ChannelSubCard extends ConsumerStatefulWidget {
  final ChannelSubscription sub;
  final String channelId;

  const ChannelSubCard({
    super.key,
    required this.sub,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelSubState();
}

class _ChannelSubState extends ConsumerState<ChannelSubCard> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> getSubbedState() async {
    final notifier = ref.read(subscriptionNotifierProvider(widget.channelId).notifier);
    await notifier.getSubscriptionState();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getSubbedState);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // final subscribed = ref.watch(subscriptionSNP);
    final subscribed = ref.watch(subscriptionNotifierProvider(widget.channelId)).last;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SizedBox(width: 45),
          Image.asset(
            Helper.defaultPfp,
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 45),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.sub.title),
              Text(
                '${widget.sub.subscriberCount != null ? Helper.numberFormatter(widget.sub.subscriberCount!.toString()) : 'unknown'}  •  ${widget.sub.videoCount != null ? Helper.numberFormatter(widget.sub.videoCount.toString()) : 'unknown'} videos',
              ),
              // i think this'll be a bit too big, i'ma need to
              // make my own button
              subscribed.when(
                data: (data) => GestureDetector(
                  onTap: () {
                    final notifier =
                        ref.read(subscriptionNotifierProvider(widget.channelId).notifier);
                    notifier.changeSubscriptionState();
                  },
                  child: Text(
                    data ? 'SUBSCRIBED' : 'SUBSCRIBE',
                    style: TextStyle(
                      color: data ? Colors.grey : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // TODO finish these states
                error: (error, stackTrace) => Center(
                  child: TextButton(
                    onPressed: getSubbedState,
                    child: const Text('try again'),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
