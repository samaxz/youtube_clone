import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_demo/services/common/helper_class.dart';

part 'common_classes.freezed.dart';

// * displaying different options for different widgets when clicking
// on the 3 dot more vert icon
@freezed
class ShowOptions with _$ShowOptions {
  const factory ShowOptions.neither() = Neither;
  // TODO delete unused params
  const factory ShowOptions.video({
    required String videoId,
    required ScreenActions screenActions,
    required int videoCardIndex,
  }) = VideoOptions;
  const factory ShowOptions.channel() = ChannelOptions;
}

class ScreenIdAndActions {
  final String? id;
  final ScreenActions actions;

  const ScreenIdAndActions({this.id, required this.actions});
}
