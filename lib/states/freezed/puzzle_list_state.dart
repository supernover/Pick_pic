import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'puzzle_list_state.freezed.dart';

@freezed
class PuzzleListState with _$PuzzleListState {
  const factory PuzzleListState({
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
     List<DocumentSnapshot>? puzzles,
  }) = _PuzzleListState;

  const PuzzleListState._();
}
