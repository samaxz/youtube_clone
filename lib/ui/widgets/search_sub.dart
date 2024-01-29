import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/custom_screen.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';

// subscription card shown in search
class SearchSub extends ConsumerStatefulWidget {
  final Channel sub;
  final String channelId;

  const SearchSub({
    super.key,
    required this.sub,
    required this.channelId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchSubState();
}

class _SearchSubState extends ConsumerState<SearchSub> {
  Future<void> getSubbedState() async {
    final notifier = ref.read(subscriptionNotifierProvider(widget.channelId).notifier);
    await notifier.getSubscriptionState();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getSubbedState);
  }

  void goToChannel() {
    // TODO research this and probably use passed in index
    final index = ref.read(currentScreenIndexSP);
    final notifier = ref.read(screensManagerProvider(index).notifier);
    notifier.pushScreen(
      CustomScreen.channel(channelId: widget.channelId, screenIndex: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final subscribed = ref.watch(subscriptionSNP);
    final subscribed = ref.watch(subscriptionNotifierProvider(widget.channelId)).last;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: goToChannel,
      onLongPress: goToChannel,
      child: Column(
        children: [
          // const Divider(
          //   // height: 0,
          //   thickness: 0.2,
          //   color: Colors.white,
          // ),
          Padding(
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
                    Text(widget.sub.snippet.title),
                    // TODO prolly do something with the nulls, idk
                    Text(
                      '${widget.sub.statistics?.subscriberCount != null ? Helper.numberFormatter(widget.sub.statistics!.subscriberCount) : 'unknown'}  •  ${widget.sub.statistics?.videoCount} videos',
                    ),
                    // i think this'll be a bit too big, i'mma need to
                    // make my own button
                    subscribed.when(
                      data: (data) => GestureDetector(
                        onTap: () {
                          final notifier =
                              ref.read(subscriptionNotifierProvider(widget.channelId).notifier);
                          notifier.getSubscriptionState();
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
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
