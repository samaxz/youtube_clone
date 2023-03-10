import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_failure.freezed.dart';

@freezed
class FailureData with _$FailureData {
  const factory FailureData(
    String? message,
    int? code, {
    StackTrace? stackTrace,
  }) = _FailureData;
}

@freezed
class YoutubeFailure with _$YoutubeFailure {
  // * has to do with the youtube backend
  const factory YoutubeFailure(
    FailureData failureData,
  ) = _YoutubeFailure;

  // * has to do with the internet
  const factory YoutubeFailure.noConnection({
    @Default(FailureData('No internet connection', 000))
    FailureData failureData,
  }) = NoConnectionFailure;
}
