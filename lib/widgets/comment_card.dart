import 'package:flutter/material.dart';
import 'package:youtube_demo/services/common/helper_class.dart';

class CommentCard extends StatelessWidget {
  final String author;
  // TODO probably delete this
  final String? profileImageUrl;
  final String text;
  final int likeCount;
  final int replyCount;
  final String publishedTime;

  const CommentCard({
    super.key,
    required this.author,
    this.profileImageUrl,
    required this.text,
    required this.likeCount,
    required this.replyCount,
    required this.publishedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  foregroundImage: AssetImage(Helper.defaultPfp),
                  radius: 20,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        text,
                        softWrap: true,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '$likeCount likes • ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '$replyCount replies • ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            publishedTime,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
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
