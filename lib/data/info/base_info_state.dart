import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_demo/data/info/base_info.dart';
import 'package:youtube_demo/data/info/youtube_failure.dart';

part 'base_info_state.freezed.dart';

@freezed
class BaseInfoState<T> with _$BaseInfoState<T> {
  const BaseInfoState._();

  const factory BaseInfoState.loading({
    @Default(BaseInfo()) BaseInfo<T> baseInfo,
  }) = BaseInfoLoading<T>;

  const factory BaseInfoState.loaded(BaseInfo<T> baseInfo) = BaseInfoLoaded<T>;

  const factory BaseInfoState.error({
    required BaseInfo<T> baseInfo,
    required YoutubeFailure failure,
  }) = BaseInfoError<T>;
}
