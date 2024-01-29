// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function(AuthFailure authFailure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function(AuthFailure authFailure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function(AuthFailure authFailure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(FailureAuthState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(FailureAuthState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(FailureAuthState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl extends Initial {
  const _$InitialImpl() : super._();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function(AuthFailure authFailure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function(AuthFailure authFailure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function(AuthFailure authFailure)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(FailureAuthState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(FailureAuthState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(FailureAuthState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial extends AuthState {
  const factory Initial() = _$InitialImpl;
  const Initial._() : super._();
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnauthenticatedImpl extends Unauthenticated {
  const _$UnauthenticatedImpl() : super._();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function(AuthFailure authFailure) failure,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function(AuthFailure authFailure)? failure,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function(AuthFailure authFailure)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(FailureAuthState value) failure,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(FailureAuthState value)? failure,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(FailureAuthState value)? failure,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class Unauthenticated extends AuthState {
  const factory Unauthenticated() = _$UnauthenticatedImpl;
  const Unauthenticated._() : super._();
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatedImpl extends Authenticated {
  const _$AuthenticatedImpl() : super._();

  @override
  String toString() {
    return 'AuthState.authenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function(AuthFailure authFailure) failure,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function(AuthFailure authFailure)? failure,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function(AuthFailure authFailure)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(FailureAuthState value) failure,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(FailureAuthState value)? failure,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(FailureAuthState value)? failure,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated extends AuthState {
  const factory Authenticated() = _$AuthenticatedImpl;
  const Authenticated._() : super._();
}

/// @nodoc
abstract class _$$FailureAuthStateImplCopyWith<$Res> {
  factory _$$FailureAuthStateImplCopyWith(_$FailureAuthStateImpl value,
          $Res Function(_$FailureAuthStateImpl) then) =
      __$$FailureAuthStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthFailure authFailure});

  $AuthFailureCopyWith<$Res> get authFailure;
}

/// @nodoc
class __$$FailureAuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$FailureAuthStateImpl>
    implements _$$FailureAuthStateImplCopyWith<$Res> {
  __$$FailureAuthStateImplCopyWithImpl(_$FailureAuthStateImpl _value,
      $Res Function(_$FailureAuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authFailure = null,
  }) {
    return _then(_$FailureAuthStateImpl(
      null == authFailure
          ? _value.authFailure
          : authFailure // ignore: cast_nullable_to_non_nullable
              as AuthFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthFailureCopyWith<$Res> get authFailure {
    return $AuthFailureCopyWith<$Res>(_value.authFailure, (value) {
      return _then(_value.copyWith(authFailure: value));
    });
  }
}

/// @nodoc

class _$FailureAuthStateImpl extends FailureAuthState {
  const _$FailureAuthStateImpl(this.authFailure) : super._();

  @override
  final AuthFailure authFailure;

  @override
  String toString() {
    return 'AuthState.failure(authFailure: $authFailure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureAuthStateImpl &&
            (identical(other.authFailure, authFailure) ||
                other.authFailure == authFailure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authFailure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureAuthStateImplCopyWith<_$FailureAuthStateImpl> get copyWith =>
      __$$FailureAuthStateImplCopyWithImpl<_$FailureAuthStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function(AuthFailure authFailure) failure,
  }) {
    return failure(authFailure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function(AuthFailure authFailure)? failure,
  }) {
    return failure?.call(authFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function(AuthFailure authFailure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(authFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(FailureAuthState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(FailureAuthState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(FailureAuthState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureAuthState extends AuthState {
  const factory FailureAuthState(final AuthFailure authFailure) =
      _$FailureAuthStateImpl;
  const FailureAuthState._() : super._();

  AuthFailure get authFailure;
  @JsonKey(ignore: true)
  _$$FailureAuthStateImplCopyWith<_$FailureAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
