// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WouterState {
  bool get canPop => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  List<RouteEntry> get stack => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WouterStateCopyWith<WouterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WouterStateCopyWith<$Res> {
  factory $WouterStateCopyWith(
          WouterState value, $Res Function(WouterState) then) =
      _$WouterStateCopyWithImpl<$Res, WouterState>;
  @useResult
  $Res call({bool canPop, String base, List<RouteEntry> stack});
}

/// @nodoc
class _$WouterStateCopyWithImpl<$Res, $Val extends WouterState>
    implements $WouterStateCopyWith<$Res> {
  _$WouterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPop = null,
    Object? base = null,
    Object? stack = null,
  }) {
    return _then(_value.copyWith(
      canPop: null == canPop
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: null == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WouterStateImplCopyWith<$Res>
    implements $WouterStateCopyWith<$Res> {
  factory _$$WouterStateImplCopyWith(
          _$WouterStateImpl value, $Res Function(_$WouterStateImpl) then) =
      __$$WouterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool canPop, String base, List<RouteEntry> stack});
}

/// @nodoc
class __$$WouterStateImplCopyWithImpl<$Res>
    extends _$WouterStateCopyWithImpl<$Res, _$WouterStateImpl>
    implements _$$WouterStateImplCopyWith<$Res> {
  __$$WouterStateImplCopyWithImpl(
      _$WouterStateImpl _value, $Res Function(_$WouterStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPop = null,
    Object? base = null,
    Object? stack = null,
  }) {
    return _then(_$WouterStateImpl(
      canPop: null == canPop
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      stack: null == stack
          ? _value._stack
          : stack // ignore: cast_nullable_to_non_nullable
              as List<RouteEntry>,
    ));
  }
}

/// @nodoc

class _$WouterStateImpl implements _WouterState {
  const _$WouterStateImpl(
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

  @override
  String toString() {
    return 'WouterState(canPop: $canPop, base: $base, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WouterStateImpl &&
            (identical(other.canPop, canPop) || other.canPop == canPop) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other._stack, _stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, canPop, base, const DeepCollectionEquality().hash(_stack));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WouterStateImplCopyWith<_$WouterStateImpl> get copyWith =>
      __$$WouterStateImplCopyWithImpl<_$WouterStateImpl>(this, _$identity);
}

abstract class _WouterState implements WouterState {
  const factory _WouterState(
      {required final bool canPop,
      required final String base,
      required final List<RouteEntry> stack}) = _$WouterStateImpl;

  @override
  bool get canPop;
  @override
  String get base;
  @override
  List<RouteEntry> get stack;
  @override
  @JsonKey(ignore: true)
  _$$WouterStateImplCopyWith<_$WouterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
