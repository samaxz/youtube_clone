// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConnectivityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? offline,
    TResult? Function()? online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Offline value) offline,
    required TResult Function(Online value) online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Offline value)? offline,
    TResult? Function(Online value)? online,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Offline value)? offline,
    TResult Function(Online value)? online,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectivityStateCopyWith<$Res> {
  factory $ConnectivityStateCopyWith(
          ConnectivityState value, $Res Function(ConnectivityState) then) =
      _$ConnectivityStateCopyWithImpl<$Res, ConnectivityState>;
}

/// @nodoc
class _$ConnectivityStateCopyWithImpl<$Res, $Val extends ConnectivityState>
    implements $ConnectivityStateCopyWith<$Res> {
  _$ConnectivityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OfflineImplCopyWith<$Res> {
  factory _$$OfflineImplCopyWith(
          _$OfflineImpl value, $Res Function(_$OfflineImpl) then) =
      __$$OfflineImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OfflineImplCopyWithImpl<$Res>
    extends _$ConnectivityStateCopyWithImpl<$Res, _$OfflineImpl>
    implements _$$OfflineImplCopyWith<$Res> {
  __$$OfflineImplCopyWithImpl(
      _$OfflineImpl _value, $Res Function(_$OfflineImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OfflineImpl extends Offline {
  const _$OfflineImpl() : super._();

  @override
  String toString() {
    return 'ConnectivityState.offline()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OfflineImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) {
    return offline();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? offline,
    TResult? Function()? online,
  }) {
    return offline?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Offline value) offline,
    required TResult Function(Online value) online,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Offline value)? offline,
    TResult? Function(Online value)? online,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Offline value)? offline,
    TResult Function(Online value)? online,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class Offline extends ConnectivityState {
  const factory Offline() = _$OfflineImpl;
  const Offline._() : super._();
}

/// @nodoc
abstract class _$$OnlineImplCopyWith<$Res> {
  factory _$$OnlineImplCopyWith(
          _$OnlineImpl value, $Res Function(_$OnlineImpl) then) =
      __$$OnlineImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnlineImplCopyWithImpl<$Res>
    extends _$ConnectivityStateCopyWithImpl<$Res, _$OnlineImpl>
    implements _$$OnlineImplCopyWith<$Res> {
  __$$OnlineImplCopyWithImpl(
      _$OnlineImpl _value, $Res Function(_$OnlineImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OnlineImpl extends Online {
  const _$OnlineImpl() : super._();

  @override
  String toString() {
    return 'ConnectivityState.online()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnlineImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() offline,
    required TResult Function() online,
  }) {
    return online();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? offline,
    TResult? Function()? online,
  }) {
    return online?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? offline,
    TResult Function()? online,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Offline value) offline,
    required TResult Function(Online value) online,
  }) {
    return online(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Offline value)? offline,
    TResult? Function(Online value)? online,
  }) {
    return online?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Offline value)? offline,
    TResult Function(Online value)? online,
    required TResult orElse(),
  }) {
    if (online != null) {
      return online(this);
    }
    return orElse();
  }
}

abstract class Online extends ConnectivityState {
  const factory Online() = _$OnlineImpl;
  const Online._() : super._();
}
