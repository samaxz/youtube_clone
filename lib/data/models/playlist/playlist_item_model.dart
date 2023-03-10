import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_item_model.freezed.dart';
part 'playlist_item_model.g.dart';

// info about each video inside a playlist
@freezed
class PlaylistItem with _$PlaylistItem {
  const factory PlaylistItem({
    required String etag,
    required String id,
    required Snippet snippet,
    required ContentDetails contentDetails,
    required String status,
  }) = _PlaylistItem;

  factory PlaylistItem.fromJson(Map<String, dynamic> json) => PlaylistItem(
        etag: json['etag'] as String,
        id: json['id'] as String,
        snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
        contentDetails: ContentDetails.fromJson(
            json['contentDetails'] as Map<String, dynamic>),
        status: json['status']['privacyStatus'] as String,
      );
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    required DateTime? publishedAt,
    required String? channelId,
    required String? title,
    required String? description,
    @JsonKey(name: 'thumbnails') required Thumbnail thumbnail,
    required String? channelTitle,
    required String? playlistId,
    required int? position,
    // TODO make more research on this
    required String? videoId,
    required String? videoOwnerChannelTitle,
    required String? videoOwnerChannelId,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: json['publishedAt'] == null
            ? null
            : DateTime.parse(json['publishedAt'] as String),
        channelId: json['channelId'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        thumbnail:
            Thumbnail.fromJson(json['thumbnails'] as Map<String, dynamic>),
        channelTitle: json['channelTitle'] as String?,
        playlistId: json['playlistId'] as String?,
        position: json['position'] as int?,
        videoId: json['resourceId']?['videoId'] as String?,
        videoOwnerChannelTitle: json['videoOwnerChannelTitle'] as String?,
        videoOwnerChannelId: json['videoOwnerChannelId'] as String?,
      );
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

@freezed
class ContentDetails with _$ContentDetails {
  const factory ContentDetails({
    required String? videoId,
    required DateTime? videoPublishedAt,
  }) = _ContentDetails;

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);
}
