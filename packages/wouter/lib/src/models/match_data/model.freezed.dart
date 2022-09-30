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
mixin _$MatchData {
  String get path => throw _privateConstructorUsedError;
  Map<String, dynamic> get arguments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MatchDataCopyWith<MatchData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDataCopyWith<$Res> {
  factory $MatchDataCopyWith(MatchData value, $Res Function(MatchData) then) =
      _$MatchDataCopyWithImpl<$Res>;
  $Res call({String path, Map<String, dynamic> arguments});
}

/// @nodoc
class _$MatchDataCopyWithImpl<$Res> implements $MatchDataCopyWith<$Res> {
  _$MatchDataCopyWithImpl(this._value, this._then);

  final MatchData _value;
  // ignore: unused_field
  final $Res Function(MatchData) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: arguments == freezed
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$$_MatchDataCopyWith<$Res> implements $MatchDataCopyWith<$Res> {
  factory _$$_MatchDataCopyWith(
          _$_MatchData value, $Res Function(_$_MatchData) then) =
      __$$_MatchDataCopyWithImpl<$Res>;
  @override
  $Res call({String path, Map<String, dynamic> arguments});
}

/// @nodoc
class __$$_MatchDataCopyWithImpl<$Res> extends _$MatchDataCopyWithImpl<$Res>
    implements _$$_MatchDataCopyWith<$Res> {
  __$$_MatchDataCopyWithImpl(
      _$_MatchData _value, $Res Function(_$_MatchData) _then)
      : super(_value, (v) => _then(v as _$_MatchData));

  @override
  _$_MatchData get _value => super._value as _$_MatchData;

  @override
  $Res call({
    Object? path = freezed,
    Object? arguments = freezed,
  }) {
    return _then(_$_MatchData(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: arguments == freezed
          ? _value._arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_MatchData implements _MatchData {
  const _$_MatchData(
      {required this.path, required final Map<String, dynamic> arguments})
      : _arguments = arguments;

  @override
  final String path;
  final Map<String, dynamic> _arguments;
  @override
  Map<String, dynamic> get arguments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_arguments);
  }

  @override
  String toString() {
    return 'MatchData(path: $path, arguments: $arguments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchData &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality()
                .equals(other._arguments, _arguments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(_arguments));

  @JsonKey(ignore: true)
  @override
  _$$_MatchDataCopyWith<_$_MatchData> get copyWith =>
      __$$_MatchDataCopyWithImpl<_$_MatchData>(this, _$identity);
}

abstract class _MatchData implements MatchData {
  const factory _MatchData(
      {required final String path,
      required final Map<String, dynamic> arguments}) = _$_MatchData;

  @override
  String get path;
  @override
  Map<String, dynamic> get arguments;
  @override
  @JsonKey(ignore: true)
  _$$_MatchDataCopyWith<_$_MatchData> get copyWith =>
      throw _privateConstructorUsedError;
}
