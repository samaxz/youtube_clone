import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';
import 'package:youtube_clone/logic/notifiers/channel/channel_about_notifier.dart';

class ChannelAboutTab extends ConsumerStatefulWidget {
  final String channelId;
  final int screenIndex;

  const ChannelAboutTab({
    super.key,
    required this.channelId,
    required this.screenIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChannelSubsTabState();
}

class _ChannelSubsTabState extends ConsumerState<ChannelAboutTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> loadAbout({bool isReloading = false}) async {
    final notifier = ref.read(channelAboutNotifierProvider(widget.screenIndex).notifier);
    await notifier.getAbout(widget.channelId, isReloading: isReloading);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadAbout);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final about = ref.watch(channelAboutNotifierProvider(widget.screenIndex)).last;

    return about.when(
      data: (data) => ListView(
        padding: const EdgeInsets.fromLTRB(10, 55, 10, 10),
        children: [
          if (data.description != null) ...[
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(data.description!),
            const SizedBox(height: 10),
          ],
          if (data.links.isNotEmpty) ...[
            const Text(
              'Links',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            for (int i = 0; i < data.links.length; i++) ...{
              if (data.links[i]?.title != null && data.links[i]?.url != null)
                GestureDetector(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 40,
                            child: AnyLinkPreview(
                              link: data.links[i]!.url!,
                              showMultimedia: true,
                              // TODO change this
                              errorImage:
                                  'https://sm.pcmag.com/t/pcmag_au/review/g/google-and/google-android-11_egj3.3840.png',
                            ),
                          ),
                          const SizedBox(width: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.links[i]!.title!),
                              GestureDetector(
                                onTap: () => launchUrlString(
                                  'http://www.youtube.com/${data.links[i]!.url}',
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Text(
                                    Helper.removePrefix(data.links[i]!.url!),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            },
            const SizedBox(height: 10),
          ],
          if (data.handle != null ||
              data.location != null ||
              data.stats?.joinedDate != null ||
              data.stats?.viewCount != null) ...[
            const Text(
              'More info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (data.handle != null) ...[
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => launchUrlString(
                  'http://www.youtube.com/${data.handle}',
                ),
                child: Row(
                  children: [
                    Icon(MdiIcons.web),
                    const SizedBox(width: 7),
                    Text(
                      'http://www.youtube.com/${data.handle}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
            ],
            if (data.location != null) ...[
              Row(
                children: [
                  Icon(MdiIcons.earth),
                  const SizedBox(width: 7),
                  Text(data.location!),
                ],
              ),
              const SizedBox(height: 7),
            ],
            if (data.stats?.joinedDate != null) ...[
              Row(
                children: [
                  Icon(MdiIcons.informationOutline),
                  const SizedBox(width: 7),
                  Text(
                    'Joined ${data.stats?.joinedDate != null ? DateFormat('yMMMd').format(DateTime.fromMillisecondsSinceEpoch(int.parse('${data.stats!.joinedDate!}000'), isUtc: true)).replaceAll(',', '') : 'unknown'}',
                  ),
                ],
              ),
              const SizedBox(height: 7),
            ],
            if (data.stats?.viewCount != null) ...[
              Row(
                children: [
                  Icon(MdiIcons.chartLineVariant),
                  const SizedBox(width: 7),
                  Text(
                    '${data.stats?.viewCount == null ? 'unknown' : Helper.formatNumber(data.stats!.viewCount!.toString())} views',
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
      error: (error, stackTrace) {
        final failure = error as YoutubeFailure;
        final code = failure.failureData.code;

        return Center(
          // TODO probably delete this in the future
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (code == 403) ...[
                  const Text('too many requests, try again later'),
                ] else if (code == 404) ...[
                  const Text('oops, looks like it`s empty'),
                ] else ...[
                  const Text('unknown error, try again later'),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => loadAbout(isReloading: true),
                  child: const Text('tap to retry'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
