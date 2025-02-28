// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchData implements DiagnosticableTreeMixin {
  String get path;
  Map<String, dynamic> get arguments;

  /// Create a copy of MatchData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MatchDataCopyWith<MatchData> get copyWith =>
      _$MatchDataCopyWithImpl<MatchData>(this as MatchData, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MatchData'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('arguments', arguments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MatchData &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other.arguments, arguments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, path, const DeepCollectionEquality().hash(arguments));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MatchData(path: $path, arguments: $arguments)';
  }
}

/// @nodoc
abstract mixin class $MatchDataCopyWith<$Res> {
  factory $MatchDataCopyWith(MatchData value, $Res Function(MatchData) _then) =
      _$MatchDataCopyWithImpl;
  @useResult
  $Res call({String path, Map<String, dynamic> arguments});
}

/// @nodoc
class _$MatchDataCopyWithImpl<$Res> implements $MatchDataCopyWith<$Res> {
  _$MatchDataCopyWithImpl(this._self, this._then);

  final MatchData _self;
  final $Res Function(MatchData) _then;

  /// Create a copy of MatchData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? arguments = null,
  }) {
    return _then(_self.copyWith(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: null == arguments
          ? _self.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _MatchData with DiagnosticableTreeMixin implements MatchData {
  const _MatchData(
      {required this.path, required final Map<String, dynamic> arguments})
      : _arguments = arguments;

  @override
  final String path;
  final Map<String, dynamic> _arguments;
  @override
  Map<String, dynamic> get arguments {
    if (_arguments is EqualUnmodifiableMapView) return _arguments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_arguments);
  }

  /// Create a copy of MatchData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MatchDataCopyWith<_MatchData> get copyWith =>
      __$MatchDataCopyWithImpl<_MatchData>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MatchData'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('arguments', arguments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MatchData &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality()
                .equals(other._arguments, _arguments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, path, const DeepCollectionEquality().hash(_arguments));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MatchData(path: $path, arguments: $arguments)';
  }
}

/// @nodoc
abstract mixin class _$MatchDataCopyWith<$Res>
    implements $MatchDataCopyWith<$Res> {
  factory _$MatchDataCopyWith(
          _MatchData value, $Res Function(_MatchData) _then) =
      __$MatchDataCopyWithImpl;
  @override
  @useResult
  $Res call({String path, Map<String, dynamic> arguments});
}

/// @nodoc
class __$MatchDataCopyWithImpl<$Res> implements _$MatchDataCopyWith<$Res> {
  __$MatchDataCopyWithImpl(this._self, this._then);

  final _MatchData _self;
  final $Res Function(_MatchData) _then;

  /// Create a copy of MatchData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? arguments = null,
  }) {
    return _then(_MatchData(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: null == arguments
          ? _self._arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
