import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone/logic/notifiers/search_items_notifier.dart';

part 'channel_model.g.dart';

@JsonSerializable()
class Channel with Item {
  @override
  final String kind;
  final String etag;
  @override
  final String id;

  @override
  String toString() {
    return 'Channel{kind: $kind, etag: $etag, id: $id, snippet: $snippet, contentDetails: $contentDetails, statistics: $statistics}';
  }

  final Snippet snippet;
  final ContentDetails? contentDetails;
  final Statistics? statistics;

  const Channel({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
    this.contentDetails,
    this.statistics,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        kind: json['kind'] == 'youtube#searchResult' ? json['id']['kind'] : json['kind'],
        etag: json['etag'] as String,
        id: json['kind'] == 'youtube#searchResult' ? json['id']['channelId'] : json['id'],
        snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
        contentDetails: json['contentDetails'] == null
            ? null
            : ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
        statistics: json['statistics'] == null
            ? null
            : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      );
}

@JsonSerializable()
class Snippet {
  final String? myChannelId;
  final String? theChannelId;
  final String title;
  final String description;
  final String? customUrl;
  final DateTime publishedAt;
  final Thumbnials thumbnail;
  final String? country;

  const Snippet({
    this.myChannelId,
    this.theChannelId,
    required this.title,
    required this.description,
    this.customUrl,
    required this.publishedAt,
    required this.thumbnail,
    this.country,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        myChannelId: json['channelId'] as String?,
        theChannelId: json['resourceId']?['channelId'] as String?,
        title: json['title'] as String,
        description: json['description'] as String,
        customUrl: json['customUrl'] as String?,
        publishedAt: DateTime.parse(json['publishedAt'] as String),
        thumbnail: Thumbnials.fromJson(json['thumbnails'] as Map<String, dynamic>),
        country: json['country'] as String?,
      );

  @override
  String toString() {
    return 'Snippet{myChannelId: $myChannelId, theChannelId: $theChannelId, title: $title, description: $description, customUrl: $customUrl, publishedAt: $publishedAt, thumbnail: $thumbnail, country: $country}';
  }
}

@JsonSerializable()
class Thumbnials {
  final String? defaultSize;
  final String? medium;
  final String? high;

  const Thumbnials({
    this.defaultSize,
    this.medium,
    this.high,
  });

  factory Thumbnials.fromJson(Map<String, dynamic> json) => Thumbnials(
        defaultSize: json['default']?['url'] as String?,
        medium: json['medium']?['url'] as String?,
        high: json['high']?['url'] as String?,
      );

  @override
  String toString() {
    return 'Thumbnials{defaultSize: $defaultSize, medium: $medium, high: $high}';
  }
}

@JsonSerializable()
class ContentDetails {
  final String? uploads;
  final String? likes;
  final String? favorites;

  const ContentDetails({
    this.uploads,
    this.likes,
    this.favorites,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        likes: json['relatedPlaylists']?['likes'] as String?,
        favorites: json['relatedPlaylists']?['favorites'] as String?,
        uploads: json['relatedPlaylists']?['uploads'] as String?,
      );

  // this is just for now
  List<String?> get playlists => [uploads, likes, favorites];

  @override
  String toString() {
    return 'ContentDetails{uploads: $uploads, likes: $likes, favorites: $favorites}';
  }
}

@JsonSerializable()
class Statistics {
  final String viewCount;

  @override
  String toString() {
    return 'Statistics{viewCount: $viewCount, subscriberCount: $subscriberCount, hiddenSubscriberCount: $hiddenSubscriberCount, videoCount: $videoCount}';
  }

  final String subscriberCount;
  final bool hiddenSubscriberCount;
  final String videoCount;

  const Statistics({
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => _$StatisticsFromJson(json);
}
