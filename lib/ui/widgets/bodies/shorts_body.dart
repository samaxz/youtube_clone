import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/base_info_state.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body_player.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';

// this is used for displaying the "Shorts" text and
// subscriptions button when the short is paused
final pauseSP = StateProvider((ref) => false);

// this is used for identifying the current index of the
// current short out of a list of them that'll be played next
final shortIndexVN = ValueNotifier(0);

// this is a universal shorts body class, not dependent on
// the shorts screen class
class ShortsBody extends ConsumerStatefulWidget {
  final BaseInfoState<Video> shorts;
  final VoidCallback onLoadVideos;
  final VoidCallback onError;
  final int screenIndex;
  final bool backButtonOn;
  final int shortIndex;

  const ShortsBody({
    super.key,
    required this.shorts,
    required this.onLoadVideos,
    required this.onError,
    required this.screenIndex,
    this.backButtonOn = true,
    this.shortIndex = 0,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortsBodyState();
}

class _ShortsBodyState extends ConsumerState<ShortsBody> with AutomaticKeepAliveClientMixin {
  final pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => pageController.jumpToPage(widget.shortIndex),
    );
    widget.onLoadVideos.call();
    // log('_ShortsBodyState`s initState()');
  }

  @override
  void dispose() {
    if (!mounted) {
      pageController.dispose();
      // log('_ShortsBodyState`s pageController disposed');
    }
    super.dispose();
  }

  int lastIndex = 0;
  int shortIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final shorts = widget.shorts;
    // final shorts = ref.watch(shortsNotifierProvider(widget.index)).last;
    final screenIndex = ref.watch(currentScreenIndexSP);
    final shouldDisplaySubscription = ref.watch(pauseSP);

    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (index) {
            shortIndex = index;
            shortIndexVN.value = index;

            if (index == shorts.baseInfo.data.length - 1) {
              widget.onLoadVideos.call();
            }
          },
          scrollDirection: Axis.vertical,
          controller: pageController,
          itemCount: shorts.when(
            // + 1 makes it load another video for some reason
            loading: (baseInfo) => baseInfo.data.length,
            loaded: (baseInfo) => baseInfo.data.length,
            // do i even need + 1 here?
            error: (baseInfo, _) => baseInfo.data.length + 1,
          ),
          itemBuilder: (context, index) => shorts.when(
            loading: (baseInfo) {
              if (index < baseInfo.data.length) {
                return ShortsBodyPlayer(
                  short: baseInfo.data[index],
                  screenIndex: screenIndex,
                  currentScreenIndex: screenIndex,
                );
              } else {
                return const Center(
                  child: LoadingShortsBody(),
                );
              }
            },
            loaded: (baseInfo) => ShortsBodyPlayer(
              short: baseInfo.data[index],
              screenIndex: widget.screenIndex,
              shortIndex: shortIndexVN.value,
            ),
            error: (baseInfo, failure) {
              if (index < baseInfo.data.length) {
                return ShortsBodyPlayer(
                  short: baseInfo.data[index],
                  screenIndex: screenIndex,
                  currentScreenIndex: screenIndex,
                );
              } else {
                return Center(
                  child: FailureTile(
                    failure: failure,
                    onTap: widget.onError,
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (shouldDisplaySubscription && widget.backButtonOn) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Shorts',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ] else if (widget.backButtonOn) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ] else if (shouldDisplaySubscription) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Shorts',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
              ],
              IconButton(
                onPressed: () => Helper.pressSearch(
                  context: context,
                  ref: ref,
                  screenIndex: widget.screenIndex,
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
