// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PatientCWProxy {
  Patient id(int id);

  Patient name(String name);

  Patient admissionTime(int admissionTime);

  Patient remainingTime(int remainingTime);

  Patient canPay(bool canPay);

  Patient satisfaction(double satisfaction);

  Patient urgency(Urgency urgency);

  Patient statusIndex(int statusIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Patient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Patient(...).copyWith(id: 12, name: "My name")
  /// ````
  Patient call({
    int id,
    String name,
    int admissionTime,
    int remainingTime,
    bool canPay,
    double satisfaction,
    Urgency urgency,
    int statusIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPatient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPatient.copyWith.fieldName(...)`
class _$PatientCWProxyImpl implements _$PatientCWProxy {
  const _$PatientCWProxyImpl(this._value);

  final Patient _value;

  @override
  Patient id(int id) => this(id: id);

  @override
  Patient name(String name) => this(name: name);

  @override
  Patient admissionTime(int admissionTime) =>
      this(admissionTime: admissionTime);

  @override
  Patient remainingTime(int remainingTime) =>
      this(remainingTime: remainingTime);

  @override
  Patient canPay(bool canPay) => this(canPay: canPay);

  @override
  Patient satisfaction(double satisfaction) => this(satisfaction: satisfaction);

  @override
  Patient urgency(Urgency urgency) => this(urgency: urgency);

  @override
  Patient statusIndex(int statusIndex) => this(statusIndex: statusIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Patient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Patient(...).copyWith(id: 12, name: "My name")
  /// ````
  Patient call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? admissionTime = const $CopyWithPlaceholder(),
    Object? remainingTime = const $CopyWithPlaceholder(),
    Object? canPay = const $CopyWithPlaceholder(),
    Object? satisfaction = const $CopyWithPlaceholder(),
    Object? urgency = const $CopyWithPlaceholder(),
    Object? statusIndex = const $CopyWithPlaceholder(),
  }) {
    return Patient(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      admissionTime: admissionTime == const $CopyWithPlaceholder()
          ? _value.admissionTime
          // ignore: cast_nullable_to_non_nullable
          : admissionTime as int,
      remainingTime: remainingTime == const $CopyWithPlaceholder()
          ? _value.remainingTime
          // ignore: cast_nullable_to_non_nullable
          : remainingTime as int,
      canPay: canPay == const $CopyWithPlaceholder()
          ? _value.canPay
          // ignore: cast_nullable_to_non_nullable
          : canPay as bool,
      satisfaction: satisfaction == const $CopyWithPlaceholder()
          ? _value.satisfaction
          // ignore: cast_nullable_to_non_nullable
          : satisfaction as double,
      urgency: urgency == const $CopyWithPlaceholder()
          ? _value.urgency
          // ignore: cast_nullable_to_non_nullable
          : urgency as Urgency,
      statusIndex: statusIndex == const $CopyWithPlaceholder()
          ? _value.statusIndex
          // ignore: cast_nullable_to_non_nullable
          : statusIndex as int,
    );
  }
}

extension $PatientCopyWith on Patient {
  /// Returns a callable class that can be used as follows: `instanceOfPatient.copyWith(...)` or like so:`instanceOfPatient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PatientCWProxy get copyWith => _$PatientCWProxyImpl(this);
}
