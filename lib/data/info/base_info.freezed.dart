// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseInfo<T> {
  List<T> get data => throw _privateConstructorUsedError;
  String? get nextPageToken => throw _privateConstructorUsedError;
  bool get nextPageAvailable => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get itemsPerPage => throw _privateConstructorUsedError;
  bool? get disabled => throw _privateConstructorUsedError;
  FailureData? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BaseInfoCopyWith<T, BaseInfo<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseInfoCopyWith<T, $Res> {
  factory $BaseInfoCopyWith(
          BaseInfo<T> value, $Res Function(BaseInfo<T>) then) =
      _$BaseInfoCopyWithImpl<T, $Res, BaseInfo<T>>;
  @useResult
  $Res call(
      {List<T> data,
      String? nextPageToken,
      bool nextPageAvailable,
      int totalPages,
      int itemsPerPage,
      bool? disabled,
      FailureData? failure});

  $FailureDataCopyWith<$Res>? get failure;
}

/// @nodoc
class _$BaseInfoCopyWithImpl<T, $Res, $Val extends BaseInfo<T>>
    implements $BaseInfoCopyWith<T, $Res> {
  _$BaseInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? nextPageToken = freezed,
    Object? nextPageAvailable = null,
    Object? totalPages = null,
    Object? itemsPerPage = null,
    Object? disabled = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      nextPageToken: freezed == nextPageToken
          ? _value.nextPageToken
          : nextPageToken // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPageAvailable: null == nextPageAvailable
          ? _value.nextPageAvailable
          : nextPageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPerPage: null == itemsPerPage
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      disabled: freezed == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as FailureData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureDataCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureDataCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BaseInfoImplCopyWith<T, $Res>
    implements $BaseInfoCopyWith<T, $Res> {
  factory _$$BaseInfoImplCopyWith(
          _$BaseInfoImpl<T> value, $Res Function(_$BaseInfoImpl<T>) then) =
      __$$BaseInfoImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> data,
      String? nextPageToken,
      bool nextPageAvailable,
      int totalPages,
      int itemsPerPage,
      bool? disabled,
      FailureData? failure});

  @override
  $FailureDataCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$BaseInfoImplCopyWithImpl<T, $Res>
    extends _$BaseInfoCopyWithImpl<T, $Res, _$BaseInfoImpl<T>>
    implements _$$BaseInfoImplCopyWith<T, $Res> {
  __$$BaseInfoImplCopyWithImpl(
      _$BaseInfoImpl<T> _value, $Res Function(_$BaseInfoImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? nextPageToken = freezed,
    Object? nextPageAvailable = null,
    Object? totalPages = null,
    Object? itemsPerPage = null,
    Object? disabled = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$BaseInfoImpl<T>(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      nextPageToken: freezed == nextPageToken
          ? _value.nextPageToken
          : nextPageToken // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPageAvailable: null == nextPageAvailable
          ? _value.nextPageAvailable
          : nextPageAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPerPage: null == itemsPerPage
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      disabled: freezed == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as FailureData?,
    ));
  }
}

/// @nodoc

class _$BaseInfoImpl<T> implements _BaseInfo<T> {
  const _$BaseInfoImpl(
      {final List<T> data = const [],
      this.nextPageToken = '',
      this.nextPageAvailable = false,
      this.totalPages = 0,
      this.itemsPerPage = 0,
      this.disabled,
      this.failure})
      : _data = data;

  final List<T> _data;
  @override
  @JsonKey()
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final String? nextPageToken;
  @override
  @JsonKey()
  final bool nextPageAvailable;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int itemsPerPage;
  @override
  final bool? disabled;
  @override
  final FailureData? failure;

  @override
  String toString() {
    return 'BaseInfo<$T>(data: $data, nextPageToken: $nextPageToken, nextPageAvailable: $nextPageAvailable, totalPages: $totalPages, itemsPerPage: $itemsPerPage, disabled: $disabled, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.nextPageToken, nextPageToken) ||
                other.nextPageToken == nextPageToken) &&
            (identical(other.nextPageAvailable, nextPageAvailable) ||
                other.nextPageAvailable == nextPageAvailable) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.itemsPerPage, itemsPerPage) ||
                other.itemsPerPage == itemsPerPage) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      nextPageToken,
      nextPageAvailable,
      totalPages,
      itemsPerPage,
      disabled,
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoImplCopyWith<T, _$BaseInfoImpl<T>> get copyWith =>
      __$$BaseInfoImplCopyWithImpl<T, _$BaseInfoImpl<T>>(this, _$identity);
}

abstract class _BaseInfo<T> implements BaseInfo<T> {
  const factory _BaseInfo(
      {final List<T> data,
      final String? nextPageToken,
      final bool nextPageAvailable,
      final int totalPages,
      final int itemsPerPage,
      final bool? disabled,
      final FailureData? failure}) = _$BaseInfoImpl<T>;

  @override
  List<T> get data;
  @override
  String? get nextPageToken;
  @override
  bool get nextPageAvailable;
  @override
  int get totalPages;
  @override
  int get itemsPerPage;
  @override
  bool? get disabled;
  @override
  FailureData? get failure;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoImplCopyWith<T, _$BaseInfoImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
