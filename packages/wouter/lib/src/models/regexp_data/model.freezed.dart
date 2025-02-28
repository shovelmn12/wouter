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
mixin _$RegexpData implements DiagnosticableTreeMixin {
  RegExp get regexp;
  List<String> get parameters;

  /// Create a copy of RegexpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegexpDataCopyWith<RegexpData> get copyWith =>
      _$RegexpDataCopyWithImpl<RegexpData>(this as RegexpData, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'RegexpData'))
      ..add(DiagnosticsProperty('regexp', regexp))
      ..add(DiagnosticsProperty('parameters', parameters));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegexpData &&
            (identical(other.regexp, regexp) || other.regexp == regexp) &&
            const DeepCollectionEquality()
                .equals(other.parameters, parameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, regexp, const DeepCollectionEquality().hash(parameters));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegexpData(regexp: $regexp, parameters: $parameters)';
  }
}

/// @nodoc
abstract mixin class $RegexpDataCopyWith<$Res> {
  factory $RegexpDataCopyWith(
          RegexpData value, $Res Function(RegexpData) _then) =
      _$RegexpDataCopyWithImpl;
  @useResult
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class _$RegexpDataCopyWithImpl<$Res> implements $RegexpDataCopyWith<$Res> {
  _$RegexpDataCopyWithImpl(this._self, this._then);

  final RegexpData _self;
  final $Res Function(RegexpData) _then;

  /// Create a copy of RegexpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regexp = null,
    Object? parameters = null,
  }) {
    return _then(_self.copyWith(
      regexp: null == regexp
          ? _self.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: null == parameters
          ? _self.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _RegexpData with DiagnosticableTreeMixin implements RegexpData {
  const _RegexpData(
      {required this.regexp, final List<String> parameters = const []})
      : _parameters = parameters;

  @override
  final RegExp regexp;
  final List<String> _parameters;
  @override
  @JsonKey()
  List<String> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  /// Create a copy of RegexpData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegexpDataCopyWith<_RegexpData> get copyWith =>
      __$RegexpDataCopyWithImpl<_RegexpData>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'RegexpData'))
      ..add(DiagnosticsProperty('regexp', regexp))
      ..add(DiagnosticsProperty('parameters', parameters));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegexpData &&
            (identical(other.regexp, regexp) || other.regexp == regexp) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, regexp, const DeepCollectionEquality().hash(_parameters));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegexpData(regexp: $regexp, parameters: $parameters)';
  }
}

/// @nodoc
abstract mixin class _$RegexpDataCopyWith<$Res>
    implements $RegexpDataCopyWith<$Res> {
  factory _$RegexpDataCopyWith(
          _RegexpData value, $Res Function(_RegexpData) _then) =
      __$RegexpDataCopyWithImpl;
  @override
  @useResult
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class __$RegexpDataCopyWithImpl<$Res> implements _$RegexpDataCopyWith<$Res> {
  __$RegexpDataCopyWithImpl(this._self, this._then);

  final _RegexpData _self;
  final $Res Function(_RegexpData) _then;

  /// Create a copy of RegexpData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? regexp = null,
    Object? parameters = null,
  }) {
    return _then(_RegexpData(
      regexp: null == regexp
          ? _self.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: null == parameters
          ? _self._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
