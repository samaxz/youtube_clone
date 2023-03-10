// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      etag: json['etag'] as String,
      subscriptionId: json['id'] as String,
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: ContentDetails.fromJson(
          json['contentDetails'] as Map<String, dynamic>),
      subscriberSnippet: SubscriberSnippet.fromJson(
          json['subscriberSnippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'id': instance.subscriptionId,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'subscriberSnippet': instance.subscriberSnippet,
    };

SubscriberSnippet _$SubscriberSnippetFromJson(Map<String, dynamic> json) =>
    SubscriberSnippet(
      channelId: json['channelId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      customUrl: json['customUrl'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      thumbnail:
          Thumbnials.fromJson(json['thumbnails'] as Map<String, dynamic>),
      country: json['country'] as String?,
    );

Map<String, dynamic> _$SubscriberSnippetToJson(SubscriberSnippet instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'customUrl': instance.customUrl,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'thumbnails': instance.thumbnail,
      'country': instance.country,
    };
