// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'puzzle_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PuzzleListStateTearOff {
  const _$PuzzleListStateTearOff();

  _PuzzleListState call(
      {bool isLoading = true,
      bool isLoadMoreError = false,
      bool isLoadMoreDone = false,
      List<DocumentSnapshot<Object?>>? puzzles}) {
    return _PuzzleListState(
      isLoading: isLoading,
      isLoadMoreError: isLoadMoreError,
      isLoadMoreDone: isLoadMoreDone,
      puzzles: puzzles,
    );
  }
}

/// @nodoc
const $PuzzleListState = _$PuzzleListStateTearOff();

/// @nodoc
mixin _$PuzzleListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  bool get isLoadMoreDone => throw _privateConstructorUsedError;
  List<DocumentSnapshot<Object?>>? get puzzles =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PuzzleListStateCopyWith<PuzzleListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PuzzleListStateCopyWith<$Res> {
  factory $PuzzleListStateCopyWith(
          PuzzleListState value, $Res Function(PuzzleListState) then) =
      _$PuzzleListStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<DocumentSnapshot<Object?>>? puzzles});
}

/// @nodoc
class _$PuzzleListStateCopyWithImpl<$Res>
    implements $PuzzleListStateCopyWith<$Res> {
  _$PuzzleListStateCopyWithImpl(this._value, this._then);

  final PuzzleListState _value;
  // ignore: unused_field
  final $Res Function(PuzzleListState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
    Object? puzzles = freezed,
  }) {
    return _then(_value.copyWith(
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
      puzzles: puzzles == freezed
          ? _value.puzzles
          : puzzles // ignore: cast_nullable_to_non_nullable
              as List<DocumentSnapshot<Object?>>?,
    ));
  }
}

/// @nodoc
abstract class _$PuzzleListStateCopyWith<$Res>
    implements $PuzzleListStateCopyWith<$Res> {
  factory _$PuzzleListStateCopyWith(
          _PuzzleListState value, $Res Function(_PuzzleListState) then) =
      __$PuzzleListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<DocumentSnapshot<Object?>>? puzzles});
}

/// @nodoc
class __$PuzzleListStateCopyWithImpl<$Res>
    extends _$PuzzleListStateCopyWithImpl<$Res>
    implements _$PuzzleListStateCopyWith<$Res> {
  __$PuzzleListStateCopyWithImpl(
      _PuzzleListState _value, $Res Function(_PuzzleListState) _then)
      : super(_value, (v) => _then(v as _PuzzleListState));

  @override
  _PuzzleListState get _value => super._value as _PuzzleListState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
    Object? puzzles = freezed,
  }) {
    return _then(_PuzzleListState(
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
      puzzles: puzzles == freezed
          ? _value.puzzles
          : puzzles // ignore: cast_nullable_to_non_nullable
              as List<DocumentSnapshot<Object?>>?,
    ));
  }
}

/// @nodoc

class _$_PuzzleListState extends _PuzzleListState {
  const _$_PuzzleListState(
      {this.isLoading = true,
      this.isLoadMoreError = false,
      this.isLoadMoreDone = false,
      this.puzzles})
      : super._();

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
  final List<DocumentSnapshot<Object?>>? puzzles;

  @override
  String toString() {
    return 'PuzzleListState(isLoading: $isLoading, isLoadMoreError: $isLoadMoreError, isLoadMoreDone: $isLoadMoreDone, puzzles: $puzzles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PuzzleListState &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.isLoadMoreError, isLoadMoreError) ||
                const DeepCollectionEquality()
                    .equals(other.isLoadMoreError, isLoadMoreError)) &&
            (identical(other.isLoadMoreDone, isLoadMoreDone) ||
                const DeepCollectionEquality()
                    .equals(other.isLoadMoreDone, isLoadMoreDone)) &&
            (identical(other.puzzles, puzzles) ||
                const DeepCollectionEquality().equals(other.puzzles, puzzles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(isLoadMoreError) ^
      const DeepCollectionEquality().hash(isLoadMoreDone) ^
      const DeepCollectionEquality().hash(puzzles);

  @JsonKey(ignore: true)
  @override
  _$PuzzleListStateCopyWith<_PuzzleListState> get copyWith =>
      __$PuzzleListStateCopyWithImpl<_PuzzleListState>(this, _$identity);
}

abstract class _PuzzleListState extends PuzzleListState {
  const factory _PuzzleListState(
      {bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone,
      List<DocumentSnapshot<Object?>>? puzzles}) = _$_PuzzleListState;
  const _PuzzleListState._() : super._();

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  @override
  bool get isLoadMoreDone => throw _privateConstructorUsedError;
  @override
  List<DocumentSnapshot<Object?>>? get puzzles =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PuzzleListStateCopyWith<_PuzzleListState> get copyWith =>
      throw _privateConstructorUsedError;
}
