import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// * shimmer for loading state of the video screen
class LoadingVideoScreen extends StatelessWidget {
  const LoadingVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade300,
      child: Column(
        children: [
          // * video title and other info
          ListTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Container(
                  height: 16,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                ),
                child: Container(
                  height: 14,
                  width: 175,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          const Divider(),
          const SizedBox(height: 3),
          // * actions row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 6),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      height: 12,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          // * author info section
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
              left: 15,
              right: 10,
              bottom: 4,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 16,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 36,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 5),
          // * comments section
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 3),
          // * video thumbnail
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
