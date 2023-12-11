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
      _$StackEntryCopyWithImpl<T, $Res, StackEntry<T>>;
  @useResult
  $Res call(
      {String key,
      String path,
      WouterRouteBuilder<T> builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class _$StackEntryCopyWithImpl<T, $Res, $Val extends StackEntry<T>>
    implements $StackEntryCopyWith<T, $Res> {
  _$StackEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? path = null,
    Object? builder = null,
    Object? arguments = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: null == builder
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as WouterRouteBuilder<T>,
      arguments: null == arguments
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StackEntryImplCopyWith<T, $Res>
    implements $StackEntryCopyWith<T, $Res> {
  factory _$$StackEntryImplCopyWith(
          _$StackEntryImpl<T> value, $Res Function(_$StackEntryImpl<T>) then) =
      __$$StackEntryImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String key,
      String path,
      WouterRouteBuilder<T> builder,
      Map<String, dynamic> arguments});
}

/// @nodoc
class __$$StackEntryImplCopyWithImpl<T, $Res>
    extends _$StackEntryCopyWithImpl<T, $Res, _$StackEntryImpl<T>>
    implements _$$StackEntryImplCopyWith<T, $Res> {
  __$$StackEntryImplCopyWithImpl(
      _$StackEntryImpl<T> _value, $Res Function(_$StackEntryImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? path = null,
    Object? builder = null,
    Object? arguments = null,
  }) {
    return _then(_$StackEntryImpl<T>(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: null == builder
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as WouterRouteBuilder<T>,
      arguments: null == arguments
          ? _value._arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$StackEntryImpl<T> extends _StackEntry<T> with DiagnosticableTreeMixin {
  const _$StackEntryImpl(
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
    if (_arguments is EqualUnmodifiableMapView) return _arguments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_arguments);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StackEntry<$T>(key: $key, path: $path, builder: $builder, arguments: $arguments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StackEntry<$T>'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('arguments', arguments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StackEntryImpl<T> &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.builder, builder) || other.builder == builder) &&
            const DeepCollectionEquality()
                .equals(other._arguments, _arguments));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, path, builder,
      const DeepCollectionEquality().hash(_arguments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StackEntryImplCopyWith<T, _$StackEntryImpl<T>> get copyWith =>
      __$$StackEntryImplCopyWithImpl<T, _$StackEntryImpl<T>>(this, _$identity);
}

abstract class _StackEntry<T> extends StackEntry<T> {
  const factory _StackEntry(
      {required final String key,
      required final String path,
      required final WouterRouteBuilder<T> builder,
      final Map<String, dynamic> arguments}) = _$StackEntryImpl<T>;
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
  _$$StackEntryImplCopyWith<T, _$StackEntryImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
