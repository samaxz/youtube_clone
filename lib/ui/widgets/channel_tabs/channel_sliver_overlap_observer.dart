import 'package:flutter/material.dart';

class ChannelSliverOverlapAbsorber extends StatelessWidget {
  final TabController tabController;

  const ChannelSliverOverlapAbsorber({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        toolbarHeight: 0,
        leading: const SizedBox.shrink(),
        pinned: true,
        elevation: 0,
        bottom: TabBar(
          isScrollable: true,
          controller: tabController,
          tabs: const [
            Tab(child: Text('Home')),
            Tab(child: Text('Videos')),
            Tab(child: Text('Shorts')),
            Tab(child: Text('Playlists')),
            Tab(child: Text('Community')),
            Tab(child: Text('Channels')),
            Tab(child: Text('About')),
          ],
        ),
      ),
    );
  }
}
