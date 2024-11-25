// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localizations_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalizationsState {
  Locale get locale => throw _privateConstructorUsedError;

  /// Create a copy of LocalizationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalizationsStateCopyWith<LocalizationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationsStateCopyWith<$Res> {
  factory $LocalizationsStateCopyWith(
          LocalizationsState value, $Res Function(LocalizationsState) then) =
      _$LocalizationsStateCopyWithImpl<$Res, LocalizationsState>;
  @useResult
  $Res call({Locale locale});
}

/// @nodoc
class _$LocalizationsStateCopyWithImpl<$Res, $Val extends LocalizationsState>
    implements $LocalizationsStateCopyWith<$Res> {
  _$LocalizationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalizationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalizationsStateImplCopyWith<$Res>
    implements $LocalizationsStateCopyWith<$Res> {
  factory _$$LocalizationsStateImplCopyWith(_$LocalizationsStateImpl value,
          $Res Function(_$LocalizationsStateImpl) then) =
      __$$LocalizationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Locale locale});
}

/// @nodoc
class __$$LocalizationsStateImplCopyWithImpl<$Res>
    extends _$LocalizationsStateCopyWithImpl<$Res, _$LocalizationsStateImpl>
    implements _$$LocalizationsStateImplCopyWith<$Res> {
  __$$LocalizationsStateImplCopyWithImpl(_$LocalizationsStateImpl _value,
      $Res Function(_$LocalizationsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalizationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
  }) {
    return _then(_$LocalizationsStateImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$LocalizationsStateImpl implements _LocalizationsState {
  const _$LocalizationsStateImpl({this.locale = const Locale('ar')});

  @override
  @JsonKey()
  final Locale locale;

  @override
  String toString() {
    return 'LocalizationsState(locale: $locale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizationsStateImpl &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale);

  /// Create a copy of LocalizationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizationsStateImplCopyWith<_$LocalizationsStateImpl> get copyWith =>
      __$$LocalizationsStateImplCopyWithImpl<_$LocalizationsStateImpl>(
          this, _$identity);
}

abstract class _LocalizationsState implements LocalizationsState {
  const factory _LocalizationsState({final Locale locale}) =
      _$LocalizationsStateImpl;

  @override
  Locale get locale;

  /// Create a copy of LocalizationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalizationsStateImplCopyWith<_$LocalizationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
