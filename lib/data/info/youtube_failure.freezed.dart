// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'youtube_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FailureData {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureDataCopyWith<FailureData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureDataCopyWith<$Res> {
  factory $FailureDataCopyWith(
          FailureData value, $Res Function(FailureData) then) =
      _$FailureDataCopyWithImpl<$Res, FailureData>;
  @useResult
  $Res call({int? code, String? message, StackTrace? stackTrace});
}

/// @nodoc
class _$FailureDataCopyWithImpl<$Res, $Val extends FailureData>
    implements $FailureDataCopyWith<$Res> {
  _$FailureDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FailureDataImplCopyWith<$Res>
    implements $FailureDataCopyWith<$Res> {
  factory _$$FailureDataImplCopyWith(
          _$FailureDataImpl value, $Res Function(_$FailureDataImpl) then) =
      __$$FailureDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, StackTrace? stackTrace});
}

/// @nodoc
class __$$FailureDataImplCopyWithImpl<$Res>
    extends _$FailureDataCopyWithImpl<$Res, _$FailureDataImpl>
    implements _$$FailureDataImplCopyWith<$Res> {
  __$$FailureDataImplCopyWithImpl(
      _$FailureDataImpl _value, $Res Function(_$FailureDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$FailureDataImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$FailureDataImpl implements _FailureData {
  const _$FailureDataImpl(
      {required this.code, required this.message, this.stackTrace});

  @override
  final int? code;
  @override
  final String? message;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'FailureData(code: $code, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureDataImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureDataImplCopyWith<_$FailureDataImpl> get copyWith =>
      __$$FailureDataImplCopyWithImpl<_$FailureDataImpl>(this, _$identity);
}

abstract class _FailureData implements FailureData {
  const factory _FailureData(
      {required final int? code,
      required final String? message,
      final StackTrace? stackTrace}) = _$FailureDataImpl;

  @override
  int? get code;
  @override
  String? get message;
  @override
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$FailureDataImplCopyWith<_$FailureDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$YoutubeFailure {
  FailureData get failureData => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureData failureData) $default, {
    required TResult Function(FailureData failureData) noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureData failureData)? $default, {
    TResult? Function(FailureData failureData)? noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureData failureData)? $default, {
    TResult Function(FailureData failureData)? noConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_YoutubeFailure value) $default, {
    required TResult Function(NoConnectionFailure value) noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_YoutubeFailure value)? $default, {
    TResult? Function(NoConnectionFailure value)? noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_YoutubeFailure value)? $default, {
    TResult Function(NoConnectionFailure value)? noConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $YoutubeFailureCopyWith<YoutubeFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeFailureCopyWith<$Res> {
  factory $YoutubeFailureCopyWith(
          YoutubeFailure value, $Res Function(YoutubeFailure) then) =
      _$YoutubeFailureCopyWithImpl<$Res, YoutubeFailure>;
  @useResult
  $Res call({FailureData failureData});

  $FailureDataCopyWith<$Res> get failureData;
}

/// @nodoc
class _$YoutubeFailureCopyWithImpl<$Res, $Val extends YoutubeFailure>
    implements $YoutubeFailureCopyWith<$Res> {
  _$YoutubeFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failureData = null,
  }) {
    return _then(_value.copyWith(
      failureData: null == failureData
          ? _value.failureData
          : failureData // ignore: cast_nullable_to_non_nullable
              as FailureData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureDataCopyWith<$Res> get failureData {
    return $FailureDataCopyWith<$Res>(_value.failureData, (value) {
      return _then(_value.copyWith(failureData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YoutubeFailureImplCopyWith<$Res>
    implements $YoutubeFailureCopyWith<$Res> {
  factory _$$YoutubeFailureImplCopyWith(_$YoutubeFailureImpl value,
          $Res Function(_$YoutubeFailureImpl) then) =
      __$$YoutubeFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureData failureData});

  @override
  $FailureDataCopyWith<$Res> get failureData;
}

/// @nodoc
class __$$YoutubeFailureImplCopyWithImpl<$Res>
    extends _$YoutubeFailureCopyWithImpl<$Res, _$YoutubeFailureImpl>
    implements _$$YoutubeFailureImplCopyWith<$Res> {
  __$$YoutubeFailureImplCopyWithImpl(
      _$YoutubeFailureImpl _value, $Res Function(_$YoutubeFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failureData = null,
  }) {
    return _then(_$YoutubeFailureImpl(
      null == failureData
          ? _value.failureData
          : failureData // ignore: cast_nullable_to_non_nullable
              as FailureData,
    ));
  }
}

/// @nodoc

class _$YoutubeFailureImpl implements _YoutubeFailure {
  const _$YoutubeFailureImpl(this.failureData);

  @override
  final FailureData failureData;

  @override
  String toString() {
    return 'YoutubeFailure(failureData: $failureData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeFailureImpl &&
            (identical(other.failureData, failureData) ||
                other.failureData == failureData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failureData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeFailureImplCopyWith<_$YoutubeFailureImpl> get copyWith =>
      __$$YoutubeFailureImplCopyWithImpl<_$YoutubeFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureData failureData) $default, {
    required TResult Function(FailureData failureData) noConnection,
  }) {
    return $default(failureData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureData failureData)? $default, {
    TResult? Function(FailureData failureData)? noConnection,
  }) {
    return $default?.call(failureData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureData failureData)? $default, {
    TResult Function(FailureData failureData)? noConnection,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(failureData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_YoutubeFailure value) $default, {
    required TResult Function(NoConnectionFailure value) noConnection,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_YoutubeFailure value)? $default, {
    TResult? Function(NoConnectionFailure value)? noConnection,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_YoutubeFailure value)? $default, {
    TResult Function(NoConnectionFailure value)? noConnection,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _YoutubeFailure implements YoutubeFailure {
  const factory _YoutubeFailure(final FailureData failureData) =
      _$YoutubeFailureImpl;

  @override
  FailureData get failureData;
  @override
  @JsonKey(ignore: true)
  _$$YoutubeFailureImplCopyWith<_$YoutubeFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoConnectionFailureImplCopyWith<$Res>
    implements $YoutubeFailureCopyWith<$Res> {
  factory _$$NoConnectionFailureImplCopyWith(_$NoConnectionFailureImpl value,
          $Res Function(_$NoConnectionFailureImpl) then) =
      __$$NoConnectionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureData failureData});

  @override
  $FailureDataCopyWith<$Res> get failureData;
}

/// @nodoc
class __$$NoConnectionFailureImplCopyWithImpl<$Res>
    extends _$YoutubeFailureCopyWithImpl<$Res, _$NoConnectionFailureImpl>
    implements _$$NoConnectionFailureImplCopyWith<$Res> {
  __$$NoConnectionFailureImplCopyWithImpl(_$NoConnectionFailureImpl _value,
      $Res Function(_$NoConnectionFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failureData = null,
  }) {
    return _then(_$NoConnectionFailureImpl(
      failureData: null == failureData
          ? _value.failureData
          : failureData // ignore: cast_nullable_to_non_nullable
              as FailureData,
    ));
  }
}

/// @nodoc

class _$NoConnectionFailureImpl implements NoConnectionFailure {
  const _$NoConnectionFailureImpl(
      {this.failureData =
          const FailureData(code: 0, message: 'No internet connection')});

  @override
  @JsonKey()
  final FailureData failureData;

  @override
  String toString() {
    return 'YoutubeFailure.noConnection(failureData: $failureData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoConnectionFailureImpl &&
            (identical(other.failureData, failureData) ||
                other.failureData == failureData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failureData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoConnectionFailureImplCopyWith<_$NoConnectionFailureImpl> get copyWith =>
      __$$NoConnectionFailureImplCopyWithImpl<_$NoConnectionFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(FailureData failureData) $default, {
    required TResult Function(FailureData failureData) noConnection,
  }) {
    return noConnection(failureData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FailureData failureData)? $default, {
    TResult? Function(FailureData failureData)? noConnection,
  }) {
    return noConnection?.call(failureData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FailureData failureData)? $default, {
    TResult Function(FailureData failureData)? noConnection,
    required TResult orElse(),
  }) {
    if (noConnection != null) {
      return noConnection(failureData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_YoutubeFailure value) $default, {
    required TResult Function(NoConnectionFailure value) noConnection,
  }) {
    return noConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_YoutubeFailure value)? $default, {
    TResult? Function(NoConnectionFailure value)? noConnection,
  }) {
    return noConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_YoutubeFailure value)? $default, {
    TResult Function(NoConnectionFailure value)? noConnection,
    required TResult orElse(),
  }) {
    if (noConnection != null) {
      return noConnection(this);
    }
    return orElse();
  }
}

abstract class NoConnectionFailure implements YoutubeFailure {
  const factory NoConnectionFailure({final FailureData failureData}) =
      _$NoConnectionFailureImpl;

  @override
  FailureData get failureData;
  @override
  @JsonKey(ignore: true)
  _$$NoConnectionFailureImplCopyWith<_$NoConnectionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
