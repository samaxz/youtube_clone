import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_clone/data/info/item.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
class Video with Item, _$Video {
  const factory Video({
    required String kind,
    required String id,
    required Snippet snippet,
    required ContentDetails? contentDetails,
    required Statistics? statistics,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        kind: json['kind'] == 'youtube#searchResult' ? json['id']['kind'] : json['kind'],
        id: json['kind'] == 'youtube#searchResult'
            ? json['id']['videoId']
            : json['kind'] == 'youtube#playlistItem'
                ? json['snippet']['resourceId']['videoId']
                : json['id'] as String,
        snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
        contentDetails: json['contentDetails'] == null
            ? null
            : ContentDetails.fromJson(
                json['contentDetails'] as Map<String, dynamic>,
              ),
        statistics: json['statistics'] == null
            ? null
            : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      );
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    required DateTime publishedAt,
    required String channelId,
    required String title,
    required String description,
    required Thumbnail thumbnails,
    required String channelTitle,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) => _$SnippetFromJson(json);
}

@freezed
class Thumbnail with _$Thumbnail {
  const factory Thumbnail({
    required String? defaultRes,
    required String? medium,
    required String? high,
    required String? standard,
    required String? maxres,
  }) = _Thumbnail;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        defaultRes: json['defaultRes']?['url'] as String?,
        medium: json['medium']?['url'] as String?,
        high: json['high']?['url'] as String?,
        standard: json['standard']?['url'] as String?,
        maxres: json['maxres']?['url'] as String?,
      );
}

@freezed
class ContentDetails with _$ContentDetails {
  const factory ContentDetails({
    required String? duration,
    required String? definition,
    required String? caption,
  }) = _ContentDetails;

  factory ContentDetails.fromJson(Map<String, dynamic> json) => _$ContentDetailsFromJson(json);
}

@freezed
class Statistics with _$Statistics {
  const factory Statistics(
    String? viewCount,
    String? likeCount,
    String? favoriteCount,
    String? commentCount,
  ) = _Statistics;

  factory Statistics.fromJson(Map<String, dynamic> json) => _$StatisticsFromJson(json);
}
