import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';

// TODO remove this
class FullShortBody extends ConsumerWidget {
  final BaseInfoState<Video> shorts;
  final VoidCallback onLoadMoreShorts;
  final VoidCallback onError;
  final int screenIndex;

  const FullShortBody({
    super.key,
    required this.shorts,
    required this.onLoadMoreShorts,
    required this.onError,
    required this.screenIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldDisplaySubscription = ref.watch(pauseSP);
    return Stack(
      children: [
        shorts.when(
          loading: (_) => const Center(
            child: LoadingShortsBody(),
          ),
          loaded: (baseInfo) => ShortsBody(
            screenIndex: screenIndex,
            backButtonOn: false,
            shorts: shorts,
            onLoadMoreShorts: onLoadMoreShorts,
            onError: onError,
          ),
          error: (_, failure) => Center(
            child: FailureTile(
              failure: failure,
              onTap: onError,
            ),
          ),
        ),
        // shorts screen appbar
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (shouldDisplaySubscription) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    children: [
                      Text(
                        'Shorts',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // TODO add subscriptions button here
                    ],
                  ),
                ),
                const Spacer(),
              ],
              IconButton(
                onPressed: () => Helper.pressSearch(
                  context: context,
                  ref: ref,
                  screenIndex: screenIndex,
                ),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
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
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'this section is a work in progress, but you get a snack bar',
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('snack bar!'),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('show the snack bar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                // TODO change this
                onPressed: () => Helper.showOtherActions(context),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
