import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';
import 'package:youtube_clone/logic/notifiers/subscription_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/ui/widgets/channel_tabs/channel_custom_sliver_header_delegate.dart';

class ChannelSliverPersistentHeader extends ConsumerStatefulWidget {
  final Channel channel;
  final VoidCallback onAboutPressed;

  const ChannelSliverPersistentHeader({
    super.key,
    required this.channel,
    required this.onAboutPressed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelSliverPersistentHeaderState();
}

class _ChannelSliverPersistentHeaderState extends ConsumerState<ChannelSliverPersistentHeader> {
  Future<void> getSubbedState({bool isReloading = false}) async {
    // TODO call method for checking subbed state for shorts here
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getSubbedState);
  }

  @override
  Widget build(BuildContext context) {
    // TODO change this in the future
    const subbed = AsyncLoading();
    final isDarkTheme = ref.watch(themeNP);

    return SliverPersistentHeader(
      floating: true,
      pinned: false,
      delegate: CustomSliverHeaderDelegate(
        maxHeight: 310,
        minHeight: 310,
        child: Column(
          children: [
            Image.asset(
              Helper.defaultThumbnail,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Image.asset(
                  Helper.defaultPfp,
                  height: 50,
                  width: 50,
                ),
                Text(
                  widget.channel.snippet.title,
                  style: const TextStyle(fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@${widget.channel.snippet.title}',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.channel.statistics?.subscriberCount != null
                          ? '${Helper.numberFormatter(widget.channel.statistics!.subscriberCount)} subscribers'
                          : 'unknown subscribers',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.channel.statistics?.videoCount != null
                          ? '${widget.channel.statistics?.videoCount} videos'
                          : 'unknown videos',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      enableFeedback: false,
                      onTap: widget.onAboutPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.channel.snippet.description.isNotEmpty
                                  ? widget.channel.snippet.description.split('\n')[0]
                                  : 'Check out the description',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                subbed.when(
                  data: (data) => SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    child: TextButton(
                      style: isDarkTheme
                          ? ButtonStyle(
                              backgroundColor: data
                                  ? const MaterialStatePropertyAll(
                                      Colors.white12,
                                    )
                                  : const MaterialStatePropertyAll(
                                      Colors.white,
                                    ),
                            )
                          : ButtonStyle(
                              backgroundColor: data
                                  ? const MaterialStatePropertyAll(Colors.red)
                                  : MaterialStatePropertyAll(
                                      Colors.red.shade600,
                                    ),
                            ),
                      onPressed: () {
                        final notifier =
                            ref.read(subscriptionNotifierProvider(widget.channel.id).notifier);
                        notifier.changeSubscriptionState();
                      },
                      child: Text(
                        data ? 'Subscribed' : 'Subscribe',
                        style: isDarkTheme
                            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: data ? Colors.white : Colors.black,
                                )
                            : Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () => getSubbedState(isReloading: true),
                      child: const Text('Retry'),
                    ),
                  ),
                  loading: () => Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10,
                      child: const TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: null,
                        child: SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
