import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';

class FailureTile extends ConsumerWidget {
  final YoutubeFailure failure;
  final VoidCallback onTap;

  const FailureTile({
    super.key,
    required this.failure,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      iconColor: Theme.of(context).colorScheme.onError,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        // this can change according to the current
        // theme (dark / light)
        color: Theme.of(context).colorScheme.error,
        child: ListTile(
          title: const Text('An error occurred, please, retry'),
          subtitle: Text(
            failure.when(
              (failureData) => failureData.message.toString(),
              noConnection: (value) {
                return value.message != null ? value.message! : 'No internet connection';
              },
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const SizedBox(
            height: double.infinity,
            child: Icon(Icons.warning),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
