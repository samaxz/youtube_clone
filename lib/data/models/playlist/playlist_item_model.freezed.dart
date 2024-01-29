// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) {
  return _PlaylistItem.fromJson(json);
}

/// @nodoc
mixin _$PlaylistItem {
  String get etag => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Snippet get snippet => throw _privateConstructorUsedError;
  ContentDetails get contentDetails => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistItemCopyWith<PlaylistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistItemCopyWith<$Res> {
  factory $PlaylistItemCopyWith(
          PlaylistItem value, $Res Function(PlaylistItem) then) =
      _$PlaylistItemCopyWithImpl<$Res, PlaylistItem>;
  @useResult
  $Res call(
      {String etag,
      String id,
      Snippet snippet,
      ContentDetails contentDetails,
      String status});

  $SnippetCopyWith<$Res> get snippet;
  $ContentDetailsCopyWith<$Res> get contentDetails;
}

/// @nodoc
class _$PlaylistItemCopyWithImpl<$Res, $Val extends PlaylistItem>
    implements $PlaylistItemCopyWith<$Res> {
  _$PlaylistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? id = null,
    Object? snippet = null,
    Object? contentDetails = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      snippet: null == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as Snippet,
      contentDetails: null == contentDetails
          ? _value.contentDetails
          : contentDetails // ignore: cast_nullable_to_non_nullable
              as ContentDetails,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SnippetCopyWith<$Res> get snippet {
    return $SnippetCopyWith<$Res>(_value.snippet, (value) {
      return _then(_value.copyWith(snippet: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContentDetailsCopyWith<$Res> get contentDetails {
    return $ContentDetailsCopyWith<$Res>(_value.contentDetails, (value) {
      return _then(_value.copyWith(contentDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaylistItemImplCopyWith<$Res>
    implements $PlaylistItemCopyWith<$Res> {
  factory _$$PlaylistItemImplCopyWith(
          _$PlaylistItemImpl value, $Res Function(_$PlaylistItemImpl) then) =
      __$$PlaylistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String etag,
      String id,
      Snippet snippet,
      ContentDetails contentDetails,
      String status});

  @override
  $SnippetCopyWith<$Res> get snippet;
  @override
  $ContentDetailsCopyWith<$Res> get contentDetails;
}

/// @nodoc
class __$$PlaylistItemImplCopyWithImpl<$Res>
    extends _$PlaylistItemCopyWithImpl<$Res, _$PlaylistItemImpl>
    implements _$$PlaylistItemImplCopyWith<$Res> {
  __$$PlaylistItemImplCopyWithImpl(
      _$PlaylistItemImpl _value, $Res Function(_$PlaylistItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? etag = null,
    Object? id = null,
    Object? snippet = null,
    Object? contentDetails = null,
    Object? status = null,
  }) {
    return _then(_$PlaylistItemImpl(
      etag: null == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      snippet: null == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as Snippet,
      contentDetails: null == contentDetails
          ? _value.contentDetails
          : contentDetails // ignore: cast_nullable_to_non_nullable
              as ContentDetails,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaylistItemImpl implements _PlaylistItem {
  const _$PlaylistItemImpl(
      {required this.etag,
      required this.id,
      required this.snippet,
      required this.contentDetails,
      required this.status});

  factory _$PlaylistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaylistItemImplFromJson(json);

  @override
  final String etag;
  @override
  final String id;
  @override
  final Snippet snippet;
  @override
  final ContentDetails contentDetails;
  @override
  final String status;

  @override
  String toString() {
    return 'PlaylistItem(etag: $etag, id: $id, snippet: $snippet, contentDetails: $contentDetails, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistItemImpl &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.snippet, snippet) || other.snippet == snippet) &&
            (identical(other.contentDetails, contentDetails) ||
                other.contentDetails == contentDetails) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, etag, id, snippet, contentDetails, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistItemImplCopyWith<_$PlaylistItemImpl> get copyWith =>
      __$$PlaylistItemImplCopyWithImpl<_$PlaylistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaylistItemImplToJson(
      this,
    );
  }
}

abstract class _PlaylistItem implements PlaylistItem {
  const factory _PlaylistItem(
      {required final String etag,
      required final String id,
      required final Snippet snippet,
      required final ContentDetails contentDetails,
      required final String status}) = _$PlaylistItemImpl;

  factory _PlaylistItem.fromJson(Map<String, dynamic> json) =
      _$PlaylistItemImpl.fromJson;

  @override
  String get etag;
  @override
  String get id;
  @override
  Snippet get snippet;
  @override
  ContentDetails get contentDetails;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$PlaylistItemImplCopyWith<_$PlaylistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Snippet _$SnippetFromJson(Map<String, dynamic> json) {
  return _Snippet.fromJson(json);
}

/// @nodoc
mixin _$Snippet {
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  String? get channelId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnails')
  Thumbnail get thumbnail => throw _privateConstructorUsedError;
  String? get channelTitle => throw _privateConstructorUsedError;
  String? get playlistId => throw _privateConstructorUsedError;
  int? get position =>
      throw _privateConstructorUsedError; // TODO make more research on this
  String? get videoId => throw _privateConstructorUsedError;
  String? get videoOwnerChannelTitle => throw _privateConstructorUsedError;
  String? get videoOwnerChannelId => throw _privateConstructorUsedError;

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
      {DateTime? publishedAt,
      String? channelId,
      String? title,
      String? description,
      @JsonKey(name: 'thumbnails') Thumbnail thumbnail,
      String? channelTitle,
      String? playlistId,
      int? position,
      String? videoId,
      String? videoOwnerChannelTitle,
      String? videoOwnerChannelId});

  $ThumbnailCopyWith<$Res> get thumbnail;
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
    Object? publishedAt = freezed,
    Object? channelId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnail = null,
    Object? channelTitle = freezed,
    Object? playlistId = freezed,
    Object? position = freezed,
    Object? videoId = freezed,
    Object? videoOwnerChannelTitle = freezed,
    Object? videoOwnerChannelId = freezed,
  }) {
    return _then(_value.copyWith(
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      channelTitle: freezed == channelTitle
          ? _value.channelTitle
          : channelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: freezed == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      videoOwnerChannelTitle: freezed == videoOwnerChannelTitle
          ? _value.videoOwnerChannelTitle
          : videoOwnerChannelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      videoOwnerChannelId: freezed == videoOwnerChannelId
          ? _value.videoOwnerChannelId
          : videoOwnerChannelId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res> get thumbnail {
    return $ThumbnailCopyWith<$Res>(_value.thumbnail, (value) {
      return _then(_value.copyWith(thumbnail: value) as $Val);
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
      {DateTime? publishedAt,
      String? channelId,
      String? title,
      String? description,
      @JsonKey(name: 'thumbnails') Thumbnail thumbnail,
      String? channelTitle,
      String? playlistId,
      int? position,
      String? videoId,
      String? videoOwnerChannelTitle,
      String? videoOwnerChannelId});

  @override
  $ThumbnailCopyWith<$Res> get thumbnail;
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
    Object? publishedAt = freezed,
    Object? channelId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnail = null,
    Object? channelTitle = freezed,
    Object? playlistId = freezed,
    Object? position = freezed,
    Object? videoId = freezed,
    Object? videoOwnerChannelTitle = freezed,
    Object? videoOwnerChannelId = freezed,
  }) {
    return _then(_$SnippetImpl(
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      channelTitle: freezed == channelTitle
          ? _value.channelTitle
          : channelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: freezed == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      videoOwnerChannelTitle: freezed == videoOwnerChannelTitle
          ? _value.videoOwnerChannelTitle
          : videoOwnerChannelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      videoOwnerChannelId: freezed == videoOwnerChannelId
          ? _value.videoOwnerChannelId
          : videoOwnerChannelId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnippetImpl implements _Snippet {
  const _$SnippetImpl(
      {required this.publishedAt,
      required this.channelId,
      required this.title,
      required this.description,
      @JsonKey(name: 'thumbnails') required this.thumbnail,
      required this.channelTitle,
      required this.playlistId,
      required this.position,
      required this.videoId,
      required this.videoOwnerChannelTitle,
      required this.videoOwnerChannelId});

  factory _$SnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnippetImplFromJson(json);

  @override
  final DateTime? publishedAt;
  @override
  final String? channelId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'thumbnails')
  final Thumbnail thumbnail;
  @override
  final String? channelTitle;
  @override
  final String? playlistId;
  @override
  final int? position;
// TODO make more research on this
  @override
  final String? videoId;
  @override
  final String? videoOwnerChannelTitle;
  @override
  final String? videoOwnerChannelId;

  @override
  String toString() {
    return 'Snippet(publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, thumbnail: $thumbnail, channelTitle: $channelTitle, playlistId: $playlistId, position: $position, videoId: $videoId, videoOwnerChannelTitle: $videoOwnerChannelTitle, videoOwnerChannelId: $videoOwnerChannelId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnippetImpl &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.channelTitle, channelTitle) ||
                other.channelTitle == channelTitle) &&
            (identical(other.playlistId, playlistId) ||
                other.playlistId == playlistId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.videoOwnerChannelTitle, videoOwnerChannelTitle) ||
                other.videoOwnerChannelTitle == videoOwnerChannelTitle) &&
            (identical(other.videoOwnerChannelId, videoOwnerChannelId) ||
                other.videoOwnerChannelId == videoOwnerChannelId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      publishedAt,
      channelId,
      title,
      description,
      thumbnail,
      channelTitle,
      playlistId,
      position,
      videoId,
      videoOwnerChannelTitle,
      videoOwnerChannelId);

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
      {required final DateTime? publishedAt,
      required final String? channelId,
      required final String? title,
      required final String? description,
      @JsonKey(name: 'thumbnails') required final Thumbnail thumbnail,
      required final String? channelTitle,
      required final String? playlistId,
      required final int? position,
      required final String? videoId,
      required final String? videoOwnerChannelTitle,
      required final String? videoOwnerChannelId}) = _$SnippetImpl;

  factory _Snippet.fromJson(Map<String, dynamic> json) = _$SnippetImpl.fromJson;

  @override
  DateTime? get publishedAt;
  @override
  String? get channelId;
  @override
  String? get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'thumbnails')
  Thumbnail get thumbnail;
  @override
  String? get channelTitle;
  @override
  String? get playlistId;
  @override
  int? get position;
  @override // TODO make more research on this
  String? get videoId;
  @override
  String? get videoOwnerChannelTitle;
  @override
  String? get videoOwnerChannelId;
  @override
  @JsonKey(ignore: true)
  _$$SnippetImplCopyWith<_$SnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return _Thumbnail.fromJson(json);
}

/// @nodoc
mixin _$Thumbnail {
  String? get defaultRes => throw _privateConstructorUsedError;
  String? get medium => throw _privateConstructorUsedError;
  String? get high => throw _privateConstructorUsedError;
  String? get standard => throw _privateConstructorUsedError;
  String? get maxres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThumbnailCopyWith<Thumbnail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThumbnailCopyWith<$Res> {
  factory $ThumbnailCopyWith(Thumbnail value, $Res Function(Thumbnail) then) =
      _$ThumbnailCopyWithImpl<$Res, Thumbnail>;
  @useResult
  $Res call(
      {String? defaultRes,
      String? medium,
      String? high,
      String? standard,
      String? maxres});
}

/// @nodoc
class _$ThumbnailCopyWithImpl<$Res, $Val extends Thumbnail>
    implements $ThumbnailCopyWith<$Res> {
  _$ThumbnailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultRes = freezed,
    Object? medium = freezed,
    Object? high = freezed,
    Object? standard = freezed,
    Object? maxres = freezed,
  }) {
    return _then(_value.copyWith(
      defaultRes: freezed == defaultRes
          ? _value.defaultRes
          : defaultRes // ignore: cast_nullable_to_non_nullable
              as String?,
      medium: freezed == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String?,
      standard: freezed == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String?,
      maxres: freezed == maxres
          ? _value.maxres
          : maxres // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThumbnailImplCopyWith<$Res>
    implements $ThumbnailCopyWith<$Res> {
  factory _$$ThumbnailImplCopyWith(
          _$ThumbnailImpl value, $Res Function(_$ThumbnailImpl) then) =
      __$$ThumbnailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? defaultRes,
      String? medium,
      String? high,
      String? standard,
      String? maxres});
}

/// @nodoc
class __$$ThumbnailImplCopyWithImpl<$Res>
    extends _$ThumbnailCopyWithImpl<$Res, _$ThumbnailImpl>
    implements _$$ThumbnailImplCopyWith<$Res> {
  __$$ThumbnailImplCopyWithImpl(
      _$ThumbnailImpl _value, $Res Function(_$ThumbnailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultRes = freezed,
    Object? medium = freezed,
    Object? high = freezed,
    Object? standard = freezed,
    Object? maxres = freezed,
  }) {
    return _then(_$ThumbnailImpl(
      defaultRes: freezed == defaultRes
          ? _value.defaultRes
          : defaultRes // ignore: cast_nullable_to_non_nullable
              as String?,
      medium: freezed == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String?,
      standard: freezed == standard
          ? _value.standard
          : standard // ignore: cast_nullable_to_non_nullable
              as String?,
      maxres: freezed == maxres
          ? _value.maxres
          : maxres // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThumbnailImpl implements _Thumbnail {
  const _$ThumbnailImpl(
      {required this.defaultRes,
      required this.medium,
      required this.high,
      required this.standard,
      required this.maxres});

  factory _$ThumbnailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThumbnailImplFromJson(json);

  @override
  final String? defaultRes;
  @override
  final String? medium;
  @override
  final String? high;
  @override
  final String? standard;
  @override
  final String? maxres;

  @override
  String toString() {
    return 'Thumbnail(defaultRes: $defaultRes, medium: $medium, high: $high, standard: $standard, maxres: $maxres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThumbnailImpl &&
            (identical(other.defaultRes, defaultRes) ||
                other.defaultRes == defaultRes) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.standard, standard) ||
                other.standard == standard) &&
            (identical(other.maxres, maxres) || other.maxres == maxres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, defaultRes, medium, high, standard, maxres);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThumbnailImplCopyWith<_$ThumbnailImpl> get copyWith =>
      __$$ThumbnailImplCopyWithImpl<_$ThumbnailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThumbnailImplToJson(
      this,
    );
  }
}

abstract class _Thumbnail implements Thumbnail {
  const factory _Thumbnail(
      {required final String? defaultRes,
      required final String? medium,
      required final String? high,
      required final String? standard,
      required final String? maxres}) = _$ThumbnailImpl;

  factory _Thumbnail.fromJson(Map<String, dynamic> json) =
      _$ThumbnailImpl.fromJson;

  @override
  String? get defaultRes;
  @override
  String? get medium;
  @override
  String? get high;
  @override
  String? get standard;
  @override
  String? get maxres;
  @override
  @JsonKey(ignore: true)
  _$$ThumbnailImplCopyWith<_$ThumbnailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) {
  return _ContentDetails.fromJson(json);
}

/// @nodoc
mixin _$ContentDetails {
  String? get videoId => throw _privateConstructorUsedError;
  DateTime? get videoPublishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentDetailsCopyWith<ContentDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentDetailsCopyWith<$Res> {
  factory $ContentDetailsCopyWith(
          ContentDetails value, $Res Function(ContentDetails) then) =
      _$ContentDetailsCopyWithImpl<$Res, ContentDetails>;
  @useResult
  $Res call({String? videoId, DateTime? videoPublishedAt});
}

/// @nodoc
class _$ContentDetailsCopyWithImpl<$Res, $Val extends ContentDetails>
    implements $ContentDetailsCopyWith<$Res> {
  _$ContentDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = freezed,
    Object? videoPublishedAt = freezed,
  }) {
    return _then(_value.copyWith(
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      videoPublishedAt: freezed == videoPublishedAt
          ? _value.videoPublishedAt
          : videoPublishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentDetailsImplCopyWith<$Res>
    implements $ContentDetailsCopyWith<$Res> {
  factory _$$ContentDetailsImplCopyWith(_$ContentDetailsImpl value,
          $Res Function(_$ContentDetailsImpl) then) =
      __$$ContentDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? videoId, DateTime? videoPublishedAt});
}

/// @nodoc
class __$$ContentDetailsImplCopyWithImpl<$Res>
    extends _$ContentDetailsCopyWithImpl<$Res, _$ContentDetailsImpl>
    implements _$$ContentDetailsImplCopyWith<$Res> {
  __$$ContentDetailsImplCopyWithImpl(
      _$ContentDetailsImpl _value, $Res Function(_$ContentDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = freezed,
    Object? videoPublishedAt = freezed,
  }) {
    return _then(_$ContentDetailsImpl(
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      videoPublishedAt: freezed == videoPublishedAt
          ? _value.videoPublishedAt
          : videoPublishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentDetailsImpl implements _ContentDetails {
  const _$ContentDetailsImpl(
      {required this.videoId, required this.videoPublishedAt});

  factory _$ContentDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentDetailsImplFromJson(json);

  @override
  final String? videoId;
  @override
  final DateTime? videoPublishedAt;

  @override
  String toString() {
    return 'ContentDetails(videoId: $videoId, videoPublishedAt: $videoPublishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentDetailsImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.videoPublishedAt, videoPublishedAt) ||
                other.videoPublishedAt == videoPublishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, videoId, videoPublishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentDetailsImplCopyWith<_$ContentDetailsImpl> get copyWith =>
      __$$ContentDetailsImplCopyWithImpl<_$ContentDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentDetailsImplToJson(
      this,
    );
  }
}

abstract class _ContentDetails implements ContentDetails {
  const factory _ContentDetails(
      {required final String? videoId,
      required final DateTime? videoPublishedAt}) = _$ContentDetailsImpl;

  factory _ContentDetails.fromJson(Map<String, dynamic> json) =
      _$ContentDetailsImpl.fromJson;

  @override
  String? get videoId;
  @override
  DateTime? get videoPublishedAt;
  @override
  @JsonKey(ignore: true)
  _$$ContentDetailsImplCopyWith<_$ContentDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
