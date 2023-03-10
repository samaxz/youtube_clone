// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id => throw _privateConstructorUsedError;
  Snippet get snippet => throw _privateConstructorUsedError;
  List<Reply>? get replies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call({String id, Snippet snippet, List<Reply>? replies});

  $SnippetCopyWith<$Res> get snippet;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? snippet = null,
    Object? replies = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      snippet: null == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as Snippet,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SnippetCopyWith<$Res> get snippet {
    return $SnippetCopyWith<$Res>(_value.snippet, (value) {
      return _then(_value.copyWith(snippet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Snippet snippet, List<Reply>? replies});

  @override
  $SnippetCopyWith<$Res> get snippet;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? snippet = null,
    Object? replies = freezed,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      snippet: null == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as Snippet,
      replies: freezed == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Reply>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  const _$CommentImpl(
      {required this.id,
      required this.snippet,
      required final List<Reply>? replies})
      : _replies = replies;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final String id;
  @override
  final Snippet snippet;
  final List<Reply>? _replies;
  @override
  List<Reply>? get replies {
    final value = _replies;
    if (value == null) return null;
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Comment(id: $id, snippet: $snippet, replies: $replies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.snippet, snippet) || other.snippet == snippet) &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, snippet, const DeepCollectionEquality().hash(_replies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
      {required final String id,
      required final Snippet snippet,
      required final List<Reply>? replies}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get id;
  @override
  Snippet get snippet;
  @override
  List<Reply>? get replies;
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Snippet _$SnippetFromJson(Map<String, dynamic> json) {
  return _Snippet.fromJson(json);
}

/// @nodoc
mixin _$Snippet {
  String get videoId => throw _privateConstructorUsedError;
  TopLevelComment get topLevelComment => throw _privateConstructorUsedError;
  int get totalReplyCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnippetCopyWith<Snippet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnippetCopyWith<$Res> {
  factory $SnippetCopyWith(Snippet value, $Res Function(Snippet) then) =
      _$SnippetCopyWithImpl<$Res, Snippet>;
  @useResult
  $Res call(
      {String videoId, TopLevelComment topLevelComment, int totalReplyCount});

  $TopLevelCommentCopyWith<$Res> get topLevelComment;
}

/// @nodoc
class _$SnippetCopyWithImpl<$Res, $Val extends Snippet>
    implements $SnippetCopyWith<$Res> {
  _$SnippetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? topLevelComment = null,
    Object? totalReplyCount = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      topLevelComment: null == topLevelComment
          ? _value.topLevelComment
          : topLevelComment // ignore: cast_nullable_to_non_nullable
              as TopLevelComment,
      totalReplyCount: null == totalReplyCount
          ? _value.totalReplyCount
          : totalReplyCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TopLevelCommentCopyWith<$Res> get topLevelComment {
    return $TopLevelCommentCopyWith<$Res>(_value.topLevelComment, (value) {
      return _then(_value.copyWith(topLevelComment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnippetImplCopyWith<$Res> implements $SnippetCopyWith<$Res> {
  factory _$$SnippetImplCopyWith(
          _$SnippetImpl value, $Res Function(_$SnippetImpl) then) =
      __$$SnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId, TopLevelComment topLevelComment, int totalReplyCount});

  @override
  $TopLevelCommentCopyWith<$Res> get topLevelComment;
}

/// @nodoc
class __$$SnippetImplCopyWithImpl<$Res>
    extends _$SnippetCopyWithImpl<$Res, _$SnippetImpl>
    implements _$$SnippetImplCopyWith<$Res> {
  __$$SnippetImplCopyWithImpl(
      _$SnippetImpl _value, $Res Function(_$SnippetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? topLevelComment = null,
    Object? totalReplyCount = null,
  }) {
    return _then(_$SnippetImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      topLevelComment: null == topLevelComment
          ? _value.topLevelComment
          : topLevelComment // ignore: cast_nullable_to_non_nullable
              as TopLevelComment,
      totalReplyCount: null == totalReplyCount
          ? _value.totalReplyCount
          : totalReplyCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnippetImpl implements _Snippet {
  const _$SnippetImpl(
      {required this.videoId,
      required this.topLevelComment,
      required this.totalReplyCount});

  factory _$SnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnippetImplFromJson(json);

  @override
  final String videoId;
  @override
  final TopLevelComment topLevelComment;
  @override
  final int totalReplyCount;

  @override
  String toString() {
    return 'Snippet(videoId: $videoId, topLevelComment: $topLevelComment, totalReplyCount: $totalReplyCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnippetImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.topLevelComment, topLevelComment) ||
                other.topLevelComment == topLevelComment) &&
            (identical(other.totalReplyCount, totalReplyCount) ||
                other.totalReplyCount == totalReplyCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, videoId, topLevelComment, totalReplyCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SnippetImplCopyWith<_$SnippetImpl> get copyWith =>
      __$$SnippetImplCopyWithImpl<_$SnippetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnippetImplToJson(
      this,
    );
  }
}

abstract class _Snippet implements Snippet {
  const factory _Snippet(
      {required final String videoId,
      required final TopLevelComment topLevelComment,
      required final int totalReplyCount}) = _$SnippetImpl;

  factory _Snippet.fromJson(Map<String, dynamic> json) = _$SnippetImpl.fromJson;

  @override
  String get videoId;
  @override
  TopLevelComment get topLevelComment;
  @override
  int get totalReplyCount;
  @override
  @JsonKey(ignore: true)
  _$$SnippetImplCopyWith<_$SnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopLevelComment _$TopLevelCommentFromJson(Map<String, dynamic> json) {
  return _TopLevelComment.fromJson(json);
}

/// @nodoc
mixin _$TopLevelComment {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'snippet')
  TopLevelCommentSnippet get topLevelCommentSnippet =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopLevelCommentCopyWith<TopLevelComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopLevelCommentCopyWith<$Res> {
  factory $TopLevelCommentCopyWith(
          TopLevelComment value, $Res Function(TopLevelComment) then) =
      _$TopLevelCommentCopyWithImpl<$Res, TopLevelComment>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'snippet') TopLevelCommentSnippet topLevelCommentSnippet});

  $TopLevelCommentSnippetCopyWith<$Res> get topLevelCommentSnippet;
}

/// @nodoc
class _$TopLevelCommentCopyWithImpl<$Res, $Val extends TopLevelComment>
    implements $TopLevelCommentCopyWith<$Res> {
  _$TopLevelCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topLevelCommentSnippet = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topLevelCommentSnippet: null == topLevelCommentSnippet
          ? _value.topLevelCommentSnippet
          : topLevelCommentSnippet // ignore: cast_nullable_to_non_nullable
              as TopLevelCommentSnippet,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TopLevelCommentSnippetCopyWith<$Res> get topLevelCommentSnippet {
    return $TopLevelCommentSnippetCopyWith<$Res>(_value.topLevelCommentSnippet,
        (value) {
      return _then(_value.copyWith(topLevelCommentSnippet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TopLevelCommentImplCopyWith<$Res>
    implements $TopLevelCommentCopyWith<$Res> {
  factory _$$TopLevelCommentImplCopyWith(_$TopLevelCommentImpl value,
          $Res Function(_$TopLevelCommentImpl) then) =
      __$$TopLevelCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'snippet') TopLevelCommentSnippet topLevelCommentSnippet});

  @override
  $TopLevelCommentSnippetCopyWith<$Res> get topLevelCommentSnippet;
}

/// @nodoc
class __$$TopLevelCommentImplCopyWithImpl<$Res>
    extends _$TopLevelCommentCopyWithImpl<$Res, _$TopLevelCommentImpl>
    implements _$$TopLevelCommentImplCopyWith<$Res> {
  __$$TopLevelCommentImplCopyWithImpl(
      _$TopLevelCommentImpl _value, $Res Function(_$TopLevelCommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topLevelCommentSnippet = null,
  }) {
    return _then(_$TopLevelCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topLevelCommentSnippet: null == topLevelCommentSnippet
          ? _value.topLevelCommentSnippet
          : topLevelCommentSnippet // ignore: cast_nullable_to_non_nullable
              as TopLevelCommentSnippet,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopLevelCommentImpl implements _TopLevelComment {
  const _$TopLevelCommentImpl(
      {required this.id,
      @JsonKey(name: 'snippet') required this.topLevelCommentSnippet});

  factory _$TopLevelCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopLevelCommentImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'snippet')
  final TopLevelCommentSnippet topLevelCommentSnippet;

  @override
  String toString() {
    return 'TopLevelComment(id: $id, topLevelCommentSnippet: $topLevelCommentSnippet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopLevelCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topLevelCommentSnippet, topLevelCommentSnippet) ||
                other.topLevelCommentSnippet == topLevelCommentSnippet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, topLevelCommentSnippet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopLevelCommentImplCopyWith<_$TopLevelCommentImpl> get copyWith =>
      __$$TopLevelCommentImplCopyWithImpl<_$TopLevelCommentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopLevelCommentImplToJson(
      this,
    );
  }
}

abstract class _TopLevelComment implements TopLevelComment {
  const factory _TopLevelComment(
          {required final String id,
          @JsonKey(name: 'snippet')
          required final TopLevelCommentSnippet topLevelCommentSnippet}) =
      _$TopLevelCommentImpl;

  factory _TopLevelComment.fromJson(Map<String, dynamic> json) =
      _$TopLevelCommentImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'snippet')
  TopLevelCommentSnippet get topLevelCommentSnippet;
  @override
  @JsonKey(ignore: true)
  _$$TopLevelCommentImplCopyWith<_$TopLevelCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopLevelCommentSnippet _$TopLevelCommentSnippetFromJson(
    Map<String, dynamic> json) {
  return _TopLevelCommentSnippet.fromJson(json);
}

/// @nodoc
mixin _$TopLevelCommentSnippet {
  String get videoId => throw _privateConstructorUsedError;
  String get textDisplay => throw _privateConstructorUsedError;
  String get authorDisplayName => throw _privateConstructorUsedError;
  String get authorProfileImageUrl => throw _privateConstructorUsedError;
  String get authorChannelId => throw _privateConstructorUsedError;
  String get viewerRating => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopLevelCommentSnippetCopyWith<TopLevelCommentSnippet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopLevelCommentSnippetCopyWith<$Res> {
  factory $TopLevelCommentSnippetCopyWith(TopLevelCommentSnippet value,
          $Res Function(TopLevelCommentSnippet) then) =
      _$TopLevelCommentSnippetCopyWithImpl<$Res, TopLevelCommentSnippet>;
  @useResult
  $Res call(
      {String videoId,
      String textDisplay,
      String authorDisplayName,
      String authorProfileImageUrl,
      String authorChannelId,
      String viewerRating,
      int likeCount,
      String updatedAt});
}

/// @nodoc
class _$TopLevelCommentSnippetCopyWithImpl<$Res,
        $Val extends TopLevelCommentSnippet>
    implements $TopLevelCommentSnippetCopyWith<$Res> {
  _$TopLevelCommentSnippetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? textDisplay = null,
    Object? authorDisplayName = null,
    Object? authorProfileImageUrl = null,
    Object? authorChannelId = null,
    Object? viewerRating = null,
    Object? likeCount = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      textDisplay: null == textDisplay
          ? _value.textDisplay
          : textDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      authorDisplayName: null == authorDisplayName
          ? _value.authorDisplayName
          : authorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileImageUrl: null == authorProfileImageUrl
          ? _value.authorProfileImageUrl
          : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorChannelId: null == authorChannelId
          ? _value.authorChannelId
          : authorChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      viewerRating: null == viewerRating
          ? _value.viewerRating
          : viewerRating // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopLevelCommentSnippetImplCopyWith<$Res>
    implements $TopLevelCommentSnippetCopyWith<$Res> {
  factory _$$TopLevelCommentSnippetImplCopyWith(
          _$TopLevelCommentSnippetImpl value,
          $Res Function(_$TopLevelCommentSnippetImpl) then) =
      __$$TopLevelCommentSnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId,
      String textDisplay,
      String authorDisplayName,
      String authorProfileImageUrl,
      String authorChannelId,
      String viewerRating,
      int likeCount,
      String updatedAt});
}

/// @nodoc
class __$$TopLevelCommentSnippetImplCopyWithImpl<$Res>
    extends _$TopLevelCommentSnippetCopyWithImpl<$Res,
        _$TopLevelCommentSnippetImpl>
    implements _$$TopLevelCommentSnippetImplCopyWith<$Res> {
  __$$TopLevelCommentSnippetImplCopyWithImpl(
      _$TopLevelCommentSnippetImpl _value,
      $Res Function(_$TopLevelCommentSnippetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? textDisplay = null,
    Object? authorDisplayName = null,
    Object? authorProfileImageUrl = null,
    Object? authorChannelId = null,
    Object? viewerRating = null,
    Object? likeCount = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TopLevelCommentSnippetImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      textDisplay: null == textDisplay
          ? _value.textDisplay
          : textDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      authorDisplayName: null == authorDisplayName
          ? _value.authorDisplayName
          : authorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileImageUrl: null == authorProfileImageUrl
          ? _value.authorProfileImageUrl
          : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorChannelId: null == authorChannelId
          ? _value.authorChannelId
          : authorChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      viewerRating: null == viewerRating
          ? _value.viewerRating
          : viewerRating // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopLevelCommentSnippetImpl implements _TopLevelCommentSnippet {
  const _$TopLevelCommentSnippetImpl(
      {required this.videoId,
      required this.textDisplay,
      required this.authorDisplayName,
      required this.authorProfileImageUrl,
      required this.authorChannelId,
      required this.viewerRating,
      required this.likeCount,
      required this.updatedAt});

  factory _$TopLevelCommentSnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopLevelCommentSnippetImplFromJson(json);

  @override
  final String videoId;
  @override
  final String textDisplay;
  @override
  final String authorDisplayName;
  @override
  final String authorProfileImageUrl;
  @override
  final String authorChannelId;
  @override
  final String viewerRating;
  @override
  final int likeCount;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'TopLevelCommentSnippet(videoId: $videoId, textDisplay: $textDisplay, authorDisplayName: $authorDisplayName, authorProfileImageUrl: $authorProfileImageUrl, authorChannelId: $authorChannelId, viewerRating: $viewerRating, likeCount: $likeCount, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopLevelCommentSnippetImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.textDisplay, textDisplay) ||
                other.textDisplay == textDisplay) &&
            (identical(other.authorDisplayName, authorDisplayName) ||
                other.authorDisplayName == authorDisplayName) &&
            (identical(other.authorProfileImageUrl, authorProfileImageUrl) ||
                other.authorProfileImageUrl == authorProfileImageUrl) &&
            (identical(other.authorChannelId, authorChannelId) ||
                other.authorChannelId == authorChannelId) &&
            (identical(other.viewerRating, viewerRating) ||
                other.viewerRating == viewerRating) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      textDisplay,
      authorDisplayName,
      authorProfileImageUrl,
      authorChannelId,
      viewerRating,
      likeCount,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopLevelCommentSnippetImplCopyWith<_$TopLevelCommentSnippetImpl>
      get copyWith => __$$TopLevelCommentSnippetImplCopyWithImpl<
          _$TopLevelCommentSnippetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopLevelCommentSnippetImplToJson(
      this,
    );
  }
}

abstract class _TopLevelCommentSnippet implements TopLevelCommentSnippet {
  const factory _TopLevelCommentSnippet(
      {required final String videoId,
      required final String textDisplay,
      required final String authorDisplayName,
      required final String authorProfileImageUrl,
      required final String authorChannelId,
      required final String viewerRating,
      required final int likeCount,
      required final String updatedAt}) = _$TopLevelCommentSnippetImpl;

  factory _TopLevelCommentSnippet.fromJson(Map<String, dynamic> json) =
      _$TopLevelCommentSnippetImpl.fromJson;

  @override
  String get videoId;
  @override
  String get textDisplay;
  @override
  String get authorDisplayName;
  @override
  String get authorProfileImageUrl;
  @override
  String get authorChannelId;
  @override
  String get viewerRating;
  @override
  int get likeCount;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TopLevelCommentSnippetImplCopyWith<_$TopLevelCommentSnippetImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return _Reply.fromJson(json);
}

/// @nodoc
mixin _$Reply {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'snippet')
  ReplySnippet get replySnippet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyCopyWith<Reply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyCopyWith<$Res> {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) then) =
      _$ReplyCopyWithImpl<$Res, Reply>;
  @useResult
  $Res call({String id, @JsonKey(name: 'snippet') ReplySnippet replySnippet});

  $ReplySnippetCopyWith<$Res> get replySnippet;
}

/// @nodoc
class _$ReplyCopyWithImpl<$Res, $Val extends Reply>
    implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? replySnippet = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      replySnippet: null == replySnippet
          ? _value.replySnippet
          : replySnippet // ignore: cast_nullable_to_non_nullable
              as ReplySnippet,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReplySnippetCopyWith<$Res> get replySnippet {
    return $ReplySnippetCopyWith<$Res>(_value.replySnippet, (value) {
      return _then(_value.copyWith(replySnippet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReplyImplCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$$ReplyImplCopyWith(
          _$ReplyImpl value, $Res Function(_$ReplyImpl) then) =
      __$$ReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, @JsonKey(name: 'snippet') ReplySnippet replySnippet});

  @override
  $ReplySnippetCopyWith<$Res> get replySnippet;
}

/// @nodoc
class __$$ReplyImplCopyWithImpl<$Res>
    extends _$ReplyCopyWithImpl<$Res, _$ReplyImpl>
    implements _$$ReplyImplCopyWith<$Res> {
  __$$ReplyImplCopyWithImpl(
      _$ReplyImpl _value, $Res Function(_$ReplyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? replySnippet = null,
  }) {
    return _then(_$ReplyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      replySnippet: null == replySnippet
          ? _value.replySnippet
          : replySnippet // ignore: cast_nullable_to_non_nullable
              as ReplySnippet,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyImpl implements _Reply {
  const _$ReplyImpl(
      {required this.id, @JsonKey(name: 'snippet') required this.replySnippet});

  factory _$ReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'snippet')
  final ReplySnippet replySnippet;

  @override
  String toString() {
    return 'Reply(id: $id, replySnippet: $replySnippet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.replySnippet, replySnippet) ||
                other.replySnippet == replySnippet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, replySnippet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyImplCopyWith<_$ReplyImpl> get copyWith =>
      __$$ReplyImplCopyWithImpl<_$ReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyImplToJson(
      this,
    );
  }
}

abstract class _Reply implements Reply {
  const factory _Reply(
          {required final String id,
          @JsonKey(name: 'snippet') required final ReplySnippet replySnippet}) =
      _$ReplyImpl;

  factory _Reply.fromJson(Map<String, dynamic> json) = _$ReplyImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'snippet')
  ReplySnippet get replySnippet;
  @override
  @JsonKey(ignore: true)
  _$$ReplyImplCopyWith<_$ReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReplySnippet _$ReplySnippetFromJson(Map<String, dynamic> json) {
  return _ReplySnippet.fromJson(json);
}

/// @nodoc
mixin _$ReplySnippet {
  String get videoId => throw _privateConstructorUsedError;
  String get textDisplay => throw _privateConstructorUsedError;
  String get parentId => throw _privateConstructorUsedError;
  String get authorDisplayName => throw _privateConstructorUsedError;
  String get authorProfileImageUrl => throw _privateConstructorUsedError;
  String get authorChannelId => throw _privateConstructorUsedError;
  String get viewerRating => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplySnippetCopyWith<ReplySnippet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplySnippetCopyWith<$Res> {
  factory $ReplySnippetCopyWith(
          ReplySnippet value, $Res Function(ReplySnippet) then) =
      _$ReplySnippetCopyWithImpl<$Res, ReplySnippet>;
  @useResult
  $Res call(
      {String videoId,
      String textDisplay,
      String parentId,
      String authorDisplayName,
      String authorProfileImageUrl,
      String authorChannelId,
      String viewerRating,
      int likeCount,
      String updatedAt});
}

/// @nodoc
class _$ReplySnippetCopyWithImpl<$Res, $Val extends ReplySnippet>
    implements $ReplySnippetCopyWith<$Res> {
  _$ReplySnippetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? textDisplay = null,
    Object? parentId = null,
    Object? authorDisplayName = null,
    Object? authorProfileImageUrl = null,
    Object? authorChannelId = null,
    Object? viewerRating = null,
    Object? likeCount = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      textDisplay: null == textDisplay
          ? _value.textDisplay
          : textDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorDisplayName: null == authorDisplayName
          ? _value.authorDisplayName
          : authorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileImageUrl: null == authorProfileImageUrl
          ? _value.authorProfileImageUrl
          : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorChannelId: null == authorChannelId
          ? _value.authorChannelId
          : authorChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      viewerRating: null == viewerRating
          ? _value.viewerRating
          : viewerRating // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReplySnippetImplCopyWith<$Res>
    implements $ReplySnippetCopyWith<$Res> {
  factory _$$ReplySnippetImplCopyWith(
          _$ReplySnippetImpl value, $Res Function(_$ReplySnippetImpl) then) =
      __$$ReplySnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId,
      String textDisplay,
      String parentId,
      String authorDisplayName,
      String authorProfileImageUrl,
      String authorChannelId,
      String viewerRating,
      int likeCount,
      String updatedAt});
}

/// @nodoc
class __$$ReplySnippetImplCopyWithImpl<$Res>
    extends _$ReplySnippetCopyWithImpl<$Res, _$ReplySnippetImpl>
    implements _$$ReplySnippetImplCopyWith<$Res> {
  __$$ReplySnippetImplCopyWithImpl(
      _$ReplySnippetImpl _value, $Res Function(_$ReplySnippetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? textDisplay = null,
    Object? parentId = null,
    Object? authorDisplayName = null,
    Object? authorProfileImageUrl = null,
    Object? authorChannelId = null,
    Object? viewerRating = null,
    Object? likeCount = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ReplySnippetImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      textDisplay: null == textDisplay
          ? _value.textDisplay
          : textDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorDisplayName: null == authorDisplayName
          ? _value.authorDisplayName
          : authorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileImageUrl: null == authorProfileImageUrl
          ? _value.authorProfileImageUrl
          : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      authorChannelId: null == authorChannelId
          ? _value.authorChannelId
          : authorChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      viewerRating: null == viewerRating
          ? _value.viewerRating
          : viewerRating // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplySnippetImpl implements _ReplySnippet {
  const _$ReplySnippetImpl(
      {required this.videoId,
      required this.textDisplay,
      required this.parentId,
      required this.authorDisplayName,
      required this.authorProfileImageUrl,
      required this.authorChannelId,
      required this.viewerRating,
      required this.likeCount,
      required this.updatedAt});

  factory _$ReplySnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplySnippetImplFromJson(json);

  @override
  final String videoId;
  @override
  final String textDisplay;
  @override
  final String parentId;
  @override
  final String authorDisplayName;
  @override
  final String authorProfileImageUrl;
  @override
  final String authorChannelId;
  @override
  final String viewerRating;
  @override
  final int likeCount;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'ReplySnippet(videoId: $videoId, textDisplay: $textDisplay, parentId: $parentId, authorDisplayName: $authorDisplayName, authorProfileImageUrl: $authorProfileImageUrl, authorChannelId: $authorChannelId, viewerRating: $viewerRating, likeCount: $likeCount, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplySnippetImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.textDisplay, textDisplay) ||
                other.textDisplay == textDisplay) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.authorDisplayName, authorDisplayName) ||
                other.authorDisplayName == authorDisplayName) &&
            (identical(other.authorProfileImageUrl, authorProfileImageUrl) ||
                other.authorProfileImageUrl == authorProfileImageUrl) &&
            (identical(other.authorChannelId, authorChannelId) ||
                other.authorChannelId == authorChannelId) &&
            (identical(other.viewerRating, viewerRating) ||
                other.viewerRating == viewerRating) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      textDisplay,
      parentId,
      authorDisplayName,
      authorProfileImageUrl,
      authorChannelId,
      viewerRating,
      likeCount,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplySnippetImplCopyWith<_$ReplySnippetImpl> get copyWith =>
      __$$ReplySnippetImplCopyWithImpl<_$ReplySnippetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplySnippetImplToJson(
      this,
    );
  }
}

abstract class _ReplySnippet implements ReplySnippet {
  const factory _ReplySnippet(
      {required final String videoId,
      required final String textDisplay,
      required final String parentId,
      required final String authorDisplayName,
      required final String authorProfileImageUrl,
      required final String authorChannelId,
      required final String viewerRating,
      required final int likeCount,
      required final String updatedAt}) = _$ReplySnippetImpl;

  factory _ReplySnippet.fromJson(Map<String, dynamic> json) =
      _$ReplySnippetImpl.fromJson;

  @override
  String get videoId;
  @override
  String get textDisplay;
  @override
  String get parentId;
  @override
  String get authorDisplayName;
  @override
  String get authorProfileImageUrl;
  @override
  String get authorChannelId;
  @override
  String get viewerRating;
  @override
  int get likeCount;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ReplySnippetImplCopyWith<_$ReplySnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
