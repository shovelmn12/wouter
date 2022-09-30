// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
abstract class _$$_RegexpDataCopyWith<$Res>
    implements $RegexpDataCopyWith<$Res> {
  factory _$$_RegexpDataCopyWith(
          _$_RegexpData value, $Res Function(_$_RegexpData) then) =
      __$$_RegexpDataCopyWithImpl<$Res>;
  @override
  $Res call({RegExp regexp, List<String> parameters});
}

/// @nodoc
class __$$_RegexpDataCopyWithImpl<$Res> extends _$RegexpDataCopyWithImpl<$Res>
    implements _$$_RegexpDataCopyWith<$Res> {
  __$$_RegexpDataCopyWithImpl(
      _$_RegexpData _value, $Res Function(_$_RegexpData) _then)
      : super(_value, (v) => _then(v as _$_RegexpData));

  @override
  _$_RegexpData get _value => super._value as _$_RegexpData;

  @override
  $Res call({
    Object? regexp = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_$_RegexpData(
      regexp: regexp == freezed
          ? _value.regexp
          : regexp // ignore: cast_nullable_to_non_nullable
              as RegExp,
      parameters: parameters == freezed
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_RegexpData implements _RegexpData {
  const _$_RegexpData(
      {required this.regexp, final List<String> parameters = const []})
      : _parameters = parameters;

  @override
  final RegExp regexp;
  final List<String> _parameters;
  @override
  @JsonKey()
  List<String> get parameters {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString() {
    return 'RegexpData(regexp: $regexp, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegexpData &&
            const DeepCollectionEquality().equals(other.regexp, regexp) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(regexp),
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
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
