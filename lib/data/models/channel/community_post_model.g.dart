// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPost _$CommunityPostFromJson(Map<String, dynamic> json) =>
    CommunityPost(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      date: json['date'] as String?,
      contentText: (json['contentText'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>?)
          .toList(),
      likes: json['likes'] as int?,
      commentsCount: json['commentsCount'] as int?,
      videoId: json['videoId'] as String?,
      edited: json['edited'] as bool?,
      sharedPostId: json['sharedPostId'] as int?,
    );

Map<String, dynamic> _$CommunityPostToJson(CommunityPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'date': instance.date,
      'contentText': instance.contentText,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
      'videoId': instance.videoId,
      'edited': instance.edited,
      'sharedPostId': instance.sharedPostId,
    };
