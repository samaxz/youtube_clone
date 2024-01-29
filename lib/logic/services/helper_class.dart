import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/notifiers/visibility_notifier.dart';
import 'package:youtube_clone/logic/oauth2/auth_notifier.dart';
import 'package:youtube_clone/logic/services/common_classes.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/screens/authorization_screen.dart';
import 'package:youtube_clone/ui/widgets/build_action.dart';
import 'package:youtube_clone/ui/widgets/comment_card.dart';
import 'package:youtube_clone/ui/widgets/custom_search_delegate.dart';
import 'package:youtube_clone/ui/widgets/popover.dart';
import 'package:youtube_clone/ui/widgets/searched_videos_list.dart';
import 'package:youtube_clone/ui/widgets/show_modal_bottom_sheet_builder.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

// part 'helper_class.g.dart';

enum ErrorTypeReload { homeScreen, searchScreen }

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

// TODO rename this for using instead of the
// class below
class Uploads {
  final List<Video> videos;
  final List<Video> shorts;

  const Uploads({
    required this.videos,
    required this.shorts,
  });
}

// TODO delete this and use the one above
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
  static const youtubeLogo = 'assets/youtube.png';
  static const youtubeLogoDarkMode = 'assets/youtube_dark_mode.png';

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
        onTap: () => ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
      ),
      BuildAction(
        Icons.person_off_outlined,
        'Don`t recommend channel',
        onTap: () => ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
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

  // ****** these methods are for the mini player
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

  // resets all the data about a video and loads new data
  // TODO remove unnecessary methods from here
  // TODO rename this
  // TODO remove this method, cause all it does is just sets
  // new selected video state provider
  static void handleVideoCardPressed({
    required WidgetRef ref,
    // new video that'll be selected
    required Video video,
  }) {
    final selectedVideo = ref.read(selectedVideoSP);
    if (selectedVideo?.id == video.id) return;

    // final currentIndex = ref.read(currentScreenIndexSP);
    ref.read(selectedVideoSP.notifier).update((state) => video);
    // TODO remove this
    // ref.read(isShowingSearchSP.notifier).update((state) => true);
    // ref.read(isShowingSearchSP(currentIndex).notifier).update((state) => false);
  }

  static void handleShowSearch({
    required BuildContext context,
    required WidgetRef ref,
    required int screenIndex,
  }) {
    // ref.read(pushedHomeChannelSP.notifier).update((state) => true);
    // TODO probably delete this, cause it's kinda useless
    ref.read(searchIndexProvider.notifier).setSearchIndex(screenIndex);
    ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => true);
    // ref.read(isShowingSearchSP.notifier).update((state) => true);
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(ref: ref, screenIndex: screenIndex),
    );
    log('did this get called?');
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
        // if the user has denied the permission twice
      } else if (result == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }

    return false;
  }

  static bool _isDownloading = false;

  static double progressIndicator = 0;

  static Future<void> downloadVideo({
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

    await showDialog(
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
                if (commentsInfo.disabled != null || commentsInfo.failure != null) {
                  return const Center(
                    child: Text('comments are private'),
                  );
                }

                final topLevelCommentSnippet =
                    commentsInfo.data[index].snippet.topLevelComment.topLevelCommentSnippet;
                final totalReplyCount = commentsInfo.data[index].snippet.totalReplyCount;

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

  // TODO remove this
  // static String formatDuration(String duration) {
  //   // final regExp = RegExp(r'(\d+)S|(\d+)M|(\d+)H');
  //   // final match = regExp.allMatches(duration).toList();
  //   // int seconds = 0;
  //   // int minutes = 0;
  //   // int hours = 0;
  //   //
  //   // for (int i = 0; i < match.length; i++) {
  //   //   final m = match[i];
  //   //   if (m.group(1) != null) {
  //   //     seconds += int.parse(m.group(1)!);
  //   //   } else if (m.group(2) != null) {
  //   //     minutes += int.parse(m.group(2)!);
  //   //     // TODO remove hours if they're empty
  //   //   } else if (m.group(3) != null) {
  //   //     hours += int.parse(m.group(3)!);
  //   //   }
  //   // }
  //   //
  //   // final newDuration = Duration(
  //   //   hours: hours,
  //   //   minutes: minutes,
  //   //   seconds: seconds,
  //   // );
  //   //
  //   // final durationString = newDuration.toString().split('.').first.padLeft(8, '0');
  //   //
  //   // return durationString;
  //
  //   // final format = DateFormat();
  //   // final newDuration = const Duration();
  // }

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
    // hopefully, this won't cause any throw
    late final String newDuration;

    // final daysRem = duration.inDays.remainder(24);
    final hoursRem = duration.inHours.remainder(60);
    final minsRem = duration.inMinutes.remainder(60);
    // sussy name
    final secsRem = duration.inSeconds.remainder(60);

    if (duration.inDays > 0) {
      // Format the duration as days, hours, minutes, and seconds
      // newDuration =
      //     '${duration.inDays}:${hoursRem == 0 ? '00' : hoursRem}:${minsRem == 0 ? '00' : minsRem}:${secsRem == 0 ? '00' : secsRem}';
      newDuration =
          '${duration.inDays}:${_getRemainder(hoursRem)}:${_getRemainder(minsRem)}:${_getRemainder(secsRem)}';
    } else if (duration.inHours > 0) {
      // Format the duration as hours, minutes, and seconds
      // newDuration =
      //     '${duration.inHours}:${minsRem == 0 ? '00' : minsRem}:${secsRem == 0 ? '00' : secsRem}';
      newDuration = '${duration.inHours}:${_getRemainder(minsRem)}:${_getRemainder(secsRem)}';
    } else if (duration.inMinutes > 0) {
      // Format the duration as minutes and seconds
      // newDuration = '${duration.inMinutes}:${secsRem == 0 ? '00' : secsRem}';
      newDuration = '${duration.inMinutes}:${_getRemainder(secsRem)}';
    } else {
      // If duration is less than a minute, display seconds
      // newDuration = '0:${duration.inSeconds}';
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
    // ref.read(pushedHomeChannelSP.notifier).update((state) => false);
  }

  static void handleAuthButtonPressed({
    required BuildContext context,
    required WidgetRef ref,
    // required AuthState authState,
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

// *************************************************
// *************************************************
// *************************************************
// *************************************************
// *************************************************
// *************************************************
// *************************************************
// *************************************************

// TODO use this in the future
// @riverpod
// WidgetMethods widgetMethodsProvider(WidgetRef ref, BuildContext context) {
//   return WidgetMethods(ref: ref, context: context);
// }
//
// class WidgetMethods {
//   final WidgetRef ref;
//   final BuildContext context;
//
//   WidgetMethods({
//     required this.ref,
//     required this.context,
//   });
//
//   List<Widget> getVideoCardActions({
//     required String videoId,
//     required int videoCardIndex,
//   }) {
//     final actions = [
//       BuildAction(
//         Icons.watch_later_outlined,
//         'Save to Watch Later',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//       BuildAction(
//         Icons.playlist_add,
//         'Save to playlist',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//       BuildAction(
//         Icons.file_download_outlined,
//         'Download video',
//         onTap: () => showDownloadPressed(
//           videoId: videoId,
//         ),
//       ),
//       BuildAction(
//         Icons.share,
//         'Share',
//         onTap: () => share(
//           link: 'https://youtu.be/$videoId',
//         ),
//       ),
//       BuildAction(
//         Icons.block,
//         'Not interested',
//         onTap: () => ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
//       ),
//       BuildAction(
//         Icons.person_off_outlined,
//         'Don`t recommend channel',
//         onTap: () => ref.read(visibilitySNP.notifier).changeValue(videoCardIndex),
//       ),
//       BuildAction(
//         Icons.flag_outlined,
//         'Report',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//     ];
//
//     return actions;
//   }
//
//   List<Widget> getAddButtonActions() {
//     final actions = [
//       BuildAction(
//         Icons.play_arrow_outlined,
//         'Crate a Short',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//       BuildAction(
//         Icons.file_upload_outlined,
//         'Upload a video',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//       BuildAction(
//         Icons.podcasts_outlined,
//         'Go live',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//       BuildAction(
//         Icons.edit_note_outlined,
//         'Create a post',
//         onTap: () => ref.read(unauthAttemptSP.notifier).update((state) => true),
//       ),
//     ];
//
//     return actions;
//   }
//
//   // this isn't really a widget class
//   Future<bool> hasInternet() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
//
//   // ****** these methods are for the mini player
//   double valueFromPercentageInRange({
//     required double min,
//     required double max,
//     required double percentage,
//   }) {
//     return percentage * (max - min) + min;
//   }
//
//   double percentageFromValueInRange({
//     required double min,
//     required double max,
//     required double value,
//   }) {
//     return (value - min) / (max - min);
//   }
//   // ***************************************
//
//   // resets all the data about a video and loads new data
//   // TODO remove unnecessary methods from here
//   // TODO rename this
//   // TODO remove this method, cause all it does is just sets
//   // new selected video state provider
//   void handleVideoCardPressed({
//     // new video that'll be selected
//     required Video video,
//   }) {
//     final selectedVideo = ref.read(selectedVideoSP);
//     if (selectedVideo?.id == video.id) return;
//
//     // final currentIndex = ref.read(currentScreenIndexSP);
//     ref.read(selectedVideoSP.notifier).update((state) => video);
//     // TODO remove this
//     // ref.read(isShowingSearchSP.notifier).update((state) => true);
//     // ref.read(isShowingSearchSP(currentIndex).notifier).update((state) => false);
//   }
//
//   void handleShowSearch({required int screenIndex}) {
//     // ref.read(pushedHomeChannelSP.notifier).update((state) => true);
//     // TODO probably delete this, cause it's kinda useless
//     ref.read(searchIndexProvider.notifier).setSearchIndex(screenIndex);
//     showSearch(
//       context: context,
//       delegate: CustomSearchDelegate(ref, screenIndex),
//     );
//   }
//
//   void handleMoreVertPressed({
//     required ScreenIdAndActions screenIdAndActions,
//     int? videoCardIndex,
//   }) {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       context: context,
//       builder: (context) {
//         switch (screenIdAndActions.actions) {
//           case ScreenActions.videoCard:
//             return ShowModalBottomSheetBuilder(
//               actions: getVideoCardActions(
//                 videoId: screenIdAndActions.id!,
//                 videoCardIndex: videoCardIndex!,
//               ),
//             );
//
//           case ScreenActions.channelCard:
//             return Container();
//
//         // TODO finish these
//           case ScreenActions.shortsBody:
//             return Container();
//
//           case ScreenActions.playlist:
//             return Container();
//
//           case ScreenActions.playlistChannel:
//             return Container();
//
//           case ScreenActions.channel:
//             return Container();
//         }
//       },
//     );
//   }
//
//   void handleAddButtonPressed() {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       context: context,
//       builder: (context) => ShowModalBottomSheetBuilder(
//         actions: getAddButtonActions(),
//         enableHomeIndicator: false,
//         isAddContentButton: true,
//       ),
//     );
//   }
//
//   // TODO make use of this
//   void handleSharePressed() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       builder: (context) => ShowModalBottomSheetBuilder(
//         actions: [
//           BuildAction(
//             Icons.reply_outlined,
//             'Share the video',
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> share({
//     required String link,
//   }) async {
//     await Share.share(link);
//   }
//
//   Future<bool> requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       final result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//         // if the user has denied the permission twice
//       } else if (result == PermissionStatus.permanentlyDenied) {
//         openAppSettings();
//       }
//     }
//
//     return false;
//   }
//
//   bool _isDownloading = false;
//
//   double progressIndicator = 0;
//
//   Future<void> downloadVideo({
//     // can't i simply use the video id?
//     required explode.VideoId videoId,
//     required explode.VideoQuality quality,
//   }) async {
//     try {
//       // instantiate the class
//       final yt = explode.YoutubeExplode();
//
//       // get video meta data
//       final videoInfo = await yt.videos.get(videoId);
//
//       // gets available streams for the video
//       final manifest = await yt.videos.streamsClient.getManifest(videoId);
//
//       // info about video's stream info: codec, resolution...
//       final manifestVideo = manifest.video.firstWhere(
//             (element) => element.videoQuality == quality,
//       );
//
//       // get the stream of data for the specified video's stream info
//       final videoStream = yt.videos.streamsClient.get(manifestVideo);
//
//       // get the video and audio by quality, based on its index in the column
//       final video = manifest.muxed.firstWhere(
//             (element) => element.videoQuality == quality,
//       );
//
//       // create a file with a name and other info, as well as prohibit
//       // unwanted characters
//       final fileName =
//       '${videoInfo.title}${DateTime.now().millisecondsSinceEpoch}.${video.container.name}'
//           .replaceAll(r'\', '')
//           .replaceAll('/', '')
//           .replaceAll('*', '')
//           .replaceAll(':', '')
//           .replaceAll('?', '')
//           .replaceAll('"', '')
//           .replaceAll('<', '')
//           .replaceAll('>', '')
//           .replaceAll('|', '');
//
//       final storageGranted = await requestPermission(Permission.videos);
//
//       if (storageGranted) {
//         final dir = Directory('/storage/emulated/0/Download/Youtube clone');
//
//         if (!dir.existsSync()) {
//           dir.createSync(recursive: true);
//         }
//
//         final file = File('${dir.path}/$fileName');
//         if (file.existsSync()) {}
//
//         if (_isDownloading) return;
//
//         _isDownloading = true;
//
//         final fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
//         final len = video.size.totalBytes;
//         double count = 0;
//
//         await for (final data in videoStream) {
//           count += data.length;
//           final progress = ((count / len) * 100).ceil().toDouble();
//
//           progressIndicator = progress;
//
//           fileStream.add(data);
//         }
//
//         _isDownloading = false;
//
//         await fileStream.flush();
//         await fileStream.close();
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   String _qualityNameConvert(String txt) {
//     return '${txt.replaceAll(RegExp(r'[^0-9]'), '')}p';
//   }
//
//   Future<void> showDownloadPressed({
//     required String videoId,
//   }) async {
//     final videoUrl = explode.VideoId(videoId);
//     log('videoUrl: $videoUrl');
//
//     final qualities = ref.watch(
//       videoQualityFP(videoUrl),
//     );
//
//     log('qualities: $qualities');
//
//     if (!context.mounted) return;
//
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         title: const Center(
//           child: Text('Select quality'),
//         ),
//         content: qualities.when(
//           data: (data) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: data
//                 .map(
//                   (quality) => Card(
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   onTap: () async {
//                     await downloadVideo(
//                       videoId: videoUrl,
//                       quality: quality,
//                     );
//
//                     Future.delayed(
//                       const Duration(seconds: 1),
//                     ).then(
//                           (value) => Navigator.of(context).pop(),
//                     );
//                   },
//                   leading: Icon(MdiIcons.youtube),
//                   trailing: const Icon(
//                     Icons.download,
//                     size: 20,
//                   ),
//                   title: Text(
//                     _qualityNameConvert(
//                       quality.toString(),
//                     ),
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//                 .toList(),
//           ),
//           error: (error, stackTrace) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: TextButton(
//                   // TODO make this work
//                   onPressed: () => ref.read(
//                     videoQualityFP(videoUrl),
//                   ),
//                   child: const Text('Retry'),
//                 ),
//               ),
//             ],
//           ),
//           loading: () => const Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void handleSavePressed() {
//     showModalBottomSheet(
//       context: context,
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       builder: (context) => ShowModalBottomSheetBuilder(
//         actions: [
//           BuildAction(
//             Icons.reply_outlined,
//             'Share the video',
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   // shows the bottom sheet comments section
//   void handleCommentsPressed({
//     required BaseInfo<Comment> commentsInfo,
//   }) {
//     showBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       builder: (context) => DraggableScrollableSheet(
//         // TODO make this adaptive
//         initialChildSize: 0.68,
//         maxChildSize: 1,
//         // not sure this is the right value
//         minChildSize: 0.68,
//         builder: (context, scrollController) => Popover(
//           isCommentsSection: true,
//           child: Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: commentsInfo.data.length,
//               itemBuilder: (context, index) {
//                 if (commentsInfo.disabled != null || commentsInfo.failure != null) {
//                   return const Center(
//                     child: Text('comments are private'),
//                   );
//                 }
//
//                 final topLevelCommentSnippet =
//                     commentsInfo.data[index].snippet.topLevelComment.topLevelCommentSnippet;
//                 final totalReplyCount = commentsInfo.data[index].snippet.totalReplyCount;
//
//                 return CommentCard(
//                   author: topLevelCommentSnippet.authorDisplayName,
//                   text: topLevelCommentSnippet.textDisplay,
//                   likeCount: topLevelCommentSnippet.likeCount,
//                   replyCount: totalReplyCount,
//                   publishedTime: topLevelCommentSnippet.updatedAt,
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String numberFormatter(String initialNumber) {
//     final numberAsString = initialNumber;
//
//     late final String newNumber;
//
//     switch (numberAsString.length) {
//     // *********** thousands *********** //
//       case 4:
//         numberAsString[1] != 0.toString()
//             ? newNumber = '${numberAsString[0]}.${numberAsString[1]}k'
//             : newNumber = '${numberAsString[0]}k';
//         break;
//
//       case 5:
//         numberAsString[2] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}k'
//             : newNumber = '${numberAsString.substring(0, 2)}k';
//         break;
//
//       case 6:
//         numberAsString[3] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}k'
//             : newNumber = '${numberAsString.substring(0, 3)}k';
//         break;
//
//     // ************* millions ************* //
//       case 7:
//         numberAsString[1] != 0.toString()
//             ? newNumber = '${numberAsString[0]}.${numberAsString[1]}m'
//             : newNumber = '${numberAsString[0]}m';
//         break;
//
//       case 8:
//         numberAsString[2] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}m'
//             : newNumber = '${numberAsString.substring(0, 2)}m';
//         break;
//
//       case 9:
//         numberAsString[3] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}m'
//             : newNumber = '${numberAsString.substring(0, 3)}m';
//         break;
//
//     // ************* billions ************* //
//       case 10:
//         numberAsString[1] != 0.toString()
//             ? newNumber = '${numberAsString[0]}.${numberAsString[1]}b'
//             : newNumber = '${numberAsString[0]}b';
//         break;
//
//       case 11:
//         numberAsString[2] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 2)}.${numberAsString[2]}b'
//             : newNumber = '${numberAsString.substring(0, 2)}b';
//         break;
//
//       case 12:
//         numberAsString[3] != 0.toString()
//             ? newNumber = '${numberAsString.substring(0, 3)}.${numberAsString[3]}b'
//             : newNumber = '${numberAsString.substring(0, 3)}b';
//         break;
//
//       default:
//         newNumber = numberAsString;
//     }
//
//     return newNumber;
//   }
//
//   String formatDuration(String duration) {
//     final regExp = RegExp(r'(\d+)S|(\d+)M|(\d+)H');
//     final match = regExp.allMatches(duration).toList();
//     int seconds = 0;
//     int minutes = 0;
//     int hours = 0;
//
//     for (int i = 0; i < match.length; i++) {
//       final m = match[i];
//       if (m.group(1) != null) {
//         seconds += int.parse(m.group(1)!);
//       } else if (m.group(2) != null) {
//         minutes += int.parse(m.group(2)!);
//         // TODO remove hours if they're empty
//       } else if (m.group(3) != null) {
//         hours += int.parse(m.group(3)!);
//       }
//     }
//
//     final newDuration = Duration(
//       hours: hours,
//       minutes: minutes,
//       seconds: seconds,
//     );
//
//     final durationString = newDuration.toString().split('.').first.padLeft(8, '0');
//
//     return durationString;
//   }
//
//   Future<void> authenticate() async {
//     await ref.read(authNotifierProvider.notifier).signIn(
//           (authorizationUrl) {
//         final completer = Completer<Uri>();
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => AuthorizationScreen(
//               authorizationUrl: authorizationUrl,
//               onAuthorizationCodeRedirectAttempt: (redirectedUrl) {
//                 completer.complete(redirectedUrl);
//               },
//             ),
//           ),
//         );
//         return completer.future;
//       },
//     );
//
//     if (!context.mounted) return;
//
//     Navigator.of(context).popUntil((route) => route.isFirst);
//
//     // TODO invalidate videos and other notifiers here
//     // TODO update all the state notifier providers here to stop any
//     // video and short, as well as hide the mp (and maybe do some other
//     // stuff)
//     // ref.read(pushedHomeChannelSP.notifier).update((state) => false);
//   }
//
//   void handleAuthButtonPressed() {
//     final authState = ref.read(authNotifierProvider);
//
//     showModalBottomSheet(
//       context: context,
//       // this enables the mbs to be full screen
//       isScrollControlled: true,
//       useRootNavigator: true,
//       useSafeArea: true,
//       builder: (context) => SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.clear),
//                 ),
//                 const Spacer(),
//               ],
//             ),
//             authState.maybeWhen(
//               orElse: () => const Center(
//                 child: CircularProgressIndicator(),
//               ),
//               authenticated: () => Expanded(
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       ref
//                           .read(authNotifierProvider.notifier)
//                           .signOut()
//                           .whenComplete(() => Navigator.of(context).pop());
//                     },
//                     child: const Text('sign out of your account'),
//                   ),
//                 ),
//               ),
//               unauthenticated: () => Expanded(
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       authenticate();
//                     },
//                     child: const Text('sign in to your account'),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
