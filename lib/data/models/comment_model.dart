import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

// a block consisting of a top level comment
// and its replies
@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    required Snippet snippet,
    required List<Reply>? replies,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'] as String,
        snippet: Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
        replies: (json['replies']?['comments'] as List<dynamic>?)
            ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

@freezed
class Snippet with _$Snippet {
  const factory Snippet({
    required String videoId,
    required TopLevelComment topLevelComment,
    required int totalReplyCount,
  }) = _Snippet;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);
}

@freezed
class TopLevelComment with _$TopLevelComment {
  const factory TopLevelComment({
    required String id,
    @JsonKey(name: 'snippet')
    required TopLevelCommentSnippet topLevelCommentSnippet,
  }) = _TopLevelComment;

  factory TopLevelComment.fromJson(Map<String, dynamic> json) =>
      _$TopLevelCommentFromJson(json);
}

@freezed
class TopLevelCommentSnippet with _$TopLevelCommentSnippet {
  const factory TopLevelCommentSnippet({
    required String videoId,
    required String textDisplay,
    required String authorDisplayName,
    required String authorProfileImageUrl,
    required String authorChannelId,
    required String viewerRating,
    required int likeCount,
    required String updatedAt,
  }) = _TopLevelCommentSnippet;

  factory TopLevelCommentSnippet.fromJson(Map<String, dynamic> json) =>
      TopLevelCommentSnippet(
        videoId: json['videoId'] as String,
        textDisplay: json['textDisplay'] as String,
        authorDisplayName: json['authorDisplayName'] as String,
        authorProfileImageUrl: json['authorProfileImageUrl'] as String,
        authorChannelId: json['authorChannelId']['value'] as String,
        viewerRating: json['viewerRating'] as String,
        likeCount: json['likeCount'] as int,
        updatedAt: json['updatedAt'] as String,
      );
}

@freezed
class Reply with _$Reply {
  const factory Reply({
    required String id,
    @JsonKey(name: 'snippet') required ReplySnippet replySnippet,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}

@freezed
class ReplySnippet with _$ReplySnippet {
  const factory ReplySnippet({
    required String videoId,
    required String textDisplay,
    required String parentId,
    required String authorDisplayName,
    required String authorProfileImageUrl,
    required String authorChannelId,
    required String viewerRating,
    required int likeCount,
    required String updatedAt,
  }) = _ReplySnippet;

  factory ReplySnippet.fromJson(Map<String, dynamic> json) => ReplySnippet(
        videoId: json['videoId'] as String,
        textDisplay: json['textDisplay'] as String,
        parentId: json['parentId'] as String,
        authorDisplayName: json['authorDisplayName'] as String,
        authorProfileImageUrl: json['authorProfileImageUrl'] as String,
        authorChannelId: json['authorChannelId']['value'] as String,
        viewerRating: json['viewerRating'] as String,
        likeCount: json['likeCount'] as int,
        updatedAt: json['updatedAt'] as String,
      );
}
