// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DoctorCWProxy {
  Doctor id(int id);

  Doctor name(String name);

  Doctor price(int price);

  Doctor statusIndex(int statusIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Doctor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Doctor(...).copyWith(id: 12, name: "My name")
  /// ````
  Doctor call({
    int id,
    String name,
    int price,
    int statusIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDoctor.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDoctor.copyWith.fieldName(...)`
class _$DoctorCWProxyImpl implements _$DoctorCWProxy {
  const _$DoctorCWProxyImpl(this._value);

  final Doctor _value;

  @override
  Doctor id(int id) => this(id: id);

  @override
  Doctor name(String name) => this(name: name);

  @override
  Doctor price(int price) => this(price: price);

  @override
  Doctor statusIndex(int statusIndex) => this(statusIndex: statusIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Doctor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Doctor(...).copyWith(id: 12, name: "My name")
  /// ````
  Doctor call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? statusIndex = const $CopyWithPlaceholder(),
  }) {
    return Doctor(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      statusIndex: statusIndex == const $CopyWithPlaceholder()
          ? _value.statusIndex
          // ignore: cast_nullable_to_non_nullable
          : statusIndex as int,
    );
  }
}

extension $DoctorCopyWith on Doctor {
  /// Returns a callable class that can be used as follows: `instanceOfDoctor.copyWith(...)` or like so:`instanceOfDoctor.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DoctorCWProxy get copyWith => _$DoctorCWProxyImpl(this);
}
