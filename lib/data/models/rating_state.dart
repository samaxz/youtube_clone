import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_state.freezed.dart';

@freezed
class RatingState with _$RatingState {
  const RatingState._();

  const factory RatingState.neither() = Neither;
  const factory RatingState.liked() = Liked;
  const factory RatingState.disliked() = Disliked;
}
