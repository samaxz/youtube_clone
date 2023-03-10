// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      channelName: json['channelName'] as String?,
      channelHandle: json['channelHandle'] as String?,
      channelId: json['channelId'] as String?,
      channelApproval: json['channelApproval'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'channelName': instance.channelName,
      'channelHandle': instance.channelHandle,
      'channelId': instance.channelId,
      'channelApproval': instance.channelApproval,
    };
