import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pick_pic/model/photo_entity.dart';

part 'photo_list_state.freezed.dart';

@freezed
class PhotoListState with _$PhotoListState {
  const factory PhotoListState({
    @Default(1) int page,
    @Default(10) int per_page,
    @Default('') String query,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
    List<PhotoEntity>? photos,
  }) = _PhotoListState;

  const PhotoListState._();
}
