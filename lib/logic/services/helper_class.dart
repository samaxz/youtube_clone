import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/info/common_classes.dart';
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/visibility_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/ui/screens/authorization_screen.dart';
import 'package:youtube_clone/ui/widgets/build_action.dart';
import 'package:youtube_clone/ui/widgets/comment_card.dart';
import 'package:youtube_clone/ui/widgets/custom_search_delegate.dart';
import 'package:youtube_clone/ui/widgets/my_miniplayer.dart';
import 'package:youtube_clone/ui/widgets/popover.dart';
import 'package:youtube_clone/ui/widgets/show_modal_bottom_sheet_builder.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

// TODO find use for this or delete it
enum ModalBottomSheetType { addButtonType, otherType }

// instead of putting channel items here, i can check if the item is from
// channel or not
enum ScreenActions {
  videoCard,
  channelCard,
  shortsBody,
  playlist,
  playlistChannel,
  channel,
}

class Helper {
  const Helper._();

  static const defaultPfp = 'assets/default_pfp.png';
  static const defaultThumbnail = 'assets/default_thumb.png';
  static const youtubeLogo = 'assets/youtube.png';
  static const youtubeLogoDarkMode = 'assets/youtube_dark_mode.png';

  static final scaffoldKey = GlobalKey<ScaffoldState>();

  // actions that are performed on video tiles
  // show/perform/handle video actions/options
  static void showVideoActions({
    required BuildContext context,
    required WidgetRef ref,
    required VideoAction videoAction,
  }) {
    final actions = [
      BuildAction(
        Icons.watch_later_outlined,
        'Save to Watch Later',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
      BuildAction(
        Icons.playlist_add,
        'Save to playlist',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
      BuildAction(
        Icons.file_download_outlined,
        'Download video',
        onTap: () => downloadVideo(context: context, ref: ref, videoId: videoAction.videoId),
      ),
      BuildAction(
        Icons.share,
        'Share',
        onTap: () => share(context: context, id: videoAction.videoId),
      ),
      BuildAction(
        Icons.block,
        'Not interested',
        onTap: () {
          ref.read(visibilitySNP.notifier).changeValue(videoAction.videoIndex);
          videoAction.playerController.pause();
        },
      ),
      BuildAction(
        Icons.person_off_outlined,
        'Don`t recommend channel',
        onTap: () {
          ref.read(visibilitySNP.notifier).changeValue(videoAction.videoIndex);
          videoAction.playerController.pause();
        },
      ),
      BuildAction(
        Icons.flag_outlined,
        'Report',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
    ];

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: actions,
        enableExit: false,
      ),
    );
  }

  // TODO remove this in the future and use actual functions instead
  static void showOtherActions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      // isScrollControlled: true,
      useRootNavigator: true,
      useSafeArea: true,
      constraints: BoxConstraints(
          // minHeight: 200,
          // maxHeight: 10000,
          ),
      // isDismissible: true,
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 300),
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(10),
            child: const Text('coming soon'),
          ),
        ),
      ),
    );
  }

  // could also be called pressAddButton
  static void showAddButtonActions({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final actions = [
      BuildAction(
        Icons.play_arrow_outlined,
        'Crate a Short',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
      BuildAction(
        Icons.file_upload_outlined,
        'Upload a video',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
      BuildAction(
        Icons.podcasts_outlined,
        'Go live',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
      BuildAction(
        Icons.edit_note_outlined,
        'Create a post',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
    ];

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: actions,
        enableExit: false,
      ),
    );
  }

  static Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // ****** these methods are for the miniplayer
  static double valueFromPercentageInRange({
    required double min,
    required double max,
    required double percentage,
  }) {
    return percentage * (max - min) + min;
  }

  static double percentageFromValueInRange({
    required double min,
    required double max,
    required double value,
  }) {
    return (value - min) / (max - min);
  }
  // ***************************************

  static void pressVideoCard({
    required WidgetRef ref,
    required Video newVideo,
  }) {
    ref.read(miniPlayerControllerP).animateToHeight(state: PanelState.max);
    final selectedVideo = ref.read(selectedVideoSP);
    if (selectedVideo?.id == newVideo.id) return;
    ref.read(selectedVideoSP.notifier).update((state) => newVideo);
    // TODO add methods here
  }

  static void handleShowSearch({
    required BuildContext context,
    required WidgetRef ref,
    required int screenIndex,
  }) {
    // TODO remove this
    // ref.read(searchIndexProvider.notifier).setSearchIndex(screenIndex);
    // this is needed
    ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => true);
    final screensNotifier = ref.read(screensManagerProvider(screenIndex).notifier);
    final screensManager = ref.read(screensManagerProvider(screenIndex));
    if (screensManager.last.screenTypeAndId.screenType != ScreenType.search) {
      // this is the only way to make it work
      screensNotifier.pushScreen(
        CustomScreen.search(
          query: 'this is from handleShowSearch()',
          screenIndex: screenIndex,
        ),
        shouldPushNewScreen: false,
      );
    }
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(
        ref: ref,
        screenIndex: screenIndex,
      ),
    ).then((value) => screensNotifier.popScreen());
  }

  static void share({
    required BuildContext context,
    required String id,
    bool isVideoId = true,
  }) {
    late final Uri url;
    if (isVideoId) {
      url = Uri.https(
        'www.youtube.com',
        '/watch',
        {'v': id},
      );
    } else {
      url = Uri.https(
        'www.youtube.com',
        '/playlist',
        {'list': id},
      );
    }
    Share.shareUri(url);
  }

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();

      if (result == PermissionStatus.granted) {
        return true;
        // if the user has denied the permission twice
      } else if (result == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }

    return false;
  }

  static bool _isDownloading = false;

  static double progressIndicator = 0;

  static Future<void> _downloadVideo({
    // can't i simply use the video id?
    required explode.VideoId videoId,
    required explode.VideoQuality quality,
  }) async {
    try {
      // instantiate the class
      final yt = explode.YoutubeExplode();

      // get video meta data
      final videoInfo = await yt.videos.get(videoId);

      // gets available streams for the video
      final manifest = await yt.videos.streamsClient.getManifest(videoId);

      // info about video's stream info: codec, resolution...
      final manifestVideo = manifest.video.firstWhere(
        (element) => element.videoQuality == quality,
      );

      // get the stream of data for the specified video's stream info
      final videoStream = yt.videos.streamsClient.get(manifestVideo);

      // get the video and audio by quality, based on its index in the column
      final video = manifest.muxed.firstWhere(
        (element) => element.videoQuality == quality,
      );

      // create a file with a name and other info, as well as prohibit
      // unwanted characters
      final fileName =
          '${videoInfo.title}${DateTime.now().millisecondsSinceEpoch}.${video.container.name}'
              .replaceAll(r'\', '')
              .replaceAll('/', '')
              .replaceAll('*', '')
              .replaceAll(':', '')
              .replaceAll('?', '')
              .replaceAll('"', '')
              .replaceAll('<', '')
              .replaceAll('>', '')
              .replaceAll('|', '');

      final storageGranted = await requestPermission(Permission.videos);

      if (storageGranted) {
        final dir = Directory('/storage/emulated/0/Download/Youtube clone');

        if (!dir.existsSync()) {
          dir.createSync(recursive: true);
        }

        final file = File('${dir.path}/$fileName');

        if (file.existsSync()) {}

        if (_isDownloading) return;

        _isDownloading = true;

        final fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
        final len = video.size.totalBytes;
        double count = 0;

        await for (final data in videoStream) {
          count += data.length;
          final progress = ((count / len) * 100).ceil().toDouble();

          progressIndicator = progress;

          fileStream.add(data);
        }

        _isDownloading = false;

        await fileStream.flush();
        await fileStream.close();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static String _qualityNameConvert(String txt) {
    return '${txt.replaceAll(RegExp(r'[^0-9]'), '')}p';
  }

  static void downloadVideo({
    required BuildContext context,
    required WidgetRef ref,
    required String videoId,
  }) async {
    final videoUrl = explode.VideoId(videoId);
    // log('videoUrl: $videoUrl');

    final qualities = ref.watch(
      videoQualityFP(videoUrl),
    );

    // final qualities = await getVideoQualities(videoUrl);

    // log('qualities: $qualities');

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Center(
          child: Text('Select quality'),
        ),
        content: qualities.when(
          data: (data) {
            log('data state');
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: data
                  .map(
                    (quality) => Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        dense: true,
                        onTap: () async {
                          await _downloadVideo(
                            videoId: videoUrl,
                            quality: quality,
                          );

                          Future.delayed(
                            const Duration(seconds: 1),
                          ).then(
                            (value) => Navigator.of(context).pop(),
                          );
                        },
                        leading: Icon(MdiIcons.youtube),
                        trailing: const Icon(
                          Icons.download,
                          size: 20,
                        ),
                        title: Text(
                          _qualityNameConvert(
                            quality.toString(),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
          error: (error, stackTrace) {
            log('error state');
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: TextButton(
                    // TODO make this work
                    onPressed: () => ref.read(
                      videoQualityFP(videoUrl),
                    ),
                    child: const Text('Retry'),
                  ),
                ),
              ],
            );
          },
          loading: () {
            log('loading state');
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // TODO use data from notifier here
  static void saveToPlaylist(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: [
          BuildAction(
            Icons.playlist_add_outlined,
            'Save the video to playlist',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // shows the bottom sheet comments section
  static void showComments({
    required BuildContext context,
    required BaseInfo<Comment> commentsInfo,
  }) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => DraggableScrollableSheet(
        // TODO make this adaptive
        initialChildSize: 0.67,
        // maxChildSize: 1,
        minChildSize: 0.6,
        builder: (context, scrollController) => Popover(
          isCommentsSection: true,
          child: Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: commentsInfo.data.length,
              itemBuilder: (context, index) {
                final snippet = commentsInfo.data[index].snippet;
                final topLevelCommentSnippet = snippet.topLevelComment.topLevelCommentSnippet;
                final totalReplyCount = snippet.totalReplyCount;

                return CommentCard(
                  channelId: topLevelCommentSnippet.authorChannelId,
                  channelHandle: topLevelCommentSnippet.authorDisplayName,
                  text: topLevelCommentSnippet.textDisplay,
                  likeCount: topLevelCommentSnippet.likeCount,
                  replyCount: totalReplyCount,
                  publishedTime: topLevelCommentSnippet.updatedAt,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static String formatNumber(String initialNumber) {
    final numberAsString = initialNumber;
    late final String newNumber;
    switch (numberAsString.length) {
      // *********** thousands *********** //
      case 4:
        numberAsString[1] != 0.toString()
            ? newNumber = '${numberAsString[0]}.${numberAsString[1]}k'
            : newNumber = '${numberAsString[0]}k';
        break;

      case 5:
        numberAsString[2] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}k'
            : newNumber = '${numberAsString.substring(0, 2)}k';
        break;

      case 6:
        numberAsString[3] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}k'
            : newNumber = '${numberAsString.substring(0, 3)}k';
        break;

      // ************* millions ************* //
      case 7:
        numberAsString[1] != 0.toString()
            ? newNumber = '${numberAsString[0]}.${numberAsString[1]}m'
            : newNumber = '${numberAsString[0]}m';
        break;

      case 8:
        numberAsString[2] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}m'
            : newNumber = '${numberAsString.substring(0, 2)}m';
        break;

      case 9:
        numberAsString[3] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}m'
            : newNumber = '${numberAsString.substring(0, 3)}m';
        break;

      // ************* billions ************* //
      case 10:
        numberAsString[1] != 0.toString()
            ? newNumber = '${numberAsString[0]}.${numberAsString[1]}b'
            : newNumber = '${numberAsString[0]}b';
        break;

      case 11:
        numberAsString[2] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}b'
            : newNumber = '${numberAsString.substring(0, 2)}b';
        break;

      case 12:
        numberAsString[3] != 0.toString()
            ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}b'
            : newNumber = '${numberAsString.substring(0, 3)}b';
        break;

      default:
        newNumber = numberAsString;
    }

    return newNumber;
  }

  static Duration _parseDuration(String iso8601Duration) {
    Duration duration = const Duration();

    // Regular expression to extract days, hours, minutes, and seconds from
    // the ISO 8601 duration
    final regex = RegExp(r'P(?:(\d+)D)?T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(iso8601Duration);

    if (match != null) {
      // Extract days, hours, minutes, and seconds from the match
      final days = int.tryParse(match[1] ?? '0') ?? 0;
      final hours = int.tryParse(match[2] ?? '0') ?? 0;
      final minutes = int.tryParse(match[3] ?? '0') ?? 0;
      final seconds = int.tryParse(match[4] ?? '0') ?? 0;

      // Create a Duration object
      duration = Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
    }

    return duration;
  }

  static String _getRemainder(int time) {
    final timeRemaining = time.remainder(60);
    // default time if none of the below conditions match
    String newTime = timeRemaining.toString();

    if (timeRemaining == 0) {
      newTime = '00';
    } else if (timeRemaining < 10) {
      newTime = '0$timeRemaining';
    }

    return newTime;
  }

  static String _formatDuration(Duration duration) {
    late final String newDuration;

    final hoursRem = duration.inHours.remainder(60);
    final minsRem = duration.inMinutes.remainder(60);
    // sussy name
    final secsRem = duration.inSeconds.remainder(60);

    if (duration.inDays > 0) {
      // Format the duration as days, hours, minutes, and seconds
      newDuration =
          '${duration.inDays}:${_getRemainder(hoursRem)}:${_getRemainder(minsRem)}:${_getRemainder(secsRem)}';
    } else if (duration.inHours > 0) {
      // Format the duration as hours, minutes, and seconds
      newDuration = '${duration.inHours}:${_getRemainder(minsRem)}:${_getRemainder(secsRem)}';
    } else if (duration.inMinutes > 0) {
      // Format the duration as minutes and seconds
      newDuration = '${duration.inMinutes}:${_getRemainder(secsRem)}';
    } else {
      // If duration is less than a minute, display seconds
      newDuration = '0:${duration.inSeconds < 10 ? '0${duration.inSeconds}' : duration.inSeconds}';
    }

    return newDuration;
  }

  static String formatDuration(String isoDuration) {
    final duration = _parseDuration(isoDuration);
    final newDuration = _formatDuration(duration);
    return newDuration;
  }

  static Future<void> authenticate({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(authNotifierProvider.notifier).signIn(
      (authorizationUrl) {
        final completer = Completer<Uri>();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AuthorizationScreen(
              authorizationUrl: authorizationUrl,
              onAuthorizationCodeRedirectAttempt: (redirectedUrl) {
                completer.complete(redirectedUrl);
              },
            ),
          ),
        );
        return completer.future;
      },
    );
    if (!context.mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
    // TODO invalidate videos and other notifiers here
    // TODO update all the state notifier providers here to stop any
    // video and short, as well as hide the mp (and maybe do some other
    // stuff)
  }

  static void handleUnauthAttempt({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final authState = ref.read(authNotifierProvider);
    showModalBottomSheet(
      context: context,
      // this enables the mbs to be full screen
      isScrollControlled: true,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.clear),
                ),
                const Spacer(),
              ],
            ),
            authState.maybeWhen(
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
              authenticated: () => Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .signOut()
                          .whenComplete(() => Navigator.of(context).pop());
                    },
                    child: const Text('sign out of your account'),
                  ),
                ),
              ),
              unauthenticated: () => Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      authenticate(ref: ref, context: context);
                    },
                    child: const Text('sign in to your account'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String removePrefix(String url) {
    final pattern = RegExp(r'^(https?://)?(www\.)?');
    return url.replaceAll(pattern, '');
  }
}
