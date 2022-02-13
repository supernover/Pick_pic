// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'photo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PhotoListStateTearOff {
  const _$PhotoListStateTearOff();

  _PhotoListState call(
      {int page = 1,
      int per_page = 10,
      String query = '',
      bool isLoading = true,
      bool isLoadMoreError = false,
      bool isLoadMoreDone = false,
      List<PhotoEntity>? photos}) {
    return _PhotoListState(
      page: page,
      per_page: per_page,
      query: query,
      isLoading: isLoading,
      isLoadMoreError: isLoadMoreError,
      isLoadMoreDone: isLoadMoreDone,
      photos: photos,
    );
  }
}

/// @nodoc
const $PhotoListState = _$PhotoListStateTearOff();

/// @nodoc
mixin _$PhotoListState {
  int get page => throw _privateConstructorUsedError;
  int get per_page => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  bool get isLoadMoreDone => throw _privateConstructorUsedError;
  List<PhotoEntity>? get photos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoListStateCopyWith<PhotoListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoListStateCopyWith<$Res> {
  factory $PhotoListStateCopyWith(
          PhotoListState value, $Res Function(PhotoListState) then) =
      _$PhotoListStateCopyWithImpl<$Res>;
  $Res call(
      {int page,
      int per_page,
      String query,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<PhotoEntity>? photos});
}

/// @nodoc
class _$PhotoListStateCopyWithImpl<$Res>
    implements $PhotoListStateCopyWith<$Res> {
  _$PhotoListStateCopyWithImpl(this._value, this._then);

  final PhotoListState _value;
  // ignore: unused_field
  final $Res Function(PhotoListState) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? per_page = freezed,
    Object? query = freezed,
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
    Object? photos = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      per_page: per_page == freezed
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int,
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: isLoadMoreError == freezed
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: isLoadMoreDone == freezed
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
      photos: photos == freezed
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoEntity>?,
    ));
  }
}

/// @nodoc
abstract class _$PhotoListStateCopyWith<$Res>
    implements $PhotoListStateCopyWith<$Res> {
  factory _$PhotoListStateCopyWith(
          _PhotoListState value, $Res Function(_PhotoListState) then) =
      __$PhotoListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int page,
      int per_page,
      String query,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<PhotoEntity>? photos});
}

/// @nodoc
class __$PhotoListStateCopyWithImpl<$Res>
    extends _$PhotoListStateCopyWithImpl<$Res>
    implements _$PhotoListStateCopyWith<$Res> {
  __$PhotoListStateCopyWithImpl(
      _PhotoListState _value, $Res Function(_PhotoListState) _then)
      : super(_value, (v) => _then(v as _PhotoListState));

  @override
  _PhotoListState get _value => super._value as _PhotoListState;

  @override
  $Res call({
    Object? page = freezed,
    Object? per_page = freezed,
    Object? query = freezed,
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
    Object? photos = freezed,
  }) {
    return _then(_PhotoListState(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      per_page: per_page == freezed
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int,
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: isLoadMoreError == freezed
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: isLoadMoreDone == freezed
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
      photos: photos == freezed
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoEntity>?,
    ));
  }
}

/// @nodoc

class _$_PhotoListState extends _PhotoListState {
  const _$_PhotoListState(
      {this.page = 1,
      this.per_page = 10,
      this.query = '',
      this.isLoading = true,
      this.isLoadMoreError = false,
      this.isLoadMoreDone = false,
      this.photos})
      : super._();

  @JsonKey(defaultValue: 1)
  @override
  final int page;
  @JsonKey(defaultValue: 10)
  @override
  final int per_page;
  @JsonKey(defaultValue: '')
  @override
  final String query;
  @JsonKey(defaultValue: true)
  @override
  final bool isLoading;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoadMoreError;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoadMoreDone;
  @override
  final List<PhotoEntity>? photos;

  @override
  String toString() {
    return 'PhotoListState(page: $page, per_page: $per_page, query: $query, isLoading: $isLoading, isLoadMoreError: $isLoadMoreError, isLoadMoreDone: $isLoadMoreDone, photos: $photos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PhotoListState &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.per_page, per_page) ||
                const DeepCollectionEquality()
                    .equals(other.per_page, per_page)) &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.isLoadMoreError, isLoadMoreError) ||
                const DeepCollectionEquality()
                    .equals(other.isLoadMoreError, isLoadMoreError)) &&
            (identical(other.isLoadMoreDone, isLoadMoreDone) ||
                const DeepCollectionEquality()
                    .equals(other.isLoadMoreDone, isLoadMoreDone)) &&
            (identical(other.photos, photos) ||
                const DeepCollectionEquality().equals(other.photos, photos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(per_page) ^
      const DeepCollectionEquality().hash(query) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(isLoadMoreError) ^
      const DeepCollectionEquality().hash(isLoadMoreDone) ^
      const DeepCollectionEquality().hash(photos);

  @JsonKey(ignore: true)
  @override
  _$PhotoListStateCopyWith<_PhotoListState> get copyWith =>
      __$PhotoListStateCopyWithImpl<_PhotoListState>(this, _$identity);
}

abstract class _PhotoListState extends PhotoListState {
  const factory _PhotoListState(
      {int page,
      int per_page,
      String query,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<PhotoEntity>? photos}) = _$_PhotoListState;
  const _PhotoListState._() : super._();

  @override
  int get page => throw _privateConstructorUsedError;
  @override
  int get per_page => throw _privateConstructorUsedError;
  @override
  String get query => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  @override
  bool get isLoadMoreDone => throw _privateConstructorUsedError;
  @override
  List<PhotoEntity>? get photos => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PhotoListStateCopyWith<_PhotoListState> get copyWith =>
      throw _privateConstructorUsedError;
}
