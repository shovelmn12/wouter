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
mixin _$RegexpData {
  RegExp get regexp => throw _privateConstructorUsedError;
  List<String> get parameters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegexpDataCopyWith<RegexpData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegexpDataCopyWith<$Res> {
  factory $RegexpDataCopyWith(
          RegexpData value, $Res Function(RegexpData) then) =
      _$RegexpDataCopyWithImpl<$Res, RegexpData>;
  @useResult
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class _$RegexpDataCopyWithImpl<$Res, $Val extends RegexpData>
    implements $RegexpDataCopyWith<$Res> {
  _$RegexpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regexp = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      regexp: null == regexp
          ? _value.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegexpDataCopyWith<$Res>
    implements $RegexpDataCopyWith<$Res> {
  factory _$$_RegexpDataCopyWith(
          _$_RegexpData value, $Res Function(_$_RegexpData) then) =
      __$$_RegexpDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class __$$_RegexpDataCopyWithImpl<$Res>
    extends _$RegexpDataCopyWithImpl<$Res, _$_RegexpData>
    implements _$$_RegexpDataCopyWith<$Res> {
  __$$_RegexpDataCopyWithImpl(
      _$_RegexpData _value, $Res Function(_$_RegexpData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regexp = null,
    Object? parameters = null,
  }) {
    return _then(_$_RegexpData(
      regexp: null == regexp
          ? _value.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_RegexpData with DiagnosticableTreeMixin implements _RegexpData {
  const _$_RegexpData(
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegexpData(regexp: $regexp, parameters: $parameters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegexpData'))
      ..add(DiagnosticsProperty('regexp', regexp))
      ..add(DiagnosticsProperty('parameters', parameters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegexpData &&
            (identical(other.regexp, regexp) || other.regexp == regexp) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, regexp, const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegexpDataCopyWith<_$_RegexpData> get copyWith =>
      __$$_RegexpDataCopyWithImpl<_$_RegexpData>(this, _$identity);
}

abstract class _RegexpData implements RegexpData {
  const factory _RegexpData(
      {required final RegExp regexp,
      final List<String> parameters}) = _$_RegexpData;

  @override
  RegExp get regexp;
  @override
  List<String> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_RegexpDataCopyWith<_$_RegexpData> get copyWith =>
      throw _privateConstructorUsedError;
}
