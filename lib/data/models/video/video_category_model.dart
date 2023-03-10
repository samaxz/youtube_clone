import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_category_model.freezed.dart';
part 'video_category_model.g.dart';

@freezed
class VideoCategory with _$VideoCategory {
  const factory VideoCategory({
    required String id,
    required Snippet snippet,
  }) = _VideoCategory;

  factory VideoCategory.fromJson(Map<String, dynamic> json) =>
      _$VideoCategoryFromJson(json);
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    required String title,
    required bool assignable,
    required String channelId,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);
}
