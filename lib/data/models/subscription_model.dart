import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone/data/models/channel/channel_model.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class Subscription {
  final String etag;
  @JsonKey(name: 'id')
  final String subscriptionId;
  final Snippet snippet;
  final ContentDetails contentDetails;
  final SubscriberSnippet subscriberSnippet;

  const Subscription({
    required this.etag,
    required this.subscriptionId,
    required this.snippet,
    required this.contentDetails,
    required this.subscriberSnippet,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}

// user's snippet info
@JsonSerializable()
class SubscriberSnippet {
  final String channelId;
  final String title;
  final String description;
  final String? customUrl;
  final DateTime? publishedAt;
  @JsonKey(name: 'thumbnails')
  final Thumbnials thumbnail;
  final String? country;

  const SubscriberSnippet({
    required this.channelId,
    required this.title,
    required this.description,
    this.customUrl,
    this.publishedAt,
    required this.thumbnail,
    this.country,
  });

  factory SubscriberSnippet.fromJson(Map<String, dynamic> json) =>
      _$SubscriberSnippetFromJson(json);
}
