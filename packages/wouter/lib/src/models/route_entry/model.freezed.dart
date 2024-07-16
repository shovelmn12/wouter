// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RouteEntry<T> {
  String get path => throw _privateConstructorUsedError;
  ValueSetter<T> get onResult => throw _privateConstructorUsedError;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteEntryCopyWith<T, RouteEntry<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteEntryCopyWith<T, $Res> {
  factory $RouteEntryCopyWith(
          RouteEntry<T> value, $Res Function(RouteEntry<T>) then) =
      _$RouteEntryCopyWithImpl<T, $Res, RouteEntry<T>>;
  @useResult
  $Res call({String path, ValueSetter<T> onResult});
}

/// @nodoc
class _$RouteEntryCopyWithImpl<T, $Res, $Val extends RouteEntry<T>>
    implements $RouteEntryCopyWith<T, $Res> {
  _$RouteEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? onResult = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: null == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PathRouteEntryImplCopyWith<T, $Res>
    implements $RouteEntryCopyWith<T, $Res> {
  factory _$$PathRouteEntryImplCopyWith(_$PathRouteEntryImpl<T> value,
          $Res Function(_$PathRouteEntryImpl<T>) then) =
      __$$PathRouteEntryImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String path, ValueSetter<T> onResult});
}

/// @nodoc
class __$$PathRouteEntryImplCopyWithImpl<T, $Res>
    extends _$RouteEntryCopyWithImpl<T, $Res, _$PathRouteEntryImpl<T>>
    implements _$$PathRouteEntryImplCopyWith<T, $Res> {
  __$$PathRouteEntryImplCopyWithImpl(_$PathRouteEntryImpl<T> _value,
      $Res Function(_$PathRouteEntryImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? onResult = null,
  }) {
    return _then(_$PathRouteEntryImpl<T>(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: null == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>,
    ));
  }
}

/// @nodoc

class _$PathRouteEntryImpl<T>
    with DiagnosticableTreeMixin
    implements PathRouteEntry<T> {
  const _$PathRouteEntryImpl({required this.path, required this.onResult});

  @override
  final String path;
  @override
  final ValueSetter<T> onResult;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteEntry<$T>(path: $path, onResult: $onResult)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteEntry<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('onResult', onResult));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathRouteEntryImpl<T> &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathRouteEntryImplCopyWith<T, _$PathRouteEntryImpl<T>> get copyWith =>
      __$$PathRouteEntryImplCopyWithImpl<T, _$PathRouteEntryImpl<T>>(
          this, _$identity);
}

abstract class PathRouteEntry<T> implements RouteEntry<T> {
  const factory PathRouteEntry(
      {required final String path,
      required final ValueSetter<T> onResult}) = _$PathRouteEntryImpl<T>;

  @override
  String get path;
  @override
  ValueSetter<T> get onResult;

  /// Create a copy of RouteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathRouteEntryImplCopyWith<T, _$PathRouteEntryImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
