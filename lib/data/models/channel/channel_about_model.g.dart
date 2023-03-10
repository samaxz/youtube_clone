// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

About _$AboutFromJson(Map<String, dynamic> json) => About(
      stats: json['stats'] == null
          ? null
          : Stats.fromJson(json['stats'] as Map<String, dynamic>),
      description: json['description'] as String?,
      title: json['title'] as String?,
      location: json['location'] as String?,
      links: (json['links'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      handle: json['handle'] as String?,
    );

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'stats': instance.stats,
      'description': instance.description,
      'title': instance.title,
      'location': instance.location,
      'links': instance.links,
      'handle': instance.handle,
    };

Stats _$StatsFromJson(Map<String, dynamic> json) => Stats(
      joinedDate: json['joinedDate'] as int?,
      viewCount: json['viewCount'] as int?,
      subscriberCount: json['subscriberCount'] as int?,
    );

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'joinedDate': instance.joinedDate,
      'viewCount': instance.viewCount,
      'subscriberCount': instance.subscriberCount,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String?,
      thumbnail: json['thumbnail'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
    };
