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
class _$WouterDelegateStateTearOff {
  const _$WouterDelegateStateTearOff();

  _WouterDelegateState call(
      {String path = '',
      String base = '',
      List<RouteHistory> stack = const []}) {
    return _WouterDelegateState(
      path: path,
      base: base,
      stack: stack,
    );
  }
}

/// @nodoc
const $WouterDelegateState = _$WouterDelegateStateTearOff();

/// @nodoc
mixin _$WouterDelegateState {
  String get path => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  List<RouteHistory> get stack => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WouterDelegateStateCopyWith<WouterDelegateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WouterDelegateStateCopyWith<$Res> {
  factory $WouterDelegateStateCopyWith(
          WouterDelegateState value, $Res Function(WouterDelegateState) then) =
      _$WouterDelegateStateCopyWithImpl<$Res>;
  $Res call({String path, String base, List<RouteHistory> stack});
}

/// @nodoc
class _$WouterDelegateStateCopyWithImpl<$Res>
    implements $WouterDelegateStateCopyWith<$Res> {
  _$WouterDelegateStateCopyWithImpl(this._value, this._then);

  final WouterDelegateState _value;
  // ignore: unused_field
  final $Res Function(WouterDelegateState) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? base = freezed,
    Object? stack = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteHistory>,
    ));
  }
}

/// @nodoc
abstract class _$WouterDelegateStateCopyWith<$Res>
    implements $WouterDelegateStateCopyWith<$Res> {
  factory _$WouterDelegateStateCopyWith(_WouterDelegateState value,
          $Res Function(_WouterDelegateState) then) =
      __$WouterDelegateStateCopyWithImpl<$Res>;
  @override
  $Res call({String path, String base, List<RouteHistory> stack});
}

/// @nodoc
class __$WouterDelegateStateCopyWithImpl<$Res>
    extends _$WouterDelegateStateCopyWithImpl<$Res>
    implements _$WouterDelegateStateCopyWith<$Res> {
  __$WouterDelegateStateCopyWithImpl(
      _WouterDelegateState _value, $Res Function(_WouterDelegateState) _then)
      : super(_value, (v) => _then(v as _WouterDelegateState));

  @override
  _WouterDelegateState get _value => super._value as _WouterDelegateState;

  @override
  $Res call({
    Object? path = freezed,
    Object? base = freezed,
    Object? stack = freezed,
  }) {
    return _then(_WouterDelegateState(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteHistory>,
    ));
  }
}

/// @nodoc

class _$_WouterDelegateState
    with DiagnosticableTreeMixin
    implements _WouterDelegateState {
  const _$_WouterDelegateState(
      {this.path = '', this.base = '', this.stack = const []});

  @JsonKey(defaultValue: '')
  @override
  final String path;
  @JsonKey(defaultValue: '')
  @override
  final String base;
  @JsonKey(defaultValue: const [])
  @override
  final List<RouteHistory> stack;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WouterDelegateState(path: $path, base: $base, stack: $stack)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WouterDelegateState'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('base', base))
      ..add(DiagnosticsProperty('stack', stack));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WouterDelegateState &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, path, base, const DeepCollectionEquality().hash(stack));

  @JsonKey(ignore: true)
  @override
  _$WouterDelegateStateCopyWith<_WouterDelegateState> get copyWith =>
      __$WouterDelegateStateCopyWithImpl<_WouterDelegateState>(
          this, _$identity);
}

abstract class _WouterDelegateState implements WouterDelegateState {
  const factory _WouterDelegateState(
      {String path,
      String base,
      List<RouteHistory> stack}) = _$_WouterDelegateState;

  @override
  String get path;
  @override
  String get base;
  @override
  List<RouteHistory> get stack;
  @override
  @JsonKey(ignore: true)
  _$WouterDelegateStateCopyWith<_WouterDelegateState> get copyWith =>
      throw _privateConstructorUsedError;
}
