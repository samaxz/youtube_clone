import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_demo/services/common/providers.dart';

// * shimmer for loading state of videos inside home
// screen body and searched videos list
class LoadingVideosScreen extends ConsumerWidget {
  const LoadingVideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentScreenIndexSP);

    // * temporary solution, but it works - for now, at least
    return index != 0
        ? const SizedBox()
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300,
            child: Column(
              children: [
                // const SizedBox(height: 55),
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 12,
                              width: 220,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 12,
                              width: 290,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 12,
                              width: 220,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 12,
                              width: 290,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 12,
                              width: 220,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 12,
                              width: 290,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
