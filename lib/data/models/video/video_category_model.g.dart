// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoCategoryImpl _$$VideoCategoryImplFromJson(Map<String, dynamic> json) =>
    _$VideoCategoryImpl(
      id: json['id'] as String,
      snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VideoCategoryImplToJson(_$VideoCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet,
    };

_$SnippetImpl _$$SnippetImplFromJson(Map<String, dynamic> json) =>
    _$SnippetImpl(
      title: json['title'] as String,
      assignable: json['assignable'] as bool,
      channelId: json['channelId'] as String,
    );

Map<String, dynamic> _$$SnippetImplToJson(_$SnippetImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'assignable': instance.assignable,
      'channelId': instance.channelId,
    };
