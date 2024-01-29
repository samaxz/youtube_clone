import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_clone/data/info/youtube_failure.dart';

part 'base_info.freezed.dart';

// this class stores data for different models
@freezed
class BaseInfo<T> with _$BaseInfo<T> {
  const factory BaseInfo({
    @Default([]) List<T> data,
    @Default('') String? nextPageToken,
    @Default(false) bool nextPageAvailable,
    @Default(0) int totalPages,
    @Default(0) int itemsPerPage,
    bool? disabled,
    FailureData? failure,
  }) = _BaseInfo<T>;
}
