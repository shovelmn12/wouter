// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

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

  _RouteHistory<T> call<T>(
      {required String path,
      required List<String> stack,
      void Function(T)? onResult}) {
    return _RouteHistory<T>(
      path: path,
      stack: stack,
      onResult: onResult,
    );
  }
}

/// @nodoc
const $RouteHistory = _$RouteHistoryTearOff();

/// @nodoc
mixin _$RouteHistory<T> {
  String get path => throw _privateConstructorUsedError;
  List<String> get stack => throw _privateConstructorUsedError;
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
  $Res call({String path, List<String> stack, void Function(T)? onResult});
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
    Object? stack = freezed,
    Object? onResult = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      stack: stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
  $Res call({String path, List<String> stack, void Function(T)? onResult});
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
    Object? stack = freezed,
    Object? onResult = freezed,
  }) {
    return _then(_RouteHistory<T>(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      stack: stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
  const _$_RouteHistory(
      {required this.path, required this.stack, this.onResult});

  @override
  final String path;
  @override
  final List<String> stack;
  @override
  final void Function(T)? onResult;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteHistory<$T>(path: $path, stack: $stack, onResult: $onResult)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteHistory<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('stack', stack))
      ..add(DiagnosticsProperty('onResult', onResult));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RouteHistory<T> &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.stack, stack) ||
                const DeepCollectionEquality().equals(other.stack, stack)) &&
            (identical(other.onResult, onResult) ||
                const DeepCollectionEquality()
                    .equals(other.onResult, onResult)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(stack) ^
      const DeepCollectionEquality().hash(onResult);

  @JsonKey(ignore: true)
  @override
  _$RouteHistoryCopyWith<T, _RouteHistory<T>> get copyWith =>
      __$RouteHistoryCopyWithImpl<T, _RouteHistory<T>>(this, _$identity);
}

abstract class _RouteHistory<T> implements RouteHistory<T> {
  const factory _RouteHistory(
      {required String path,
      required List<String> stack,
      void Function(T)? onResult}) = _$_RouteHistory<T>;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  List<String> get stack => throw _privateConstructorUsedError;
  @override
  void Function(T)? get onResult => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RouteHistoryCopyWith<T, _RouteHistory<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
