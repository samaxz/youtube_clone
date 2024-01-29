import 'package:json_annotation/json_annotation.dart';

part 'channel_subscription_new.g.dart';

@JsonSerializable()
class ChannelSubscription {
  final String channelId;
  final String title;
  @JsonKey(fromJson: thumbnailFromJson)
  final String? thumbnail;
  final int? videoCount;
  final int? subscriberCount;

  const ChannelSubscription({
    required this.channelId,
    required this.title,
    this.thumbnail,
    this.videoCount,
    this.subscriberCount,
  });

  static String? thumbnailFromJson(Map<String, dynamic>? json) => json?['thumbnails']?[0]?['url'];

  factory ChannelSubscription.fromJson(Map<String, dynamic> json) =>
      _$ChannelSubscriptionFromJson(json);

  @override
  String toString() {
    return 'ChannelSubscription{channelId: $channelId, title: $title, thumbnail: $thumbnail, videoCount: $videoCount, subscriberCount: $subscriberCount}';
  }
}
