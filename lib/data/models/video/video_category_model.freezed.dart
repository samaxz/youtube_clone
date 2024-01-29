// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoCategory _$VideoCategoryFromJson(Map<String, dynamic> json) {
  return _VideoCategory.fromJson(json);
}

/// @nodoc
mixin _$VideoCategory {
  String get id => throw _privateConstructorUsedError;
  Snippet get snippet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoCategoryCopyWith<VideoCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCategoryCopyWith<$Res> {
  factory $VideoCategoryCopyWith(
          VideoCategory value, $Res Function(VideoCategory) then) =
      _$VideoCategoryCopyWithImpl<$Res, VideoCategory>;
  @useResult
  $Res call({String id, Snippet snippet});

  $SnippetCopyWith<$Res> get snippet;
}

/// @nodoc
class _$VideoCategoryCopyWithImpl<$Res, $Val extends VideoCategory>
    implements $VideoCategoryCopyWith<$Res> {
  _$VideoCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? snippet = null,
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
abstract class _$$VideoCategoryImplCopyWith<$Res>
    implements $VideoCategoryCopyWith<$Res> {
  factory _$$VideoCategoryImplCopyWith(
          _$VideoCategoryImpl value, $Res Function(_$VideoCategoryImpl) then) =
      __$$VideoCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Snippet snippet});

  @override
  $SnippetCopyWith<$Res> get snippet;
}

/// @nodoc
class __$$VideoCategoryImplCopyWithImpl<$Res>
    extends _$VideoCategoryCopyWithImpl<$Res, _$VideoCategoryImpl>
    implements _$$VideoCategoryImplCopyWith<$Res> {
  __$$VideoCategoryImplCopyWithImpl(
      _$VideoCategoryImpl _value, $Res Function(_$VideoCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? snippet = null,
  }) {
    return _then(_$VideoCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      snippet: null == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as Snippet,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoCategoryImpl implements _VideoCategory {
  const _$VideoCategoryImpl({required this.id, required this.snippet});

  factory _$VideoCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final Snippet snippet;

  @override
  String toString() {
    return 'VideoCategory(id: $id, snippet: $snippet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.snippet, snippet) || other.snippet == snippet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, snippet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoCategoryImplCopyWith<_$VideoCategoryImpl> get copyWith =>
      __$$VideoCategoryImplCopyWithImpl<_$VideoCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoCategoryImplToJson(
      this,
    );
  }
}

abstract class _VideoCategory implements VideoCategory {
  const factory _VideoCategory(
      {required final String id,
      required final Snippet snippet}) = _$VideoCategoryImpl;

  factory _VideoCategory.fromJson(Map<String, dynamic> json) =
      _$VideoCategoryImpl.fromJson;

  @override
  String get id;
  @override
  Snippet get snippet;
  @override
  @JsonKey(ignore: true)
  _$$VideoCategoryImplCopyWith<_$VideoCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Snippet _$SnippetFromJson(Map<String, dynamic> json) {
  return _Snippet.fromJson(json);
}

/// @nodoc
mixin _$Snippet {
  String get title => throw _privateConstructorUsedError;
  bool get assignable => throw _privateConstructorUsedError;
  String get channelId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnippetCopyWith<Snippet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnippetCopyWith<$Res> {
  factory $SnippetCopyWith(Snippet value, $Res Function(Snippet) then) =
      _$SnippetCopyWithImpl<$Res, Snippet>;
  @useResult
  $Res call({String title, bool assignable, String channelId});
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
    Object? title = null,
    Object? assignable = null,
    Object? channelId = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      assignable: null == assignable
          ? _value.assignable
          : assignable // ignore: cast_nullable_to_non_nullable
              as bool,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnippetImplCopyWith<$Res> implements $SnippetCopyWith<$Res> {
  factory _$$SnippetImplCopyWith(
          _$SnippetImpl value, $Res Function(_$SnippetImpl) then) =
      __$$SnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool assignable, String channelId});
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
    Object? title = null,
    Object? assignable = null,
    Object? channelId = null,
  }) {
    return _then(_$SnippetImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      assignable: null == assignable
          ? _value.assignable
          : assignable // ignore: cast_nullable_to_non_nullable
              as bool,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnippetImpl implements _Snippet {
  const _$SnippetImpl(
      {required this.title, required this.assignable, required this.channelId});

  factory _$SnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnippetImplFromJson(json);

  @override
  final String title;
  @override
  final bool assignable;
  @override
  final String channelId;

  @override
  String toString() {
    return 'Snippet(title: $title, assignable: $assignable, channelId: $channelId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnippetImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.assignable, assignable) ||
                other.assignable == assignable) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, assignable, channelId);

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
      {required final String title,
      required final bool assignable,
      required final String channelId}) = _$SnippetImpl;

  factory _Snippet.fromJson(Map<String, dynamic> json) = _$SnippetImpl.fromJson;

  @override
  String get title;
  @override
  bool get assignable;
  @override
  String get channelId;
  @override
  @JsonKey(ignore: true)
  _$$SnippetImplCopyWith<_$SnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
