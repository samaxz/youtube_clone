import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_failure.freezed.dart';

// TODO get rid of this in the future
@freezed
class FailureData with _$FailureData {
  const factory FailureData({
    required int? code,
    required String? message,
    StackTrace? stackTrace,
  }) = _FailureData;
}

@freezed
class YoutubeFailure with _$YoutubeFailure {
  // problem with the youtube backend
  const factory YoutubeFailure(FailureData failureData) = _YoutubeFailure;

  // problem with the internet
  const factory YoutubeFailure.noConnection({
    @Default(FailureData(code: 0, message: 'No internet connection')) FailureData failureData,
  }) = NoConnectionFailure;
}
