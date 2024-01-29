import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';

class FailureTile extends ConsumerWidget {
  final YoutubeFailure failure;
  final VoidCallback onTap;
  // TODO find use for this or delete this
  final ErrorTypeReload type;

  const FailureTile({
    super.key,
    required this.failure,
    required this.onTap,
    this.type = ErrorTypeReload.homeScreen,
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
              (failureData) {
                // log('failureData inside failure tile: $failureData');
                return failureData.message.toString();
              },
              noConnection: (value) {
                // log('no inet value inside failure tile is: $value');
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
