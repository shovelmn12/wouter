// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RegexpDataTearOff {
  const _$RegexpDataTearOff();

  _RegexpData call(
      {required RegExp regexp, List<String> parameters = const []}) {
    return _RegexpData(
      regexp: regexp,
      parameters: parameters,
    );
  }
}

/// @nodoc
const $RegexpData = _$RegexpDataTearOff();

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
      _$RegexpDataCopyWithImpl<$Res>;
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class _$RegexpDataCopyWithImpl<$Res> implements $RegexpDataCopyWith<$Res> {
  _$RegexpDataCopyWithImpl(this._value, this._then);

  final RegexpData _value;
  // ignore: unused_field
  final $Res Function(RegexpData) _then;

  @override
  $Res call({
    Object? regexp = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      regexp: regexp == freezed
          ? _value.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$RegexpDataCopyWith<$Res> implements $RegexpDataCopyWith<$Res> {
  factory _$RegexpDataCopyWith(
          _RegexpData value, $Res Function(_RegexpData) then) =
      __$RegexpDataCopyWithImpl<$Res>;
  @override
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class __$RegexpDataCopyWithImpl<$Res> extends _$RegexpDataCopyWithImpl<$Res>
    implements _$RegexpDataCopyWith<$Res> {
  __$RegexpDataCopyWithImpl(
      _RegexpData _value, $Res Function(_RegexpData) _then)
      : super(_value, (v) => _then(v as _RegexpData));

  @override
  _RegexpData get _value => super._value as _RegexpData;

  @override
  $Res call({
    Object? regexp = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_RegexpData(
      regexp: regexp == freezed
          ? _value.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_RegexpData with DiagnosticableTreeMixin implements _RegexpData {
  const _$_RegexpData({required this.regexp, this.parameters = const []});

  @override
  final RegExp regexp;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> parameters;

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
        (other is _RegexpData &&
            (identical(other.regexp, regexp) ||
                const DeepCollectionEquality().equals(other.regexp, regexp)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(regexp) ^
      const DeepCollectionEquality().hash(parameters);

  @JsonKey(ignore: true)
  @override
  _$RegexpDataCopyWith<_RegexpData> get copyWith =>
      __$RegexpDataCopyWithImpl<_RegexpData>(this, _$identity);
}

abstract class _RegexpData implements RegexpData {
  const factory _RegexpData({required RegExp regexp, List<String> parameters}) =
      _$_RegexpData;

  @override
  RegExp get regexp => throw _privateConstructorUsedError;
  @override
  List<String> get parameters => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegexpDataCopyWith<_RegexpData> get copyWith =>
      throw _privateConstructorUsedError;
}
