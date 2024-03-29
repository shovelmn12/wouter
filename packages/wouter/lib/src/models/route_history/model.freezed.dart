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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RouteEntry<T> {
  String get path => throw _privateConstructorUsedError;
  ValueSetter<T>? get onResult => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RouteEntryCopyWith<T, RouteEntry<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteEntryCopyWith<T, $Res> {
  factory $RouteEntryCopyWith(
          RouteEntry<T> value, $Res Function(RouteEntry<T>) then) =
      _$RouteEntryCopyWithImpl<T, $Res, RouteEntry<T>>;
  @useResult
  $Res call({String path, ValueSetter<T>? onResult});
}

/// @nodoc
class _$RouteEntryCopyWithImpl<T, $Res, $Val extends RouteEntry<T>>
    implements $RouteEntryCopyWith<T, $Res> {
  _$RouteEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? onResult = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: freezed == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RouteEntryCopyWith<T, $Res>
    implements $RouteEntryCopyWith<T, $Res> {
  factory _$$_RouteEntryCopyWith(
          _$_RouteEntry<T> value, $Res Function(_$_RouteEntry<T>) then) =
      __$$_RouteEntryCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String path, ValueSetter<T>? onResult});
}

/// @nodoc
class __$$_RouteEntryCopyWithImpl<T, $Res>
    extends _$RouteEntryCopyWithImpl<T, $Res, _$_RouteEntry<T>>
    implements _$$_RouteEntryCopyWith<T, $Res> {
  __$$_RouteEntryCopyWithImpl(
      _$_RouteEntry<T> _value, $Res Function(_$_RouteEntry<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? onResult = freezed,
  }) {
    return _then(_$_RouteEntry<T>(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      onResult: freezed == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as ValueSetter<T>?,
    ));
  }
}

/// @nodoc

class _$_RouteEntry<T> with DiagnosticableTreeMixin implements _RouteEntry<T> {
  const _$_RouteEntry({required this.path, this.onResult});

  @override
  final String path;
  @override
  final ValueSetter<T>? onResult;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RouteEntry<T> &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, onResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RouteEntryCopyWith<T, _$_RouteEntry<T>> get copyWith =>
      __$$_RouteEntryCopyWithImpl<T, _$_RouteEntry<T>>(this, _$identity);
}

abstract class _RouteEntry<T> implements RouteEntry<T> {
  const factory _RouteEntry(
      {required final String path,
      final ValueSetter<T>? onResult}) = _$_RouteEntry<T>;

  @override
  String get path;
  @override
  ValueSetter<T>? get onResult;
  @override
  @JsonKey(ignore: true)
  _$$_RouteEntryCopyWith<T, _$_RouteEntry<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
