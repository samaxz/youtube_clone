import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/data/info/base_info_state.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/helper_class.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_demo/widgets/failure_tile.dart';
import 'package:youtube_demo/widgets/shimmers/loading_shorts_body.dart';
import 'package:youtube_demo/widgets/bodies/shorts_body_player.dart';

final pauseNotifierProvider = StateProvider((ref) => false);

final currentIndexVN = ValueNotifier(0);

// * this is a universal shorts body class, not dependent on
// the shorts screen class
class ShortsBody extends ConsumerStatefulWidget {
  final BaseInfoState<Video> shorts;
  final VoidCallback onLoadVideos;
  final VoidCallback onError;
  final int index;
  final bool backButtonOn;
  final int shortIndex;

  const ShortsBody({
    super.key,
    required this.shorts,
    required this.onLoadVideos,
    required this.onError,
    required this.index,
    this.backButtonOn = true,
    this.shortIndex = 0,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShortsBodyState();
}

class _ShortsBodyState extends ConsumerState<ShortsBody>
    with AutomaticKeepAliveClientMixin {
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
  }

  late IconButton backButton;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    backButton = IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.chevron_left,
        color: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    if (!mounted) {
      pageController.dispose();
    }
    super.dispose();
  }

  final shortsText = const Padding(
    padding: EdgeInsets.only(left: 0),
    child: Text(
      'Shorts',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  int lastIndex = 0;

  // * i mean...
  // Future<void> getShorts() async {
  //   final authState = ref.watch(authNP);
  //   ref.read(shortsNotifierProvider.notifier).getShorts(authState: authState);
  // }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final shorts = widget.shorts;
    final authState = ref.watch(authNP);
    final currentScreenIndex = ref.watch(currentScreenIndexSP);
    final shouldDisplayShorts = ref.watch(pauseNotifierProvider);

    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (index) {
            currentIndex = index;
            currentIndexVN.value = index;
            if (index == shorts.baseInfo.data.length - 1) {
              widget.onLoadVideos.call();
            }
          },
          scrollDirection: Axis.vertical,
          controller: pageController,
          itemCount: shorts.when(
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
                  authState: authState,
                  index: currentScreenIndex,
                  currentScreenIndex: currentScreenIndex,
                );
              } else {
                return const Center(
                  child: LoadingShortsBody(),
                );
              }
            },
            loaded: (baseInfo) {
              return ShortsBodyPlayer(
                short: baseInfo.data[index],
                authState: authState,
                index: widget.index,
                currentIndex: currentIndexVN.value,
              );
            },
            error: (baseInfo, failure) {
              if (index < baseInfo.data.length) {
                return ShortsBodyPlayer(
                  short: baseInfo.data[index],
                  authState: authState,
                  index: currentScreenIndex,
                  currentScreenIndex: currentScreenIndex,
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
          padding: const EdgeInsets.only(
            top: 10,
            left: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (shouldDisplayShorts && widget.backButtonOn) ...[
                backButton,
                shortsText,
                const Spacer(),
              ] else if (widget.backButtonOn) ...[
                backButton,
                const Spacer(),
              ] else if (shouldDisplayShorts) ...[
                shortsText,
                const Spacer(),
              ],
              IconButton(
                onPressed: () => Helper.handleShowSearch(
                  context: context,
                  ref: ref,
                  index: widget.index,
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
                onPressed: () => Helper.handleMoreVertPressed(
                  context: context,
                  ref: ref,
                  screenIdAndActions: ScreenIdAndActions(
                    id: shorts.baseInfo.data[lastIndex].id,
                    actions: ScreenActions.shortsBody,
                  ),
                ),
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
