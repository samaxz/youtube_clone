import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';
import 'package:youtube_clone/logic/services/helper_class.dart';

part 'common_classes.freezed.dart';

// displaying different options for different widgets when clicking
// on the 3 dot more vert icon
@freezed
class ShowOptions with _$ShowOptions {
  const factory ShowOptions.neither() = Neither;
  const factory ShowOptions.video(VideoAction videoAction) = VideoOptions;
  const factory ShowOptions.channel() = ChannelOptions;
}

class VideoAction {
  // i don't really need a video player
  final PodPlayerController playerController;
  final String videoId;
  // video card's index in the list
  final int videoIndex;

  const VideoAction({
    required this.playerController,
    required this.videoId,
    required this.videoIndex,
  });
}

// TODO move these classes elsewhere
enum ErrorTypeReload { homeScreen, searchScreen }

// TODO rename this for using instead of the
// class below
class Uploads {
  final List<Video> videos;
  final List<Video> shorts;

  const Uploads({
    required this.videos,
    required this.shorts,
  });

  @override
  String toString() {
    return 'Uploads{videos: $videos, shorts: $shorts}';
  }
}

// TODO delete this and use the one above
class VideoTypes {
  final List<Video> videos;
  final List<Video> shorts;

  const VideoTypes({
    required this.videos,
    required this.shorts,
  });

  @override
  String toString() {
    return 'VideoTypes{videos: $videos, shorts: $shorts}';
  }
}
