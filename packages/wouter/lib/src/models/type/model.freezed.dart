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
class _$WouterTypeTearOff {
  const _$WouterTypeTearOff();

  RootWouterType root(
      {required BaseRouterDelegate delegate,
      required RoutingPolicy<dynamic> policy,
      required PathMatcher matcher,
      required bool canPop,
      required String base,
      required String route}) {
    return RootWouterType(
      delegate: delegate,
      policy: policy,
      matcher: matcher,
      canPop: canPop,
      base: base,
      route: route,
    );
  }

  ChildWouterType child(
      {required BaseWouter parent,
      required RoutingPolicy<dynamic> policy,
      required PathMatcher matcher,
      required bool canPop,
      required String base,
      required String route}) {
    return ChildWouterType(
      parent: parent,
      policy: policy,
      matcher: matcher,
      canPop: canPop,
      base: base,
      route: route,
    );
  }
}

/// @nodoc
const $WouterType = _$WouterTypeTearOff();

/// @nodoc
mixin _$WouterType {
  RoutingPolicy<dynamic> get policy => throw _privateConstructorUsedError;
  PathMatcher get matcher => throw _privateConstructorUsedError;
  bool get canPop => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String route)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)
        child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        child,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
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
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
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
      _$WouterTypeCopyWithImpl<$Res>;
  $Res call(
      {RoutingPolicy<dynamic> policy,
      PathMatcher matcher,
      bool canPop,
      String base,
      String route});
}

/// @nodoc
class _$WouterTypeCopyWithImpl<$Res> implements $WouterTypeCopyWith<$Res> {
  _$WouterTypeCopyWithImpl(this._value, this._then);

  final WouterType _value;
  // ignore: unused_field
  final $Res Function(WouterType) _then;

  @override
  $Res call({
    Object? policy = freezed,
    Object? matcher = freezed,
    Object? canPop = freezed,
    Object? base = freezed,
    Object? route = freezed,
  }) {
    return _then(_value.copyWith(
      policy: policy == freezed
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: matcher == freezed
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as PathMatcher,
      canPop: canPop == freezed
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $RootWouterTypeCopyWith<$Res>
    implements $WouterTypeCopyWith<$Res> {
  factory $RootWouterTypeCopyWith(
          RootWouterType value, $Res Function(RootWouterType) then) =
      _$RootWouterTypeCopyWithImpl<$Res>;
  @override
  $Res call(
      {BaseRouterDelegate delegate,
      RoutingPolicy<dynamic> policy,
      PathMatcher matcher,
      bool canPop,
      String base,
      String route});
}

/// @nodoc
class _$RootWouterTypeCopyWithImpl<$Res> extends _$WouterTypeCopyWithImpl<$Res>
    implements $RootWouterTypeCopyWith<$Res> {
  _$RootWouterTypeCopyWithImpl(
      RootWouterType _value, $Res Function(RootWouterType) _then)
      : super(_value, (v) => _then(v as RootWouterType));

  @override
  RootWouterType get _value => super._value as RootWouterType;

  @override
  $Res call({
    Object? delegate = freezed,
    Object? policy = freezed,
    Object? matcher = freezed,
    Object? canPop = freezed,
    Object? base = freezed,
    Object? route = freezed,
  }) {
    return _then(RootWouterType(
      delegate: delegate == freezed
          ? _value.delegate
          : delegate // ignore: cast_nullable_to_non_nullable
              as BaseRouterDelegate,
      policy: policy == freezed
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: matcher == freezed
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as PathMatcher,
      canPop: canPop == freezed
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
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
      required this.route});

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
  final String route;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WouterType.root(delegate: $delegate, policy: $policy, matcher: $matcher, canPop: $canPop, base: $base, route: $route)';
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
      ..add(DiagnosticsProperty('route', route));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RootWouterType &&
            const DeepCollectionEquality().equals(other.delegate, delegate) &&
            const DeepCollectionEquality().equals(other.policy, policy) &&
            (identical(other.matcher, matcher) || other.matcher == matcher) &&
            const DeepCollectionEquality().equals(other.canPop, canPop) &&
            const DeepCollectionEquality().equals(other.base, base) &&
            const DeepCollectionEquality().equals(other.route, route));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(delegate),
      const DeepCollectionEquality().hash(policy),
      matcher,
      const DeepCollectionEquality().hash(canPop),
      const DeepCollectionEquality().hash(base),
      const DeepCollectionEquality().hash(route));

  @JsonKey(ignore: true)
  @override
  $RootWouterTypeCopyWith<RootWouterType> get copyWith =>
      _$RootWouterTypeCopyWithImpl<RootWouterType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String route)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)
        child,
  }) {
    return root(delegate, policy, matcher, canPop, base, route);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        child,
  }) {
    return root?.call(delegate, policy, matcher, canPop, base, route);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        child,
    required TResult orElse(),
  }) {
    if (root != null) {
      return root(delegate, policy, matcher, canPop, base, route);
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
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
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
      {required BaseRouterDelegate delegate,
      required RoutingPolicy<dynamic> policy,
      required PathMatcher matcher,
      required bool canPop,
      required String base,
      required String route}) = _$RootWouterType;

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
  String get route;
  @override
  @JsonKey(ignore: true)
  $RootWouterTypeCopyWith<RootWouterType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildWouterTypeCopyWith<$Res>
    implements $WouterTypeCopyWith<$Res> {
  factory $ChildWouterTypeCopyWith(
          ChildWouterType value, $Res Function(ChildWouterType) then) =
      _$ChildWouterTypeCopyWithImpl<$Res>;
  @override
  $Res call(
      {BaseWouter parent,
      RoutingPolicy<dynamic> policy,
      PathMatcher matcher,
      bool canPop,
      String base,
      String route});
}

/// @nodoc
class _$ChildWouterTypeCopyWithImpl<$Res> extends _$WouterTypeCopyWithImpl<$Res>
    implements $ChildWouterTypeCopyWith<$Res> {
  _$ChildWouterTypeCopyWithImpl(
      ChildWouterType _value, $Res Function(ChildWouterType) _then)
      : super(_value, (v) => _then(v as ChildWouterType));

  @override
  ChildWouterType get _value => super._value as ChildWouterType;

  @override
  $Res call({
    Object? parent = freezed,
    Object? policy = freezed,
    Object? matcher = freezed,
    Object? canPop = freezed,
    Object? base = freezed,
    Object? route = freezed,
  }) {
    return _then(ChildWouterType(
      parent: parent == freezed
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as BaseWouter,
      policy: policy == freezed
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as RoutingPolicy<dynamic>,
      matcher: matcher == freezed
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as PathMatcher,
      canPop: canPop == freezed
          ? _value.canPop
          : canPop // ignore: cast_nullable_to_non_nullable
              as bool,
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
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
      required this.route});

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
  final String route;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WouterType.child(parent: $parent, policy: $policy, matcher: $matcher, canPop: $canPop, base: $base, route: $route)';
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
      ..add(DiagnosticsProperty('route', route));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChildWouterType &&
            const DeepCollectionEquality().equals(other.parent, parent) &&
            const DeepCollectionEquality().equals(other.policy, policy) &&
            (identical(other.matcher, matcher) || other.matcher == matcher) &&
            const DeepCollectionEquality().equals(other.canPop, canPop) &&
            const DeepCollectionEquality().equals(other.base, base) &&
            const DeepCollectionEquality().equals(other.route, route));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(parent),
      const DeepCollectionEquality().hash(policy),
      matcher,
      const DeepCollectionEquality().hash(canPop),
      const DeepCollectionEquality().hash(base),
      const DeepCollectionEquality().hash(route));

  @JsonKey(ignore: true)
  @override
  $ChildWouterTypeCopyWith<ChildWouterType> get copyWith =>
      _$ChildWouterTypeCopyWithImpl<ChildWouterType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            BaseRouterDelegate delegate,
            RoutingPolicy<dynamic> policy,
            PathMatcher matcher,
            bool canPop,
            String base,
            String route)
        root,
    required TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)
        child,
  }) {
    return child(parent, policy, matcher, canPop, base, route);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        child,
  }) {
    return child?.call(parent, policy, matcher, canPop, base, route);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BaseRouterDelegate delegate, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        root,
    TResult Function(BaseWouter parent, RoutingPolicy<dynamic> policy,
            PathMatcher matcher, bool canPop, String base, String route)?
        child,
    required TResult orElse(),
  }) {
    if (child != null) {
      return child(parent, policy, matcher, canPop, base, route);
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
    TResult Function(RootWouterType value)? root,
    TResult Function(ChildWouterType value)? child,
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
      {required BaseWouter parent,
      required RoutingPolicy<dynamic> policy,
      required PathMatcher matcher,
      required bool canPop,
      required String base,
      required String route}) = _$ChildWouterType;

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
  String get route;
  @override
  @JsonKey(ignore: true)
  $ChildWouterTypeCopyWith<ChildWouterType> get copyWith =>
      throw _privateConstructorUsedError;
}
