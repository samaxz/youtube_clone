// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShowOptions {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() neither,
    required TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)
        video,
    required TResult Function() channel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? neither,
    TResult? Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult? Function()? channel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? neither,
    TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult Function()? channel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Neither value) neither,
    required TResult Function(VideoOptions value) video,
    required TResult Function(ChannelOptions value) channel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Neither value)? neither,
    TResult? Function(VideoOptions value)? video,
    TResult? Function(ChannelOptions value)? channel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Neither value)? neither,
    TResult Function(VideoOptions value)? video,
    TResult Function(ChannelOptions value)? channel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowOptionsCopyWith<$Res> {
  factory $ShowOptionsCopyWith(
          ShowOptions value, $Res Function(ShowOptions) then) =
      _$ShowOptionsCopyWithImpl<$Res, ShowOptions>;
}

/// @nodoc
class _$ShowOptionsCopyWithImpl<$Res, $Val extends ShowOptions>
    implements $ShowOptionsCopyWith<$Res> {
  _$ShowOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NeitherImplCopyWith<$Res> {
  factory _$$NeitherImplCopyWith(
          _$NeitherImpl value, $Res Function(_$NeitherImpl) then) =
      __$$NeitherImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NeitherImplCopyWithImpl<$Res>
    extends _$ShowOptionsCopyWithImpl<$Res, _$NeitherImpl>
    implements _$$NeitherImplCopyWith<$Res> {
  __$$NeitherImplCopyWithImpl(
      _$NeitherImpl _value, $Res Function(_$NeitherImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NeitherImpl implements Neither {
  const _$NeitherImpl();

  @override
  String toString() {
    return 'ShowOptions.neither()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NeitherImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() neither,
    required TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)
        video,
    required TResult Function() channel,
  }) {
    return neither();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? neither,
    TResult? Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult? Function()? channel,
  }) {
    return neither?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? neither,
    TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult Function()? channel,
    required TResult orElse(),
  }) {
    if (neither != null) {
      return neither();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Neither value) neither,
    required TResult Function(VideoOptions value) video,
    required TResult Function(ChannelOptions value) channel,
  }) {
    return neither(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Neither value)? neither,
    TResult? Function(VideoOptions value)? video,
    TResult? Function(ChannelOptions value)? channel,
  }) {
    return neither?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Neither value)? neither,
    TResult Function(VideoOptions value)? video,
    TResult Function(ChannelOptions value)? channel,
    required TResult orElse(),
  }) {
    if (neither != null) {
      return neither(this);
    }
    return orElse();
  }
}

abstract class Neither implements ShowOptions {
  const factory Neither() = _$NeitherImpl;
}

/// @nodoc
abstract class _$$VideoOptionsImplCopyWith<$Res> {
  factory _$$VideoOptionsImplCopyWith(
          _$VideoOptionsImpl value, $Res Function(_$VideoOptionsImpl) then) =
      __$$VideoOptionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String videoId, ScreenActions screenActions, int videoCardIndex});
}

/// @nodoc
class __$$VideoOptionsImplCopyWithImpl<$Res>
    extends _$ShowOptionsCopyWithImpl<$Res, _$VideoOptionsImpl>
    implements _$$VideoOptionsImplCopyWith<$Res> {
  __$$VideoOptionsImplCopyWithImpl(
      _$VideoOptionsImpl _value, $Res Function(_$VideoOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? screenActions = null,
    Object? videoCardIndex = null,
  }) {
    return _then(_$VideoOptionsImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      screenActions: null == screenActions
          ? _value.screenActions
          : screenActions // ignore: cast_nullable_to_non_nullable
              as ScreenActions,
      videoCardIndex: null == videoCardIndex
          ? _value.videoCardIndex
          : videoCardIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VideoOptionsImpl implements VideoOptions {
  const _$VideoOptionsImpl(
      {required this.videoId,
      required this.screenActions,
      required this.videoCardIndex});

  @override
  final String videoId;
  @override
  final ScreenActions screenActions;
  @override
  final int videoCardIndex;

  @override
  String toString() {
    return 'ShowOptions.video(videoId: $videoId, screenActions: $screenActions, videoCardIndex: $videoCardIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoOptionsImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.screenActions, screenActions) ||
                other.screenActions == screenActions) &&
            (identical(other.videoCardIndex, videoCardIndex) ||
                other.videoCardIndex == videoCardIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, videoId, screenActions, videoCardIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoOptionsImplCopyWith<_$VideoOptionsImpl> get copyWith =>
      __$$VideoOptionsImplCopyWithImpl<_$VideoOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() neither,
    required TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)
        video,
    required TResult Function() channel,
  }) {
    return video(videoId, screenActions, videoCardIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? neither,
    TResult? Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult? Function()? channel,
  }) {
    return video?.call(videoId, screenActions, videoCardIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? neither,
    TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult Function()? channel,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(videoId, screenActions, videoCardIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Neither value) neither,
    required TResult Function(VideoOptions value) video,
    required TResult Function(ChannelOptions value) channel,
  }) {
    return video(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Neither value)? neither,
    TResult? Function(VideoOptions value)? video,
    TResult? Function(ChannelOptions value)? channel,
  }) {
    return video?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Neither value)? neither,
    TResult Function(VideoOptions value)? video,
    TResult Function(ChannelOptions value)? channel,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(this);
    }
    return orElse();
  }
}

abstract class VideoOptions implements ShowOptions {
  const factory VideoOptions(
      {required final String videoId,
      required final ScreenActions screenActions,
      required final int videoCardIndex}) = _$VideoOptionsImpl;

  String get videoId;
  ScreenActions get screenActions;
  int get videoCardIndex;
  @JsonKey(ignore: true)
  _$$VideoOptionsImplCopyWith<_$VideoOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChannelOptionsImplCopyWith<$Res> {
  factory _$$ChannelOptionsImplCopyWith(_$ChannelOptionsImpl value,
          $Res Function(_$ChannelOptionsImpl) then) =
      __$$ChannelOptionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChannelOptionsImplCopyWithImpl<$Res>
    extends _$ShowOptionsCopyWithImpl<$Res, _$ChannelOptionsImpl>
    implements _$$ChannelOptionsImplCopyWith<$Res> {
  __$$ChannelOptionsImplCopyWithImpl(
      _$ChannelOptionsImpl _value, $Res Function(_$ChannelOptionsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChannelOptionsImpl implements ChannelOptions {
  const _$ChannelOptionsImpl();

  @override
  String toString() {
    return 'ShowOptions.channel()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChannelOptionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() neither,
    required TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)
        video,
    required TResult Function() channel,
  }) {
    return channel();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? neither,
    TResult? Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult? Function()? channel,
  }) {
    return channel?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? neither,
    TResult Function(
            String videoId, ScreenActions screenActions, int videoCardIndex)?
        video,
    TResult Function()? channel,
    required TResult orElse(),
  }) {
    if (channel != null) {
      return channel();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Neither value) neither,
    required TResult Function(VideoOptions value) video,
    required TResult Function(ChannelOptions value) channel,
  }) {
    return channel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Neither value)? neither,
    TResult? Function(VideoOptions value)? video,
    TResult? Function(ChannelOptions value)? channel,
  }) {
    return channel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Neither value)? neither,
    TResult Function(VideoOptions value)? video,
    TResult Function(ChannelOptions value)? channel,
    required TResult orElse(),
  }) {
    if (channel != null) {
      return channel(this);
    }
    return orElse();
  }
}

abstract class ChannelOptions implements ShowOptions {
  const factory ChannelOptions() = _$ChannelOptionsImpl;
}
