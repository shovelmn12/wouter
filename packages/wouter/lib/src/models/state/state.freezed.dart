// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WouterState {
  bool get canPop;
  String get base;
  List<RouteEntry> get stack;

  /// Create a copy of WouterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WouterStateCopyWith<WouterState> get copyWith =>
      _$WouterStateCopyWithImpl<WouterState>(this as WouterState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WouterState &&
            (identical(other.canPop, canPop) || other.canPop == canPop) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, canPop, base, const DeepCollectionEquality().hash(stack));

  @override
  String toString() {
    return 'WouterState(canPop: $canPop, base: $base, stack: $stack)';
  }
}

/// @nodoc
abstract mixin class $WouterStateCopyWith<$Res> {
  factory $WouterStateCopyWith(
          WouterState value, $Res Function(WouterState) _then) =
      _$WouterStateCopyWithImpl;
  @useResult
  $Res call({bool canPop, String base, List<RouteEntry> stack});
}

/// @nodoc
class _$WouterStateCopyWithImpl<$Res> implements $WouterStateCopyWith<$Res> {
  _$WouterStateCopyWithImpl(this._self, this._then);

  final WouterState _self;
  final $Res Function(WouterState) _then;

  /// Create a copy of WouterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPop = null,
    Object? base = null,
    Object? stack = null,
  }) {
    return _then(_self.copyWith(
      canPop: null == canPop
          ? _self.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _self.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: null == stack
          ? _self.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteEntry>,
    ));
  }
}

/// @nodoc

class _WouterState implements WouterState {
  const _WouterState(
      {required this.canPop,
      required this.base,
      required final List<RouteEntry> stack})
      : _stack = stack;

  @override
  final bool canPop;
  @override
  final String base;
  final List<RouteEntry> _stack;
  @override
  List<RouteEntry> get stack {
    if (_stack is EqualUnmodifiableListView) return _stack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stack);
  }

  /// Create a copy of WouterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WouterStateCopyWith<_WouterState> get copyWith =>
      __$WouterStateCopyWithImpl<_WouterState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WouterState &&
            (identical(other.canPop, canPop) || other.canPop == canPop) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other._stack, _stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, canPop, base, const DeepCollectionEquality().hash(_stack));

  @override
  String toString() {
    return 'WouterState(canPop: $canPop, base: $base, stack: $stack)';
  }
}

/// @nodoc
abstract mixin class _$WouterStateCopyWith<$Res>
    implements $WouterStateCopyWith<$Res> {
  factory _$WouterStateCopyWith(
          _WouterState value, $Res Function(_WouterState) _then) =
      __$WouterStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool canPop, String base, List<RouteEntry> stack});
}

/// @nodoc
class __$WouterStateCopyWithImpl<$Res> implements _$WouterStateCopyWith<$Res> {
  __$WouterStateCopyWithImpl(this._self, this._then);

  final _WouterState _self;
  final $Res Function(_WouterState) _then;

  /// Create a copy of WouterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canPop = null,
    Object? base = null,
    Object? stack = null,
  }) {
    return _then(_WouterState(
      canPop: null == canPop
          ? _self.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _self.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: null == stack
          ? _self._stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteEntry>,
    ));
  }
}

// dart format on
