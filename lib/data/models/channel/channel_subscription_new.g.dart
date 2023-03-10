// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_subscription_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSubscription _$ChannelSubscriptionFromJson(Map<String, dynamic> json) =>
    ChannelSubscription(
      channelId: json['channelId'] as String,
      title: json['title'] as String,
      thumbnail: ChannelSubscription.thumbnailFromJson(
          json['thumbnail'] as Map<String, dynamic>?),
      videoCount: json['videoCount'] as int?,
      subscriberCount: json['subscriberCount'] as int?,
    );

Map<String, dynamic> _$ChannelSubscriptionToJson(
        ChannelSubscription instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'videoCount': instance.videoCount,
      'subscriberCount': instance.subscriberCount,
    };
