import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/models/comment_model.dart';
import 'package:youtube_demo/data/models/video/video_model.dart';
import 'package:youtube_demo/screens/authorization_screen.dart';
import 'package:youtube_demo/screens/nav_screen.dart';
import 'package:youtube_demo/services/common/common_classes.dart';
import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/visibility_notifier.dart';
import 'package:youtube_demo/services/oauth2/auth_notifier.dart';
import 'package:youtube_demo/services/oauth2/providers.dart';
import 'package:youtube_demo/widgets/build_action.dart';
import 'package:youtube_demo/widgets/comment_card.dart';
import 'package:youtube_demo/widgets/custom_search_delegate.dart';
import 'package:youtube_demo/widgets/popover.dart';
import 'package:youtube_demo/widgets/searched_videos_list.dart';
import 'package:youtube_demo/widgets/show_modal_bottom_sheet_builder.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;
import 'package:share_plus/share_plus.dart';

enum ErrorTypeReload { homeScreen, searchScreen }

enum ModalBottomSheetType { addButtonType, otherType }

// * instead of putting channel items here, i can check if the item is from
// channel or not
enum ScreenActions {
  videoCard,
  channelCard,
  shortsBody,
  playlist,
  playlistChannel,
  channel,
}

class Uploads {
  final List<Video> videos;
  final List<Video> shorts;

  const Uploads({
    required this.videos,
    required this.shorts,
  });
}

class VideoTypes {
  final List<Video> videos;
  final List<Video> shorts;

  const VideoTypes({
    required this.videos,
    required this.shorts,
  });
}

class Helper {
  const Helper._();

  static const defaultPfp = 'assets/default_pfp.png';
  static const defaultThumbnail = 'assets/default_thumb.png';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static List<Widget> getVideoCardActions({
    required BuildContext context,
    required WidgetRef ref,
    required String videoId,
    required int videoCardIndex,
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
        onTap: () => showDownloadPressed(
          context: context,
          ref: ref,
          videoId: videoId,
        ),
      ),
      BuildAction(
        Icons.share,
        'Share',
        onTap: () => share(
          context: context,
          link: 'https://youtu.be/$videoId',
        ),
      ),
      BuildAction(
        Icons.block,
        'Not interested',
        onTap: () =>
            ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
      ),
      BuildAction(
        Icons.person_off_outlined,
        'Don`t recommend channel',
        onTap: () =>
            ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
      ),
      BuildAction(
        Icons.flag_outlined,
        'Report',
        onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
      ),
    ];

    return actions;
  }

  static List<Widget> getAddButtonActions(WidgetRef ref) {
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

    return actions;
  }

  static Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // ******* these methods are for the mini player
  static double valueFromPercentageInRange({
    required double min,
    required double max,
    required double percentage,
  }) =>
      percentage * (max - min) + min;

  static double percentageFromValueInRange({
    required double min,
    required double max,
    required double value,
  }) =>
      (value - min) / (max - min);
  // ***************************************

  // * resets all the data about a video and loads new data
  // TODO remove unnecessary methods from here
  static void handleVideoCardPressed({
    required WidgetRef ref,
    // * new video that'll be selected
    required Video video,
  }) {
    final selectedVideo = ref.read(selectedVideoSP);
    if (selectedVideo?.id == video.id) return;

    ref.read(selectedVideoSP.notifier).update((state) => video);
    ref.read(showSearchSP.notifier).update((state) => true);
  }

  static void handleShowSearch({
    required BuildContext context,
    required WidgetRef ref,
    required int index,
  }) {
    ref.read(pushedHomeChannelSP.notifier).update((state) => true);
    // TODO probably delete this, cause it's kinda useless
    ref.read(searchIndexProvider.notifier).setSearchIndex(index);
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(ref, index),
    );
  }

  static void handleMoreVertPressed({
    required BuildContext context,
    required WidgetRef ref,
    required ScreenIdAndActions screenIdAndActions,
    int? videoCardIndex,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) {
        switch (screenIdAndActions.actions) {
          case ScreenActions.videoCard:
            return ShowModalBottomSheetBuilder(
              actions: getVideoCardActions(
                ref: ref,
                context: context,
                videoId: screenIdAndActions.id!,
                videoCardIndex: videoCardIndex!,
              ),
            );

          case ScreenActions.channelCard:
            return Container();

          // TODO finish these
          case ScreenActions.shortsBody:
            return Container();

          case ScreenActions.playlist:
            return Container();

          case ScreenActions.playlistChannel:
            return Container();

          case ScreenActions.channel:
            return Container();
        }
      },
    );
  }

  static void handleAddButtonPressed({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: getAddButtonActions(ref),
        enableHomeIndicator: false,
        isAddContentButton: true,
      ),
    );
  }

  // TODO make use of this
  static void handleSharePressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: [
          BuildAction(
            Icons.reply_outlined,
            'Share the video',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  static Future<void> share({
    required BuildContext context,
    required String link,
  }) async {
    await Share.share(link);
  }

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
        // * if the user has denied the permission twice
      } else if (result == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }

    return false;
  }

  static bool _isDownloading = false;

  static double progressIndicator = 0;

  static Future<void> downloadVideo({
    // * can't i simply use the video id?
    required explode.VideoId videoId,
    required explode.VideoQuality quality,
  }) async {
    try {
      // * instantiate the class
      final yt = explode.YoutubeExplode();

      // * get video meta data
      final videoInfo = await yt.videos.get(videoId);

      // * gets available streams for the video
      final manifest = await yt.videos.streamsClient.getManifest(videoId);

      // * info about video's stream info: codec, resolution...
      final manifestVideo = manifest.video.firstWhere(
        (element) => element.videoQuality == quality,
      );

      // * get the stream of data for the specified video's stream info
      final videoStream = yt.videos.streamsClient.get(manifestVideo);

      // * get the video and audio by quality, based on its index in the column
      final video = manifest.muxed.firstWhere(
        (element) => element.videoQuality == quality,
      );

      // * create a file with a name and other info, as well as prohibit
      // * unwanted characters
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
        final dir = Directory('/storage/emulated/0/Download/Youtube Demo');

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

  static Future<void> showDownloadPressed({
    required BuildContext context,
    required WidgetRef ref,
    required String videoId,
  }) async {
    final videoUrl = explode.VideoId(videoId);
    log('videoUrl: $videoUrl');

    final qualities = ref.watch(
      videoQualityFP(videoUrl),
    );

    log('qualities: $qualities');

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
          data: (data) => Column(
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
                        await downloadVideo(
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
          ),
          error: (error, stackTrace) => Column(
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
          ),
          loading: () => const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void handleSavePressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (context) => ShowModalBottomSheetBuilder(
        actions: [
          BuildAction(
            Icons.reply_outlined,
            'Share the video',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // shows the bottom sheet comments section
  static void handleCommentsPressed({
    required BuildContext context,
    required BaseInfo<Comment> commentsInfo,
  }) {
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => DraggableScrollableSheet(
        // TODO make this adaptive
        initialChildSize: 0.68,
        maxChildSize: 1,
        // not sure this is the right value
        minChildSize: 0.68,
        builder: (context, scrollController) => Popover(
          isCommentsSection: true,
          child: Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: commentsInfo.data.length,
              itemBuilder: (context, index) {
                if (commentsInfo.disabled != null ||
                    commentsInfo.failure != null) {
                  return const Center(
                    child: Text('comments are private'),
                  );
                }

                final topLevelCommentSnippet = commentsInfo
                    .data[index].snippet.topLevelComment.topLevelCommentSnippet;
                final totalReplyCount =
                    commentsInfo.data[index].snippet.totalReplyCount;

                return CommentCard(
                  author: topLevelCommentSnippet.authorDisplayName,
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

  static String numberFormatter(String initialNumber) {
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
            ? newNumber =
                '${numberAsString.substring(0, 2)}.${numberAsString[2]}k'
            : newNumber = '${numberAsString.substring(0, 2)}k';
        break;

      case 6:
        numberAsString[3] != 0.toString()
            ? newNumber =
                '${numberAsString.substring(0, 3)}.${numberAsString[3]}k'
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
            ? newNumber =
                '${numberAsString.substring(0, 2)}.${numberAsString[2]}m'
            : newNumber = '${numberAsString.substring(0, 2)}m';
        break;

      case 9:
        numberAsString[3] != 0.toString()
            ? newNumber =
                '${numberAsString.substring(0, 3)}.${numberAsString[3]}m'
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
            ? newNumber =
                '${numberAsString.substring(0, 2)}.${numberAsString[2]}b'
            : newNumber = '${numberAsString.substring(0, 2)}b';
        break;

      case 12:
        numberAsString[3] != 0.toString()
            ? newNumber =
                '${numberAsString.substring(0, 3)}.${numberAsString[3]}b'
            : newNumber = '${numberAsString.substring(0, 3)}b';
        break;

      default:
        newNumber = numberAsString;
    }

    return newNumber;
  }

  static String formatDuration(String duration) {
    final regExp = RegExp(r'(\d+)S|(\d+)M|(\d+)H');
    final match = regExp.allMatches(duration).toList();
    int seconds = 0;
    int minutes = 0;
    int hours = 0;

    for (int i = 0; i < match.length; i++) {
      final m = match[i];
      if (m.group(1) != null) {
        seconds += int.parse(m.group(1)!);
      } else if (m.group(2) != null) {
        minutes += int.parse(m.group(2)!);
        // TODO remove hours if they're empty
      } else if (m.group(3) != null) {
        hours += int.parse(m.group(3)!);
      }
    }

    final durationDuration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    final durationString =
        durationDuration.toString().split('.').first.padLeft(8, '0');

    return durationString;
  }

  static void handleAuthButtonPressed({
    required BuildContext context,
    required WidgetRef ref,
    required AuthState authState,
  }) =>
      showModalBottomSheet(
        context: context,
        // so this can be full screen
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
                            .read(authNP.notifier)
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
                      onPressed: () async {
                        await ref.read(authNP.notifier).signIn(
                          (authorizationUrl) {
                            final completer = Completer<Uri>();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AuthorizationScreen(
                                  authorizationUrl: authorizationUrl,
                                  onAuthorizationCodeRedirectAttempt:
                                      (redirectedUrl) {
                                    completer.complete(redirectedUrl);
                                  },
                                ),
                              ),
                            );
                            return completer.future;
                          },
                        );

                        if (!context.mounted) return;

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        ref
                            .read(pushedHomeChannelSP.notifier)
                            .update((state) => false);
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
