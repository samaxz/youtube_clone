import 'package:youtube_clone/data/info/base_info.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart' as channel_model;
import 'package:youtube_clone/data/models/comment_model.dart';
import 'package:youtube_clone/data/models/video/video_model.dart';

// for video and shorts details notifiers
class VideoDetails {
  final channel_model.Channel channelInfo;
  final BaseInfo<Video>? videoInfo;
  final BaseInfo<Comment> comments;

  const VideoDetails({
    required this.channelInfo,
    this.videoInfo,
    required this.comments,
  });

  @override
  String toString() =>
      'VideoDetails(channel: $channelInfo, videoInfo: $videoInfo, comments: $comments)';
}
