// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteEntry<T> implements DiagnosticableTreeMixin {
  String get path;
  ValueSetter<T> get onResult;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteEntryCopyWith<T, RouteEntry<T>> get copyWith =>
      _$RouteEntryCopyWithImpl<T, RouteEntry<T>>(
          this as RouteEntry<T>, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'RouteEntry<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('onResult', onResult));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteEntry<T> &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteEntry<$T>(path: $path, onResult: $onResult)';
  }
}

/// @nodoc
abstract mixin class $RouteEntryCopyWith<T, $Res> {
  factory $RouteEntryCopyWith(
          RouteEntry<T> value, $Res Function(RouteEntry<T>) _then) =
      _$RouteEntryCopyWithImpl;
  @useResult
  $Res call({String path, ValueSetter<T> onResult});
}

/// @nodoc
class _$RouteEntryCopyWithImpl<T, $Res>
    implements $RouteEntryCopyWith<T, $Res> {
  _$RouteEntryCopyWithImpl(this._self, this._then);

  final RouteEntry<T> _self;
  final $Res Function(RouteEntry<T>) _then;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? onResult = null,
  }) {
    return _then(_self.copyWith(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: null == onResult
          ? _self.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>,
    ));
  }
}

/// @nodoc

class PathRouteEntry<T> with DiagnosticableTreeMixin implements RouteEntry<T> {
  const PathRouteEntry({required this.path, required this.onResult});

  @override
  final String path;
  @override
  final ValueSetter<T> onResult;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PathRouteEntryCopyWith<T, PathRouteEntry<T>> get copyWith =>
      _$PathRouteEntryCopyWithImpl<T, PathRouteEntry<T>>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'RouteEntry<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('onResult', onResult));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PathRouteEntry<T> &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteEntry<$T>(path: $path, onResult: $onResult)';
  }
}

/// @nodoc
abstract mixin class $PathRouteEntryCopyWith<T, $Res>
    implements $RouteEntryCopyWith<T, $Res> {
  factory $PathRouteEntryCopyWith(
          PathRouteEntry<T> value, $Res Function(PathRouteEntry<T>) _then) =
      _$PathRouteEntryCopyWithImpl;
  @override
  @useResult
  $Res call({String path, ValueSetter<T> onResult});
}

/// @nodoc
class _$PathRouteEntryCopyWithImpl<T, $Res>
    implements $PathRouteEntryCopyWith<T, $Res> {
  _$PathRouteEntryCopyWithImpl(this._self, this._then);

  final PathRouteEntry<T> _self;
  final $Res Function(PathRouteEntry<T>) _then;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? onResult = null,
  }) {
    return _then(PathRouteEntry<T>(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: null == onResult
          ? _self.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>,
    ));
  }
}

// dart format on
