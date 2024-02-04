// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/bodies/home_screen_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/lib_screen_body.dart';
import 'package:youtube_clone/ui/widgets/bodies/subs_screen_body.dart';
import 'package:youtube_clone/ui/widgets/custom_sliver_app_bar.dart';

class CommonBody extends ConsumerStatefulWidget {
  final int index;
  // TODO delete these fields, for they are useless
  final bool? displayExpandedHeight;
  final Widget? body;
  final ScrollController? scrollController;

  const CommonBody({
    super.key,
    required this.index,
    this.displayExpandedHeight = false,
    this.body,
    this.scrollController,
  });

  @override
  ConsumerState<CommonBody> createState() => _CommonBodyState();
}

class _CommonBodyState extends ConsumerState<CommonBody> {
  ScrollPhysics? setupScrollPhysics() {
    return widget.index == 0 ? null : const NeverScrollableScrollPhysics();
  }

  ScrollController setupScrollController() {
    late final ScrollController scrollController;

    switch (widget.index) {
      case 0:
        scrollController = ref.read(homeScrollControllerP);
      case 3:
        scrollController = ref.read(subsScrollControllerP);
      case 4:
        scrollController = ref.read(libScrollControllerP);
    }

    return scrollController;
  }

  bool setupDisplayingExpandedHeight() {
    return widget.index == 0 ? true : false;
  }

  Widget setupBody() {
    late final Widget body;

    switch (widget.index) {
      case 0:
        body = const HomeScreenBody();
      case 3:
        body = const SubsScreenBody();
      case 4:
        body = const LibScreenBody();
    }

    return body;
  }

  late final ScrollPhysics? scrollPhysics;
  late final ScrollController scrollController;
  late final bool displayExpandedHeight;
  late final Widget screenBody;

  @override
  void initState() {
    super.initState();
    scrollPhysics = setupScrollPhysics();
    scrollController = setupScrollController();
    displayExpandedHeight = setupDisplayingExpandedHeight();
    screenBody = setupBody();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: scrollPhysics,
      controller: scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        CustomSliverAppBar(
          displayExpandedHeight: displayExpandedHeight,
          index: widget.index,
        ),
      ],
      body: screenBody,
    );
  }
}
