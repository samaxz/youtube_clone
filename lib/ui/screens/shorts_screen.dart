import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/shorts/shorts_notifier.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/ui/widgets/bodies/shorts_body.dart';
import 'package:youtube_clone/ui/widgets/failure_tile.dart';
import 'package:youtube_clone/ui/widgets/full_short_body.dart';
import 'package:youtube_clone/ui/widgets/shimmers/loading_shorts_body.dart';

class ShortsScreen extends ConsumerStatefulWidget {
  const ShortsScreen({super.key});

  @override
  ConsumerState createState() => _ShortsScreenState();
}

class _ShortsScreenState extends ConsumerState<ShortsScreen> {
  Future<void> getShorts() async {
    final notifier = ref.read(shortsNotifierProvider(1).notifier);
    await notifier.getShorts();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(getShorts);
    // Future.delayed(const Duration(seconds: 1), getShorts);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(screensManagerProvider(1), (_, state) {
      final notifier = ref.read(screensManagerProvider(1).notifier);
      if (!notifier.shouldPush) return;
      Navigator.of(context)
          .push(
            MaterialPageRoute(builder: (context) => state.last.screen),
          )
          .whenComplete(
            () => notifier.popScreen(),
          );
    });
    final shorts = ref.watch(shortsNotifierProvider(1)).last;
    return ShortsBody(
      screenIndex: 1,
      backButtonOn: false,
      shorts: shorts,
      onLoadMoreShorts: getShorts,
      onError: getShorts,
    );
    // TODO remove these
    // return FullShortBody(
    //   shorts: shorts,
    //   onLoadMoreShorts: getShorts,
    //   onError: getShorts,
    //   screenIndex: 1,
    // );
    // final shouldDisplaySubscription = ref.watch(pauseSP);
    // return Stack(
    //   children: [
    //     shorts.when(
    //       loading: (_) => const Center(
    //         child: LoadingShortsBody(),
    //       ),
    //       loaded: (baseInfo) => ShortsBody(
    //         screenIndex: 1,
    //         backButtonOn: false,
    //         shorts: baseInfo,
    //         onLoadVideos: getShorts,
    //         onError: getShorts,
    //       ),
    //       error: (_, failure) => Center(
    //         child: FailureTile(
    //           failure: failure,
    //           onTap: getShorts,
    //         ),
    //       ),
    //     ),
    //     // shorts screen appbar
    //     Padding(
    //       padding: const EdgeInsets.only(top: 40, left: 5),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           if (shouldDisplaySubscription) ...[
    //             const Padding(
    //               padding: EdgeInsets.only(left: 5),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     'Shorts',
    //                     style: TextStyle(
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                   ),
    //                   // TODO add subscriptions button here
    //                 ],
    //               ),
    //             ),
    //             const Spacer(),
    //           ],
    //           IconButton(
    //             onPressed: () => Helper.pressSearch(
    //               context: context,
    //               ref: ref,
    //               screenIndex: 1,
    //             ),
    //             icon: const Icon(
    //               Icons.search,
    //               color: Colors.white,
    //             ),
    //           ),
    //           IconButton(
    //             onPressed: () => showModalBottomSheet(
    //               context: context,
    //               isScrollControlled: true,
    //               useSafeArea: true,
    //               builder: (context) => SizedBox(
    //                 height: MediaQuery.of(context).size.height,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         IconButton(
    //                           onPressed: () => Navigator.of(context).pop(),
    //                           icon: const Icon(Icons.clear),
    //                         ),
    //                         const Spacer(),
    //                       ],
    //                     ),
    //                     Expanded(
    //                       child: Center(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             const Text(
    //                               'this section is a work in progress, but you get a snack bar',
    //                             ),
    //                             ElevatedButton(
    //                               onPressed: () {
    //                                 ScaffoldMessenger.of(context).showSnackBar(
    //                                   const SnackBar(
    //                                     content: Text('snack bar!'),
    //                                   ),
    //                                 );
    //                                 Navigator.of(context).pop();
    //                               },
    //                               child: const Text('show the snack bar'),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             icon: const Icon(
    //               Icons.camera_alt_outlined,
    //               color: Colors.white,
    //             ),
    //           ),
    //           IconButton(
    //             // TODO change this
    //             onPressed: () => Helper.showOtherActions(context),
    //             icon: const Icon(
    //               Icons.more_vert,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
