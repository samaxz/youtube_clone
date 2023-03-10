import 'package:json_annotation/json_annotation.dart';

part 'community_post_model.g.dart';

@JsonSerializable()
class CommunityPost {
  final String id;
  final String channelId;
  final String? date;
  final List<Map<String, dynamic>?> contentText;
  final int? likes;
  final int? commentsCount;
  final String? videoId;
  @JsonKey(includeFromJson: false)
  // TODO implement this in the future
  final List<Image>? images;
  @JsonKey(includeFromJson: false)
  final Poll? poll;
  final bool? edited;
  final int? sharedPostId;

  const CommunityPost({
    required this.id,
    required this.channelId,
    this.date,
    required this.contentText,
    this.likes,
    this.commentsCount,
    this.videoId,
    this.images,
    this.poll,
    this.edited,
    this.sharedPostId,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) =>
      _$CommunityPostFromJson(json);
}

class Image {}

class Poll {}
