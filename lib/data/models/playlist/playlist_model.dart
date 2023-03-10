import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_demo/services/notifiers/searched_items_notifier.dart';

part 'playlist_model.freezed.dart';
part 'playlist_model.g.dart';

// info about a playlist - it doesn't include
// any additional info about the videos, other
// than their count
@freezed
class Playlist with Item, _$Playlist {
  const factory Playlist({
    required String kind,
    required String etag,
    required String id,
    required Snippet snippet,
    // this is status query
    required String? privacyStatus,
    // this is contentDetails query
    required int? itemCount,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        kind: json['kind'] == 'youtube#searchResult'
            ? json['id']['kind']
            : json['kind'],
        etag: json['etag'],
        id: json['kind'] == 'youtube#searchResult'
            ? json['id']['playlistId']
            : json['id'],
        snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
        privacyStatus: json['status']?['privacyStatus'],
        itemCount: json['contentDetails']?['itemCount'],
      );
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    required DateTime publishedAt,
    required String? channelId,
    required String title,
    required String description,
    @JsonKey(name: 'thumbnails') required Thumbnail thumbnail,
    required String? channelTitle,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);
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
        defaultRes: json['default']?['url'] as String?,
        medium: json['medium']?['url'] as String?,
        high: json['high']?['url'] as String?,
        standard: json['standard']?['url'] as String?,
        maxres: json['maxres']?['url'] as String?,
      );
}
