// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/widgets/custom_sliver_app_bar.dart';

// ignore: must_be_immutable
class CommonBody extends ConsumerStatefulWidget {
  final bool displayExpandedHeight;
  final Widget body;
  final int index;

  const CommonBody({
    super.key,
    this.displayExpandedHeight = false,
    required this.body,
    required this.index,
  });

  @override
  ConsumerState<CommonBody> createState() => _CommonBodyState();
}

class _CommonBodyState extends ConsumerState<CommonBody> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ref.watch(scrollControllerP);

    return NestedScrollView(
      controller: scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        CustomSliverAppBar(
          displayExpandedHeight: widget.displayExpandedHeight,
          onTap: () {},
          index: widget.index,
        )
      ],
      body: widget.body,
    );
  }
}
