import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/services/theme_notifier.dart';
import 'package:youtube_clone/logic/notifiers/visibility_notifier.dart';

class HiddenVideoCard extends ConsumerWidget {
  final int index;

  const HiddenVideoCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNP);

    return Container(
      color: isDarkTheme ? Theme.of(context).colorScheme.onPrimary : Colors.blueGrey,
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Video removed',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(visibilitySNP.notifier).changeValue(index, value: false);
            },
            child: Text(
              'Undo',
              style: TextStyle(color: Colors.blue.shade300),
            ),
          ),
        ],
      ),
    );
  }
}
