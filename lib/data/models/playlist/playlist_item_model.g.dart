// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistItemImpl _$$PlaylistItemImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistItemImpl(
      etag: json['etag'] as String,
      id: json['id'] as String,
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: ContentDetails.fromJson(
          json['contentDetails'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$PlaylistItemImplToJson(_$PlaylistItemImpl instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'status': instance.status,
    };

_$SnippetImpl _$$SnippetImplFromJson(Map<String, dynamic> json) =>
    _$SnippetImpl(
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      channelId: json['channelId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnail: Thumbnail.fromJson(json['thumbnails'] as Map<String, dynamic>),
      channelTitle: json['channelTitle'] as String?,
      playlistId: json['playlistId'] as String?,
      position: json['position'] as int?,
      videoId: json['videoId'] as String?,
      videoOwnerChannelTitle: json['videoOwnerChannelTitle'] as String?,
      videoOwnerChannelId: json['videoOwnerChannelId'] as String?,
    );

Map<String, dynamic> _$$SnippetImplToJson(_$SnippetImpl instance) =>
    <String, dynamic>{
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnail,
      'channelTitle': instance.channelTitle,
      'playlistId': instance.playlistId,
      'position': instance.position,
      'videoId': instance.videoId,
      'videoOwnerChannelTitle': instance.videoOwnerChannelTitle,
      'videoOwnerChannelId': instance.videoOwnerChannelId,
    };

_$ThumbnailImpl _$$ThumbnailImplFromJson(Map<String, dynamic> json) =>
    _$ThumbnailImpl(
      defaultRes: json['defaultRes'] as String?,
      medium: json['medium'] as String?,
      high: json['high'] as String?,
      standard: json['standard'] as String?,
      maxres: json['maxres'] as String?,
    );

Map<String, dynamic> _$$ThumbnailImplToJson(_$ThumbnailImpl instance) =>
    <String, dynamic>{
      'defaultRes': instance.defaultRes,
      'medium': instance.medium,
      'high': instance.high,
      'standard': instance.standard,
      'maxres': instance.maxres,
    };

_$ContentDetailsImpl _$$ContentDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ContentDetailsImpl(
      videoId: json['videoId'] as String?,
      videoPublishedAt: json['videoPublishedAt'] == null
          ? null
          : DateTime.parse(json['videoPublishedAt'] as String),
    );

Map<String, dynamic> _$$ContentDetailsImplToJson(
        _$ContentDetailsImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'videoPublishedAt': instance.videoPublishedAt?.toIso8601String(),
    };
