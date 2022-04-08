// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PairTearOff {
  const _$PairTearOff();

  _Pair<T, S> call<T, S>({required T item1, required S item2}) {
    return _Pair<T, S>(
      item1: item1,
      item2: item2,
    );
  }
}

/// @nodoc
const $Pair = _$PairTearOff();

/// @nodoc
mixin _$Pair<T, S> {
  T get item1 => throw _privateConstructorUsedError;
  S get item2 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PairCopyWith<T, S, Pair<T, S>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairCopyWith<T, S, $Res> {
  factory $PairCopyWith(Pair<T, S> value, $Res Function(Pair<T, S>) then) =
      _$PairCopyWithImpl<T, S, $Res>;
  $Res call({T item1, S item2});
}

/// @nodoc
class _$PairCopyWithImpl<T, S, $Res> implements $PairCopyWith<T, S, $Res> {
  _$PairCopyWithImpl(this._value, this._then);

  final Pair<T, S> _value;
  // ignore: unused_field
  final $Res Function(Pair<T, S>) _then;

  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
  }) {
    return _then(_value.copyWith(
      item1: item1 == freezed
          ? _value.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T,
      item2: item2 == freezed
          ? _value.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as S,
    ));
  }
}

/// @nodoc
abstract class _$PairCopyWith<T, S, $Res> implements $PairCopyWith<T, S, $Res> {
  factory _$PairCopyWith(_Pair<T, S> value, $Res Function(_Pair<T, S>) then) =
      __$PairCopyWithImpl<T, S, $Res>;
  @override
  $Res call({T item1, S item2});
}

/// @nodoc
class __$PairCopyWithImpl<T, S, $Res> extends _$PairCopyWithImpl<T, S, $Res>
    implements _$PairCopyWith<T, S, $Res> {
  __$PairCopyWithImpl(_Pair<T, S> _value, $Res Function(_Pair<T, S>) _then)
      : super(_value, (v) => _then(v as _Pair<T, S>));

  @override
  _Pair<T, S> get _value => super._value as _Pair<T, S>;

  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
  }) {
    return _then(_Pair<T, S>(
      item1: item1 == freezed
          ? _value.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T,
      item2: item2 == freezed
          ? _value.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as S,
    ));
  }
}

/// @nodoc

class _$_Pair<T, S> with DiagnosticableTreeMixin implements _Pair<T, S> {
  const _$_Pair({required this.item1, required this.item2});

  @override
  final T item1;
  @override
  final S item2;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Pair<$T, $S>(item1: $item1, item2: $item2)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Pair<$T, $S>'))
      ..add(DiagnosticsProperty('item1', item1))
      ..add(DiagnosticsProperty('item2', item2));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Pair<T, S> &&
            const DeepCollectionEquality().equals(other.item1, item1) &&
            const DeepCollectionEquality().equals(other.item2, item2));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(item1),
      const DeepCollectionEquality().hash(item2));

  @JsonKey(ignore: true)
  @override
  _$PairCopyWith<T, S, _Pair<T, S>> get copyWith =>
      __$PairCopyWithImpl<T, S, _Pair<T, S>>(this, _$identity);
}

abstract class _Pair<T, S> implements Pair<T, S> {
  const factory _Pair({required T item1, required S item2}) = _$_Pair<T, S>;

  @override
  T get item1;
  @override
  S get item2;
  @override
  @JsonKey(ignore: true)
  _$PairCopyWith<T, S, _Pair<T, S>> get copyWith =>
      throw _privateConstructorUsedError;
}
