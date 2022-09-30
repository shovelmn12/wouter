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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StackEntry<T> {
  String get key => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  WouterRouteBuilder<T> get builder => throw _privateConstructorUsedError;
  Map<String, dynamic> get arguments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StackEntryCopyWith<T, StackEntry<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StackEntryCopyWith<T, $Res> {
  factory $StackEntryCopyWith(
          StackEntry<T> value, $Res Function(StackEntry<T>) then) =
      _$StackEntryCopyWithImpl<T, $Res>;
  $Res call(
      {String key,
      String path,
      WouterRouteBuilder<T> builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class _$StackEntryCopyWithImpl<T, $Res>
    implements $StackEntryCopyWith<T, $Res> {
  _$StackEntryCopyWithImpl(this._value, this._then);

  final StackEntry<T> _value;
  // ignore: unused_field
  final $Res Function(StackEntry<T>) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? path = freezed,
    Object? builder = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as WouterRouteBuilder<T>,
      arguments: arguments == freezed
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$$_StackEntryCopyWith<T, $Res>
    implements $StackEntryCopyWith<T, $Res> {
  factory _$$_StackEntryCopyWith(
          _$_StackEntry<T> value, $Res Function(_$_StackEntry<T>) then) =
      __$$_StackEntryCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {String key,
      String path,
      WouterRouteBuilder<T> builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class __$$_StackEntryCopyWithImpl<T, $Res>
    extends _$StackEntryCopyWithImpl<T, $Res>
    implements _$$_StackEntryCopyWith<T, $Res> {
  __$$_StackEntryCopyWithImpl(
      _$_StackEntry<T> _value, $Res Function(_$_StackEntry<T>) _then)
      : super(_value, (v) => _then(v as _$_StackEntry<T>));

  @override
  _$_StackEntry<T> get _value => super._value as _$_StackEntry<T>;

  @override
  $Res call({
    Object? key = freezed,
    Object? path = freezed,
    Object? builder = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_$_StackEntry<T>(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as WouterRouteBuilder<T>,
      arguments: arguments == freezed
          ? _value._arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_StackEntry<T> extends _StackEntry<T> {
  const _$_StackEntry(
      {required this.key,
      required this.path,
      required this.builder,
      final Map<String, dynamic> arguments = const {}})
      : _arguments = arguments,
        super._();

  @override
  final String key;
  @override
  final String path;
  @override
  final WouterRouteBuilder<T> builder;
  final Map<String, dynamic> _arguments;
  @override
  @JsonKey()
  Map<String, dynamic> get arguments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_arguments);
  }

  @override
  String toString() {
    return 'StackEntry<$T>(key: $key, path: $path, builder: $builder, arguments: $arguments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StackEntry<T> &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            (identical(other.builder, builder) || other.builder == builder) &&
            const DeepCollectionEquality()
                .equals(other._arguments, _arguments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(path),
      builder,
      const DeepCollectionEquality().hash(_arguments));

  @JsonKey(ignore: true)
  @override
  _$$_StackEntryCopyWith<T, _$_StackEntry<T>> get copyWith =>
      __$$_StackEntryCopyWithImpl<T, _$_StackEntry<T>>(this, _$identity);
}

abstract class _StackEntry<T> extends StackEntry<T> {
  const factory _StackEntry(
      {required final String key,
      required final String path,
      required final WouterRouteBuilder<T> builder,
      final Map<String, dynamic> arguments}) = _$_StackEntry<T>;
  const _StackEntry._() : super._();

  @override
  String get key;
  @override
  String get path;
  @override
  WouterRouteBuilder<T> get builder;
  @override
  Map<String, dynamic> get arguments;
  @override
  @JsonKey(ignore: true)
  _$$_StackEntryCopyWith<T, _$_StackEntry<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
