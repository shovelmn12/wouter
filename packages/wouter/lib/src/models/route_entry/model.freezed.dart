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
mixin _$RouteEntry {
  String get path;
  RouteResultCallback get onResult;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteEntryCopyWith<RouteEntry> get copyWith =>
      _$RouteEntryCopyWithImpl<RouteEntry>(this as RouteEntry, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteEntry &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @override
  String toString() {
    return 'RouteEntry(path: $path, onResult: $onResult)';
  }
}

/// @nodoc
abstract mixin class $RouteEntryCopyWith<$Res> {
  factory $RouteEntryCopyWith(
          RouteEntry value, $Res Function(RouteEntry) _then) =
      _$RouteEntryCopyWithImpl;
  @useResult
  $Res call({String path, RouteResultCallback onResult});
}

/// @nodoc
class _$RouteEntryCopyWithImpl<$Res> implements $RouteEntryCopyWith<$Res> {
  _$RouteEntryCopyWithImpl(this._self, this._then);

  final RouteEntry _self;
  final $Res Function(RouteEntry) _then;

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
              as RouteResultCallback,
    ));
  }
}

/// @nodoc

class PathRouteEntry implements RouteEntry {
  const PathRouteEntry({required this.path, required this.onResult});

  @override
  final String path;
  @override
  final RouteResultCallback onResult;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PathRouteEntryCopyWith<PathRouteEntry> get copyWith =>
      _$PathRouteEntryCopyWithImpl<PathRouteEntry>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PathRouteEntry &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @override
  String toString() {
    return 'RouteEntry(path: $path, onResult: $onResult)';
  }
}

/// @nodoc
abstract mixin class $PathRouteEntryCopyWith<$Res>
    implements $RouteEntryCopyWith<$Res> {
  factory $PathRouteEntryCopyWith(
          PathRouteEntry value, $Res Function(PathRouteEntry) _then) =
      _$PathRouteEntryCopyWithImpl;
  @override
  @useResult
  $Res call({String path, RouteResultCallback onResult});
}

/// @nodoc
class _$PathRouteEntryCopyWithImpl<$Res>
    implements $PathRouteEntryCopyWith<$Res> {
  _$PathRouteEntryCopyWithImpl(this._self, this._then);

  final PathRouteEntry _self;
  final $Res Function(PathRouteEntry) _then;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? onResult = null,
  }) {
    return _then(PathRouteEntry(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: null == onResult
          ? _self.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as RouteResultCallback,
    ));
  }
}

// dart format on
