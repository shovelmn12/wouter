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
class _$StackItemTearOff {
  const _$StackItemTearOff();

  _StackItem<T> call<T>(
      {required String path,
      required T Function(BuildContext, Map<String, dynamic>) builder,
      Map<String, dynamic> arguments = const {}}) {
    return _StackItem<T>(
      path: path,
      builder: builder,
      arguments: arguments,
    );
  }
}

/// @nodoc
const $StackItem = _$StackItemTearOff();

/// @nodoc
mixin _$StackItem<T> {
  String get path => throw _privateConstructorUsedError;
  T Function(BuildContext, Map<String, dynamic>) get builder =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get arguments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StackItemCopyWith<T, StackItem<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StackItemCopyWith<T, $Res> {
  factory $StackItemCopyWith(
          StackItem<T> value, $Res Function(StackItem<T>) then) =
      _$StackItemCopyWithImpl<T, $Res>;
  $Res call(
      {String path,
      T Function(BuildContext, Map<String, dynamic>) builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class _$StackItemCopyWithImpl<T, $Res> implements $StackItemCopyWith<T, $Res> {
  _$StackItemCopyWithImpl(this._value, this._then);

  final StackItem<T> _value;
  // ignore: unused_field
  final $Res Function(StackItem<T>) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? builder = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as T Function(BuildContext, Map<String, dynamic>),
      arguments: arguments == freezed
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$StackItemCopyWith<T, $Res>
    implements $StackItemCopyWith<T, $Res> {
  factory _$StackItemCopyWith(
          _StackItem<T> value, $Res Function(_StackItem<T>) then) =
      __$StackItemCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {String path,
      T Function(BuildContext, Map<String, dynamic>) builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class __$StackItemCopyWithImpl<T, $Res> extends _$StackItemCopyWithImpl<T, $Res>
    implements _$StackItemCopyWith<T, $Res> {
  __$StackItemCopyWithImpl(
      _StackItem<T> _value, $Res Function(_StackItem<T>) _then)
      : super(_value, (v) => _then(v as _StackItem<T>));

  @override
  _StackItem<T> get _value => super._value as _StackItem<T>;

  @override
  $Res call({
    Object? path = freezed,
    Object? builder = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_StackItem<T>(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as T Function(BuildContext, Map<String, dynamic>),
      arguments: arguments == freezed
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_StackItem<T> extends _StackItem<T> with DiagnosticableTreeMixin {
  const _$_StackItem(
      {required this.path, required this.builder, this.arguments = const {}})
      : super._();

  @override
  final String path;
  @override
  final T Function(BuildContext, Map<String, dynamic>) builder;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, dynamic> arguments;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StackItem<$T>(path: $path, builder: $builder, arguments: $arguments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StackItem<$T>'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('arguments', arguments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StackItem<T> &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.builder, builder) ||
                const DeepCollectionEquality()
                    .equals(other.builder, builder)) &&
            (identical(other.arguments, arguments) ||
                const DeepCollectionEquality()
                    .equals(other.arguments, arguments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(builder) ^
      const DeepCollectionEquality().hash(arguments);

  @JsonKey(ignore: true)
  @override
  _$StackItemCopyWith<T, _StackItem<T>> get copyWith =>
      __$StackItemCopyWithImpl<T, _StackItem<T>>(this, _$identity);
}

abstract class _StackItem<T> extends StackItem<T> {
  const factory _StackItem(
      {required String path,
      required T Function(BuildContext, Map<String, dynamic>) builder,
      Map<String, dynamic> arguments}) = _$_StackItem<T>;
  const _StackItem._() : super._();

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  T Function(BuildContext, Map<String, dynamic>) get builder =>
      throw _privateConstructorUsedError;
  @override
  Map<String, dynamic> get arguments => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StackItemCopyWith<T, _StackItem<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
