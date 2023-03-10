import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/models/channel/channel_model.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';

class SearchSub extends ConsumerStatefulWidget {
  final Channel sub;
  final String channelId;
  final AuthState authState;

  const SearchSub({
    super.key,
    required this.sub,
    required this.channelId,
    required this.authState,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchSubState();
}

class _SearchSubState extends ConsumerState<SearchSub> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(subscriptionSNP.notifier)
          // * i could prolly watch both of these
          .getSubscriptionState(
            channelId: widget.channelId,
            // authState: widget.authState,
          ),
    );
  }

  void goToChannel() {
    // Helper.goToChannel(
    //   context: context,
    //   ref: ref,
    //   channelId: widget.channelId,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final subscribed = ref.watch(subscriptionSNP);

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
                // CachedNetworkImage(
                //   imageUrl: Helper.defaultPfp,
                //   width: 50,
                //   height: 50,
                // ),
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
                    // * i think this'll be a bit too big, i'mma need to
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
