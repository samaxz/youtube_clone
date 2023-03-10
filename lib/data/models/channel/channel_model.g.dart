// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      kind: json['kind'] as String,
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: json['contentDetails'] == null
          ? null
          : ContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>),
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'statistics': instance.statistics,
    };

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      myChannelId: json['myChannelId'] as String?,
      theChannelId: json['theChannelId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      customUrl: json['customUrl'] as String?,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      thumbnail: Thumbnials.fromJson(json['thumbnail'] as Map<String, dynamic>),
      country: json['country'] as String?,
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'myChannelId': instance.myChannelId,
      'theChannelId': instance.theChannelId,
      'title': instance.title,
      'description': instance.description,
      'customUrl': instance.customUrl,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'thumbnail': instance.thumbnail,
      'country': instance.country,
    };

Thumbnials _$ThumbnialsFromJson(Map<String, dynamic> json) => Thumbnials(
      defaultSize: json['defaultSize'] as String?,
      medium: json['medium'] as String?,
      high: json['high'] as String?,
    );

Map<String, dynamic> _$ThumbnialsToJson(Thumbnials instance) =>
    <String, dynamic>{
      'defaultSize': instance.defaultSize,
      'medium': instance.medium,
      'high': instance.high,
    };

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      uploads: json['uploads'] as String?,
      likes: json['likes'] as String?,
      favorites: json['favorites'] as String?,
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'uploads': instance.uploads,
      'likes': instance.likes,
      'favorites': instance.favorites,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      viewCount: json['viewCount'] as String,
      subscriberCount: json['subscriberCount'] as String,
      hiddenSubscriberCount: json['hiddenSubscriberCount'] as bool,
      videoCount: json['videoCount'] as String,
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'subscriberCount': instance.subscriberCount,
      'hiddenSubscriberCount': instance.hiddenSubscriberCount,
      'videoCount': instance.videoCount,
    };
