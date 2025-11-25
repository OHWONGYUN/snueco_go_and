// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Storage {
  List<Beacon> get beacons;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StorageCopyWith<Storage> get copyWith =>
      _$StorageCopyWithImpl<Storage>(this as Storage, _$identity);

  /// Serializes this Storage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Storage &&
            const DeepCollectionEquality().equals(other.beacons, beacons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(beacons));

  @override
  String toString() {
    return 'Storage(beacons: $beacons)';
  }
}

/// @nodoc
abstract mixin class $StorageCopyWith<$Res> {
  factory $StorageCopyWith(Storage value, $Res Function(Storage) _then) =
      _$StorageCopyWithImpl;
  @useResult
  $Res call({List<Beacon> beacons});
}

/// @nodoc
class _$StorageCopyWithImpl<$Res> implements $StorageCopyWith<$Res> {
  _$StorageCopyWithImpl(this._self, this._then);

  final Storage _self;
  final $Res Function(Storage) _then;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beacons = null,
  }) {
    return _then(_self.copyWith(
      beacons: null == beacons
          ? _self.beacons
          : beacons // ignore: cast_nullable_to_non_nullable
              as List<Beacon>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Storage implements Storage {
  _Storage({required final List<Beacon> beacons}) : _beacons = beacons;
  factory _Storage.fromJson(Map<String, dynamic> json) =>
      _$StorageFromJson(json);

  final List<Beacon> _beacons;
  @override
  List<Beacon> get beacons {
    if (_beacons is EqualUnmodifiableListView) return _beacons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_beacons);
  }

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StorageCopyWith<_Storage> get copyWith =>
      __$StorageCopyWithImpl<_Storage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StorageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Storage &&
            const DeepCollectionEquality().equals(other._beacons, _beacons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_beacons));

  @override
  String toString() {
    return 'Storage(beacons: $beacons)';
  }
}

/// @nodoc
abstract mixin class _$StorageCopyWith<$Res> implements $StorageCopyWith<$Res> {
  factory _$StorageCopyWith(_Storage value, $Res Function(_Storage) _then) =
      __$StorageCopyWithImpl;
  @override
  @useResult
  $Res call({List<Beacon> beacons});
}

/// @nodoc
class __$StorageCopyWithImpl<$Res> implements _$StorageCopyWith<$Res> {
  __$StorageCopyWithImpl(this._self, this._then);

  final _Storage _self;
  final $Res Function(_Storage) _then;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? beacons = null,
  }) {
    return _then(_Storage(
      beacons: null == beacons
          ? _self._beacons
          : beacons // ignore: cast_nullable_to_non_nullable
              as List<Beacon>,
    ));
  }
}

// dart format on
