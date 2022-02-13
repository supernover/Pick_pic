import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_pic/api/photo_responsibility.dart';
import 'package:pick_pic/states/freezed/photo_list_state.dart';

final photoProvider =
    StateNotifierProvider<PhotoListNotifier, PhotoListState>((ref) {
  return PhotoListNotifier();
});

/// manage image list state
class PhotoListNotifier extends StateNotifier<PhotoListState> {
  PhotoListNotifier() : super(PhotoListState()) {
    _initList(query: '');
  }

  void _initList({int? initPage, required String query}) async {
    final page = initPage ?? state.page;
    final photos =
        await PhotoResponsibility().searchPhotos(page: page, query: query);

    // ignore: unnecessary_null_comparison
    if (photos == null) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }
    state = state.copyWith(
        page: page, isLoading: false, photos: photos, query: query);
  }

  /// load more data
  void loadMore() async {
    if (state.isLoading) {
      return;
    }
    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);

    final photos = await PhotoResponsibility()
        .searchPhotos(page: state.page + 1, query: state.query);

    // ignore: unnecessary_null_comparison
    if (photos == null) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    if (photos.isNotEmpty) {
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: photos.isEmpty,
          photos: [...?state.photos, ...photos]);
    } else {
      state = state.copyWith(isLoading: false, isLoadMoreDone: photos.isEmpty);
    }
  }

  Future<void> refresh(String query) async {
    _initList(initPage: 1, query: query);
  }
}
