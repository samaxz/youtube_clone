// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseInfoState<T> {
  BaseInfo<T> get baseInfo => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseInfo<T> baseInfo) loading,
    required TResult Function(BaseInfo<T> baseInfo) loaded,
    required TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseInfo<T> baseInfo)? loading,
    TResult? Function(BaseInfo<T> baseInfo)? loaded,
    TResult? Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseInfo<T> baseInfo)? loading,
    TResult Function(BaseInfo<T> baseInfo)? loaded,
    TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInfoLoading<T> value) loading,
    required TResult Function(BaseInfoLoaded<T> value) loaded,
    required TResult Function(BaseInfoError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseInfoLoading<T> value)? loading,
    TResult? Function(BaseInfoLoaded<T> value)? loaded,
    TResult? Function(BaseInfoError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInfoLoading<T> value)? loading,
    TResult Function(BaseInfoLoaded<T> value)? loaded,
    TResult Function(BaseInfoError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BaseInfoStateCopyWith<T, BaseInfoState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseInfoStateCopyWith<T, $Res> {
  factory $BaseInfoStateCopyWith(
          BaseInfoState<T> value, $Res Function(BaseInfoState<T>) then) =
      _$BaseInfoStateCopyWithImpl<T, $Res, BaseInfoState<T>>;
  @useResult
  $Res call({BaseInfo<T> baseInfo});

  $BaseInfoCopyWith<T, $Res> get baseInfo;
}

/// @nodoc
class _$BaseInfoStateCopyWithImpl<T, $Res, $Val extends BaseInfoState<T>>
    implements $BaseInfoStateCopyWith<T, $Res> {
  _$BaseInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseInfo = null,
  }) {
    return _then(_value.copyWith(
      baseInfo: null == baseInfo
          ? _value.baseInfo
          : baseInfo // ignore: cast_nullable_to_non_nullable
              as BaseInfo<T>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BaseInfoCopyWith<T, $Res> get baseInfo {
    return $BaseInfoCopyWith<T, $Res>(_value.baseInfo, (value) {
      return _then(_value.copyWith(baseInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BaseInfoLoadingImplCopyWith<T, $Res>
    implements $BaseInfoStateCopyWith<T, $Res> {
  factory _$$BaseInfoLoadingImplCopyWith(_$BaseInfoLoadingImpl<T> value,
          $Res Function(_$BaseInfoLoadingImpl<T>) then) =
      __$$BaseInfoLoadingImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({BaseInfo<T> baseInfo});

  @override
  $BaseInfoCopyWith<T, $Res> get baseInfo;
}

/// @nodoc
class __$$BaseInfoLoadingImplCopyWithImpl<T, $Res>
    extends _$BaseInfoStateCopyWithImpl<T, $Res, _$BaseInfoLoadingImpl<T>>
    implements _$$BaseInfoLoadingImplCopyWith<T, $Res> {
  __$$BaseInfoLoadingImplCopyWithImpl(_$BaseInfoLoadingImpl<T> _value,
      $Res Function(_$BaseInfoLoadingImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseInfo = null,
  }) {
    return _then(_$BaseInfoLoadingImpl<T>(
      baseInfo: null == baseInfo
          ? _value.baseInfo
          : baseInfo // ignore: cast_nullable_to_non_nullable
              as BaseInfo<T>,
    ));
  }
}

/// @nodoc

class _$BaseInfoLoadingImpl<T> extends BaseInfoLoading<T> {
  const _$BaseInfoLoadingImpl({this.baseInfo = const BaseInfo()}) : super._();

  @override
  @JsonKey()
  final BaseInfo<T> baseInfo;

  @override
  String toString() {
    return 'BaseInfoState<$T>.loading(baseInfo: $baseInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoLoadingImpl<T> &&
            (identical(other.baseInfo, baseInfo) ||
                other.baseInfo == baseInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, baseInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoLoadingImplCopyWith<T, _$BaseInfoLoadingImpl<T>> get copyWith =>
      __$$BaseInfoLoadingImplCopyWithImpl<T, _$BaseInfoLoadingImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseInfo<T> baseInfo) loading,
    required TResult Function(BaseInfo<T> baseInfo) loaded,
    required TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)
        error,
  }) {
    return loading(baseInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseInfo<T> baseInfo)? loading,
    TResult? Function(BaseInfo<T> baseInfo)? loaded,
    TResult? Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
  }) {
    return loading?.call(baseInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseInfo<T> baseInfo)? loading,
    TResult Function(BaseInfo<T> baseInfo)? loaded,
    TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(baseInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInfoLoading<T> value) loading,
    required TResult Function(BaseInfoLoaded<T> value) loaded,
    required TResult Function(BaseInfoError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseInfoLoading<T> value)? loading,
    TResult? Function(BaseInfoLoaded<T> value)? loaded,
    TResult? Function(BaseInfoError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInfoLoading<T> value)? loading,
    TResult Function(BaseInfoLoaded<T> value)? loaded,
    TResult Function(BaseInfoError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BaseInfoLoading<T> extends BaseInfoState<T> {
  const factory BaseInfoLoading({final BaseInfo<T> baseInfo}) =
      _$BaseInfoLoadingImpl<T>;
  const BaseInfoLoading._() : super._();

  @override
  BaseInfo<T> get baseInfo;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoLoadingImplCopyWith<T, _$BaseInfoLoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BaseInfoLoadedImplCopyWith<T, $Res>
    implements $BaseInfoStateCopyWith<T, $Res> {
  factory _$$BaseInfoLoadedImplCopyWith(_$BaseInfoLoadedImpl<T> value,
          $Res Function(_$BaseInfoLoadedImpl<T>) then) =
      __$$BaseInfoLoadedImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({BaseInfo<T> baseInfo});

  @override
  $BaseInfoCopyWith<T, $Res> get baseInfo;
}

/// @nodoc
class __$$BaseInfoLoadedImplCopyWithImpl<T, $Res>
    extends _$BaseInfoStateCopyWithImpl<T, $Res, _$BaseInfoLoadedImpl<T>>
    implements _$$BaseInfoLoadedImplCopyWith<T, $Res> {
  __$$BaseInfoLoadedImplCopyWithImpl(_$BaseInfoLoadedImpl<T> _value,
      $Res Function(_$BaseInfoLoadedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseInfo = null,
  }) {
    return _then(_$BaseInfoLoadedImpl<T>(
      null == baseInfo
          ? _value.baseInfo
          : baseInfo // ignore: cast_nullable_to_non_nullable
              as BaseInfo<T>,
    ));
  }
}

/// @nodoc

class _$BaseInfoLoadedImpl<T> extends BaseInfoLoaded<T> {
  const _$BaseInfoLoadedImpl(this.baseInfo) : super._();

  @override
  final BaseInfo<T> baseInfo;

  @override
  String toString() {
    return 'BaseInfoState<$T>.loaded(baseInfo: $baseInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoLoadedImpl<T> &&
            (identical(other.baseInfo, baseInfo) ||
                other.baseInfo == baseInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, baseInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoLoadedImplCopyWith<T, _$BaseInfoLoadedImpl<T>> get copyWith =>
      __$$BaseInfoLoadedImplCopyWithImpl<T, _$BaseInfoLoadedImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseInfo<T> baseInfo) loading,
    required TResult Function(BaseInfo<T> baseInfo) loaded,
    required TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)
        error,
  }) {
    return loaded(baseInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseInfo<T> baseInfo)? loading,
    TResult? Function(BaseInfo<T> baseInfo)? loaded,
    TResult? Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
  }) {
    return loaded?.call(baseInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseInfo<T> baseInfo)? loading,
    TResult Function(BaseInfo<T> baseInfo)? loaded,
    TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(baseInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInfoLoading<T> value) loading,
    required TResult Function(BaseInfoLoaded<T> value) loaded,
    required TResult Function(BaseInfoError<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseInfoLoading<T> value)? loading,
    TResult? Function(BaseInfoLoaded<T> value)? loaded,
    TResult? Function(BaseInfoError<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInfoLoading<T> value)? loading,
    TResult Function(BaseInfoLoaded<T> value)? loaded,
    TResult Function(BaseInfoError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BaseInfoLoaded<T> extends BaseInfoState<T> {
  const factory BaseInfoLoaded(final BaseInfo<T> baseInfo) =
      _$BaseInfoLoadedImpl<T>;
  const BaseInfoLoaded._() : super._();

  @override
  BaseInfo<T> get baseInfo;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoLoadedImplCopyWith<T, _$BaseInfoLoadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BaseInfoErrorImplCopyWith<T, $Res>
    implements $BaseInfoStateCopyWith<T, $Res> {
  factory _$$BaseInfoErrorImplCopyWith(_$BaseInfoErrorImpl<T> value,
          $Res Function(_$BaseInfoErrorImpl<T>) then) =
      __$$BaseInfoErrorImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({BaseInfo<T> baseInfo, YoutubeFailure failure});

  @override
  $BaseInfoCopyWith<T, $Res> get baseInfo;
  $YoutubeFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BaseInfoErrorImplCopyWithImpl<T, $Res>
    extends _$BaseInfoStateCopyWithImpl<T, $Res, _$BaseInfoErrorImpl<T>>
    implements _$$BaseInfoErrorImplCopyWith<T, $Res> {
  __$$BaseInfoErrorImplCopyWithImpl(_$BaseInfoErrorImpl<T> _value,
      $Res Function(_$BaseInfoErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseInfo = null,
    Object? failure = null,
  }) {
    return _then(_$BaseInfoErrorImpl<T>(
      baseInfo: null == baseInfo
          ? _value.baseInfo
          : baseInfo // ignore: cast_nullable_to_non_nullable
              as BaseInfo<T>,
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as YoutubeFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $YoutubeFailureCopyWith<$Res> get failure {
    return $YoutubeFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$BaseInfoErrorImpl<T> extends BaseInfoError<T> {
  const _$BaseInfoErrorImpl({required this.baseInfo, required this.failure})
      : super._();

  @override
  final BaseInfo<T> baseInfo;
  @override
  final YoutubeFailure failure;

  @override
  String toString() {
    return 'BaseInfoState<$T>.error(baseInfo: $baseInfo, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoErrorImpl<T> &&
            (identical(other.baseInfo, baseInfo) ||
                other.baseInfo == baseInfo) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, baseInfo, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoErrorImplCopyWith<T, _$BaseInfoErrorImpl<T>> get copyWith =>
      __$$BaseInfoErrorImplCopyWithImpl<T, _$BaseInfoErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BaseInfo<T> baseInfo) loading,
    required TResult Function(BaseInfo<T> baseInfo) loaded,
    required TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)
        error,
  }) {
    return error(baseInfo, failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BaseInfo<T> baseInfo)? loading,
    TResult? Function(BaseInfo<T> baseInfo)? loaded,
    TResult? Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
  }) {
    return error?.call(baseInfo, failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseInfo<T> baseInfo)? loading,
    TResult Function(BaseInfo<T> baseInfo)? loaded,
    TResult Function(BaseInfo<T> baseInfo, YoutubeFailure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(baseInfo, failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BaseInfoLoading<T> value) loading,
    required TResult Function(BaseInfoLoaded<T> value) loaded,
    required TResult Function(BaseInfoError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BaseInfoLoading<T> value)? loading,
    TResult? Function(BaseInfoLoaded<T> value)? loaded,
    TResult? Function(BaseInfoError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BaseInfoLoading<T> value)? loading,
    TResult Function(BaseInfoLoaded<T> value)? loaded,
    TResult Function(BaseInfoError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BaseInfoError<T> extends BaseInfoState<T> {
  const factory BaseInfoError(
      {required final BaseInfo<T> baseInfo,
      required final YoutubeFailure failure}) = _$BaseInfoErrorImpl<T>;
  const BaseInfoError._() : super._();

  @override
  BaseInfo<T> get baseInfo;
  YoutubeFailure get failure;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoErrorImplCopyWith<T, _$BaseInfoErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
