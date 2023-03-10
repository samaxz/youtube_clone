// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet,
      'replies': instance.replies,
    };

_$SnippetImpl _$$SnippetImplFromJson(Map<String, dynamic> json) =>
    _$SnippetImpl(
      videoId: json['videoId'] as String,
      topLevelComment: TopLevelComment.fromJson(
          json['topLevelComment'] as Map<String, dynamic>),
      totalReplyCount: json['totalReplyCount'] as int,
    );

Map<String, dynamic> _$$SnippetImplToJson(_$SnippetImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'topLevelComment': instance.topLevelComment,
      'totalReplyCount': instance.totalReplyCount,
    };

_$TopLevelCommentImpl _$$TopLevelCommentImplFromJson(
        Map<String, dynamic> json) =>
    _$TopLevelCommentImpl(
      id: json['id'] as String,
      topLevelCommentSnippet: TopLevelCommentSnippet.fromJson(
          json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TopLevelCommentImplToJson(
        _$TopLevelCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.topLevelCommentSnippet,
    };

_$TopLevelCommentSnippetImpl _$$TopLevelCommentSnippetImplFromJson(
        Map<String, dynamic> json) =>
    _$TopLevelCommentSnippetImpl(
      videoId: json['videoId'] as String,
      textDisplay: json['textDisplay'] as String,
      authorDisplayName: json['authorDisplayName'] as String,
      authorProfileImageUrl: json['authorProfileImageUrl'] as String,
      authorChannelId: json['authorChannelId'] as String,
      viewerRating: json['viewerRating'] as String,
      likeCount: json['likeCount'] as int,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$TopLevelCommentSnippetImplToJson(
        _$TopLevelCommentSnippetImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'textDisplay': instance.textDisplay,
      'authorDisplayName': instance.authorDisplayName,
      'authorProfileImageUrl': instance.authorProfileImageUrl,
      'authorChannelId': instance.authorChannelId,
      'viewerRating': instance.viewerRating,
      'likeCount': instance.likeCount,
      'updatedAt': instance.updatedAt,
    };

_$ReplyImpl _$$ReplyImplFromJson(Map<String, dynamic> json) => _$ReplyImpl(
      id: json['id'] as String,
      replySnippet:
          ReplySnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReplyImplToJson(_$ReplyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.replySnippet,
    };

_$ReplySnippetImpl _$$ReplySnippetImplFromJson(Map<String, dynamic> json) =>
    _$ReplySnippetImpl(
      videoId: json['videoId'] as String,
      textDisplay: json['textDisplay'] as String,
      parentId: json['parentId'] as String,
      authorDisplayName: json['authorDisplayName'] as String,
      authorProfileImageUrl: json['authorProfileImageUrl'] as String,
      authorChannelId: json['authorChannelId'] as String,
      viewerRating: json['viewerRating'] as String,
      likeCount: json['likeCount'] as int,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$ReplySnippetImplToJson(_$ReplySnippetImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'textDisplay': instance.textDisplay,
      'parentId': instance.parentId,
      'authorDisplayName': instance.authorDisplayName,
      'authorProfileImageUrl': instance.authorProfileImageUrl,
      'authorChannelId': instance.authorChannelId,
      'viewerRating': instance.viewerRating,
      'likeCount': instance.likeCount,
      'updatedAt': instance.updatedAt,
    };
