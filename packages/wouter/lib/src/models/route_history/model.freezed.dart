// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RouteHistoryTearOff {
  const _$RouteHistoryTearOff();

  _RouteHistory<T> call<T>({required String path, void Function(T)? onResult}) {
    return _RouteHistory<T>(
      path: path,
      onResult: onResult,
    );
  }
}

/// @nodoc
const $RouteHistory = _$RouteHistoryTearOff();

/// @nodoc
mixin _$RouteHistory<T> {
  String get path => throw _privateConstructorUsedError;
  void Function(T)? get onResult => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RouteHistoryCopyWith<T, RouteHistory<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteHistoryCopyWith<T, $Res> {
  factory $RouteHistoryCopyWith(
          RouteHistory<T> value, $Res Function(RouteHistory<T>) then) =
      _$RouteHistoryCopyWithImpl<T, $Res>;
  $Res call({String path, void Function(T)? onResult});
}

/// @nodoc
class _$RouteHistoryCopyWithImpl<T, $Res>
    implements $RouteHistoryCopyWith<T, $Res> {
  _$RouteHistoryCopyWithImpl(this._value, this._then);

  final RouteHistory<T> _value;
  // ignore: unused_field
  final $Res Function(RouteHistory<T>) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? onResult = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: onResult == freezed
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as void Function(T)?,
    ));
  }
}

/// @nodoc
abstract class _$RouteHistoryCopyWith<T, $Res>
    implements $RouteHistoryCopyWith<T, $Res> {
  factory _$RouteHistoryCopyWith(
          _RouteHistory<T> value, $Res Function(_RouteHistory<T>) then) =
      __$RouteHistoryCopyWithImpl<T, $Res>;
  @override
  $Res call({String path, void Function(T)? onResult});
}

/// @nodoc
class __$RouteHistoryCopyWithImpl<T, $Res>
    extends _$RouteHistoryCopyWithImpl<T, $Res>
    implements _$RouteHistoryCopyWith<T, $Res> {
  __$RouteHistoryCopyWithImpl(
      _RouteHistory<T> _value, $Res Function(_RouteHistory<T>) _then)
      : super(_value, (v) => _then(v as _RouteHistory<T>));

  @override
  _RouteHistory<T> get _value => super._value as _RouteHistory<T>;

  @override
  $Res call({
    Object? path = freezed,
    Object? onResult = freezed,
  }) {
    return _then(_RouteHistory<T>(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: onResult == freezed
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as void Function(T)?,
    ));
  }
}

/// @nodoc

class _$_RouteHistory<T>
    with DiagnosticableTreeMixin
    implements _RouteHistory<T> {
  const _$_RouteHistory({required this.path, this.onResult});

  @override
  final String path;
  @override
  final void Function(T)? onResult;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteHistory<$T>(path: $path, onResult: $onResult)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteHistory<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('onResult', onResult));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteHistory<T> &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @JsonKey(ignore: true)
  @override
  _$RouteHistoryCopyWith<T, _RouteHistory<T>> get copyWith =>
      __$RouteHistoryCopyWithImpl<T, _RouteHistory<T>>(this, _$identity);
}

abstract class _RouteHistory<T> implements RouteHistory<T> {
  const factory _RouteHistory(
      {required String path, void Function(T)? onResult}) = _$_RouteHistory<T>;

  @override
  String get path;
  @override
  void Function(T)? get onResult;
  @override
  @JsonKey(ignore: true)
  _$RouteHistoryCopyWith<T, _RouteHistory<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
