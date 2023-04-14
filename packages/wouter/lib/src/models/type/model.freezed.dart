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
mixin _$WouterType {
  RoutingPolicy<dynamic> get policy => throw _privateConstructorUsedError;
  MatchData? Function(String, String, {bool prefix}) get matcher =>
      throw _privateConstructorUsedError;
  bool get canPop => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)
        child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)?
        root,
    TResult? Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RootWouterType value) root,
    required TResult Function(ChildWouterType value) child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RootWouterType value)? root,
    TResult? Function(ChildWouterType value)? child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WouterTypeCopyWith<WouterType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WouterTypeCopyWith<$Res> {
  factory $WouterTypeCopyWith(
          WouterType value, $Res Function(WouterType) then) =
      _$WouterTypeCopyWithImpl<$Res, WouterType>;
  @useResult
  $Res call(
      {RoutingPolicy<dynamic> policy,
      MatchData? Function(String, String, {bool prefix}) matcher,
      bool canPop,
      String base,
      String path});
}

/// @nodoc
class _$WouterTypeCopyWithImpl<$Res, $Val extends WouterType>
    implements $WouterTypeCopyWith<$Res> {
  _$WouterTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? policy = null,
    Object? matcher = null,
    Object? canPop = null,
    Object? base = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: null == matcher
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as MatchData? Function(String, String, {bool prefix}),
      canPop: null == canPop
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RootWouterTypeCopyWith<$Res>
    implements $WouterTypeCopyWith<$Res> {
  factory _$$RootWouterTypeCopyWith(
          _$RootWouterType value, $Res Function(_$RootWouterType) then) =
      __$$RootWouterTypeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BaseRouterDelegate delegate,
      RoutingPolicy<dynamic> policy,
      PathMatcher matcher,
      bool canPop,
      String base,
      String path});
}

/// @nodoc
class __$$RootWouterTypeCopyWithImpl<$Res>
    extends _$WouterTypeCopyWithImpl<$Res, _$RootWouterType>
    implements _$$RootWouterTypeCopyWith<$Res> {
  __$$RootWouterTypeCopyWithImpl(
      _$RootWouterType _value, $Res Function(_$RootWouterType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delegate = null,
    Object? policy = null,
    Object? matcher = null,
    Object? canPop = null,
    Object? base = null,
    Object? path = null,
  }) {
    return _then(_$RootWouterType(
      delegate: null == delegate
          ? _value.delegate
          : delegate // ignore: cast_nullable_to_non_nullable
              as BaseRouterDelegate,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: null == matcher
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as PathMatcher,
      canPop: null == canPop
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RootWouterType with DiagnosticableTreeMixin implements RootWouterType {
  const _$RootWouterType(
      {required this.delegate,
      required this.policy,
      required this.matcher,
      required this.canPop,
      required this.base,
      required this.path});

  @override
  final BaseRouterDelegate delegate;
  @override
  final RoutingPolicy<dynamic> policy;
  @override
  final PathMatcher matcher;
  @override
  final bool canPop;
  @override
  final String base;
  @override
  final String path;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WouterType.root(delegate: $delegate, policy: $policy, matcher: $matcher, canPop: $canPop, base: $base, path: $path)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WouterType.root'))
      ..add(DiagnosticsProperty('delegate', delegate))
      ..add(DiagnosticsProperty('policy', policy))
      ..add(DiagnosticsProperty('matcher', matcher))
      ..add(DiagnosticsProperty('canPop', canPop))
      ..add(DiagnosticsProperty('base', base))
      ..add(DiagnosticsProperty('path', path));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootWouterType &&
            (identical(other.delegate, delegate) ||
                other.delegate == delegate) &&
            (identical(other.policy, policy) || other.policy == policy) &&
            (identical(other.matcher, matcher) || other.matcher == matcher) &&
            (identical(other.canPop, canPop) || other.canPop == canPop) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, delegate, policy, matcher, canPop, base, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RootWouterTypeCopyWith<_$RootWouterType> get copyWith =>
      __$$RootWouterTypeCopyWithImpl<_$RootWouterType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)
        child,
  }) {
    return root(delegate, policy, matcher, canPop, base, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)?
        root,
    TResult? Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
  }) {
    return root?.call(delegate, policy, matcher, canPop, base, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
    required TResult orElse(),
  }) {
    if (root != null) {
      return root(delegate, policy, matcher, canPop, base, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RootWouterType value) root,
    required TResult Function(ChildWouterType value) child,
  }) {
    return root(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RootWouterType value)? root,
    TResult? Function(ChildWouterType value)? child,
  }) {
    return root?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
    required TResult orElse(),
  }) {
    if (root != null) {
      return root(this);
    }
    return orElse();
  }
}

abstract class RootWouterType implements WouterType {
  const factory RootWouterType(
      {required final BaseRouterDelegate delegate,
      required final RoutingPolicy<dynamic> policy,
      required final PathMatcher matcher,
      required final bool canPop,
      required final String base,
      required final String path}) = _$RootWouterType;

  BaseRouterDelegate get delegate;
  @override
  RoutingPolicy<dynamic> get policy;
  @override
  PathMatcher get matcher;
  @override
  bool get canPop;
  @override
  String get base;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$RootWouterTypeCopyWith<_$RootWouterType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChildWouterTypeCopyWith<$Res>
    implements $WouterTypeCopyWith<$Res> {
  factory _$$ChildWouterTypeCopyWith(
          _$ChildWouterType value, $Res Function(_$ChildWouterType) then) =
      __$$ChildWouterTypeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BaseWouter parent,
      RoutingPolicy<dynamic> policy,
      PathMatcher matcher,
      bool canPop,
      String base,
      String path});
}

/// @nodoc
class __$$ChildWouterTypeCopyWithImpl<$Res>
    extends _$WouterTypeCopyWithImpl<$Res, _$ChildWouterType>
    implements _$$ChildWouterTypeCopyWith<$Res> {
  __$$ChildWouterTypeCopyWithImpl(
      _$ChildWouterType _value, $Res Function(_$ChildWouterType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parent = null,
    Object? policy = null,
    Object? matcher = null,
    Object? canPop = null,
    Object? base = null,
    Object? path = null,
  }) {
    return _then(_$ChildWouterType(
      parent: null == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as BaseWouter,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: null == matcher
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as PathMatcher,
      canPop: null == canPop
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChildWouterType
    with DiagnosticableTreeMixin
    implements ChildWouterType {
  const _$ChildWouterType(
      {required this.parent,
      required this.policy,
      required this.matcher,
      required this.canPop,
      required this.base,
      required this.path});

  @override
  final BaseWouter parent;
  @override
  final RoutingPolicy<dynamic> policy;
  @override
  final PathMatcher matcher;
  @override
  final bool canPop;
  @override
  final String base;
  @override
  final String path;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WouterType.child(parent: $parent, policy: $policy, matcher: $matcher, canPop: $canPop, base: $base, path: $path)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WouterType.child'))
      ..add(DiagnosticsProperty('parent', parent))
      ..add(DiagnosticsProperty('policy', policy))
      ..add(DiagnosticsProperty('matcher', matcher))
      ..add(DiagnosticsProperty('canPop', canPop))
      ..add(DiagnosticsProperty('base', base))
      ..add(DiagnosticsProperty('path', path));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildWouterType &&
            (identical(other.parent, parent) || other.parent == parent) &&
            (identical(other.policy, policy) || other.policy == policy) &&
            (identical(other.matcher, matcher) || other.matcher == matcher) &&
            (identical(other.canPop, canPop) || other.canPop == canPop) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, parent, policy, matcher, canPop, base, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildWouterTypeCopyWith<_$ChildWouterType> get copyWith =>
      __$$ChildWouterTypeCopyWithImpl<_$ChildWouterType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)
        child,
  }) {
    return child(parent, policy, matcher, canPop, base, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String path)?
        root,
    TResult? Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
  }) {
    return child?.call(parent, policy, matcher, canPop, base, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String path)?
        child,
    required TResult orElse(),
  }) {
    if (child != null) {
      return child(parent, policy, matcher, canPop, base, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RootWouterType value) root,
    required TResult Function(ChildWouterType value) child,
  }) {
    return child(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RootWouterType value)? root,
    TResult? Function(ChildWouterType value)? child,
  }) {
    return child?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
    required TResult orElse(),
  }) {
    if (child != null) {
      return child(this);
    }
    return orElse();
  }
}

abstract class ChildWouterType implements WouterType {
  const factory ChildWouterType(
      {required final BaseWouter parent,
      required final RoutingPolicy<dynamic> policy,
      required final PathMatcher matcher,
      required final bool canPop,
      required final String base,
      required final String path}) = _$ChildWouterType;

  BaseWouter get parent;
  @override
  RoutingPolicy<dynamic> get policy;
  @override
  PathMatcher get matcher;
  @override
  bool get canPop;
  @override
  String get base;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$ChildWouterTypeCopyWith<_$ChildWouterType> get copyWith =>
      throw _privateConstructorUsedError;
}
