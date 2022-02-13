import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_pic/api/firebase/cloud_manager.dart';
import 'package:pick_pic/states/freezed/puzzle_list_state.dart';

final puzzleProvider =
    StateNotifierProvider<PuzzleListNotifier, PuzzleListState>((ref) {
  return PuzzleListNotifier();
});

/// manage puzzle list state
class PuzzleListNotifier extends StateNotifier<PuzzleListState> {
  static String tempID = '';

  PuzzleListNotifier() : super(PuzzleListState()) {
    _initList();
  }

  /// init puzzle list
  void _initList() async {
    // use default user & default path now
    final response =
        await CloudManager().getPuzzleFromCloud('images', 'user001');

    // ignore: unnecessary_null_comparison
    if (response == null) {
      state = state.copyWith(isLoading: false, isLoadMoreError: true);
      return;
    }

    if (response.docs.isEmpty) {
      state = state.copyWith(isLoading: false, isLoadMoreDone: true);
      return;
    }
    state = state.copyWith(isLoading: false, puzzles: response.docs);
  }

  /// load more data
  /// paging cloudFireStore data
  void loadMore() async {
    if (state.isLoading) {
      return;
    }

    final len = state.puzzles?.length;
    DocumentSnapshot last = state.copyWith().puzzles![len! - 1];

    if (tempID != last['upLoadTime'].toString()) {
      tempID = last['upLoadTime'].toString();
    } else {
      // state = state.copyWith(isLoading: false, isLoadMoreDone: true);
      // return;
    }
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);

    final response = await CloudManager()
        .getPuzzleFromCloud('images', 'user001', last: last);

    // ignore: unnecessary_null_comparison
    if (response == null) {
      state = state.copyWith(isLoading: false, isLoadMoreError: true);
      return;
    }

    if (response.docs.isNotEmpty) {
      state = state.copyWith(
          isLoading: false,
          isLoadMoreDone: response.docs.isEmpty,
          puzzles: [...?state.puzzles, ...response.docs]);
    } else {
      state = state.copyWith(
          isLoading: false, isLoadMoreDone: response.docs.isEmpty);
    }
  }

  Future<void> refresh() async {
    _initList();
  }
}
