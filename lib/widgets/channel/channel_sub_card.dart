import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/channel_subscription_new.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';

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

class _ChannelSubState extends ConsumerState<ChannelSubCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(subscriptionSNP.notifier)
          .getSubscriptionState(channelId: widget.channelId),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final subscribed = ref.watch(subscriptionSNP);

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
              // * i think this'll be a bit too big, i'ma need to
              // make my own button
              subscribed.when(
                data: (data) => GestureDetector(
                  onTap: () => ref
                      .read(subscriptionSNP.notifier)
                      .changeSubscriptionState(widget.channelId),
                  child: Text(
                    data
                        ? 'Subscribed'.toUpperCase()
                        : 'Subscribe'.toUpperCase(),
                    style: TextStyle(
                      color: data ? Colors.grey : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // TODO finish these states
                error: (error, stackTrace) => const Center(),
                loading: () => const Center(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
