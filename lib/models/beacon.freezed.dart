// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beacon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Beacon {
  String get id;
  String get remoteId;
  BeaconType get type;
  DateTime get tagTime;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BeaconCopyWith<Beacon> get copyWith =>
      _$BeaconCopyWithImpl<Beacon>(this as Beacon, _$identity);

  /// Serializes this Beacon to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Beacon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tagTime, tagTime) || other.tagTime == tagTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, remoteId, type, tagTime);

  @override
  String toString() {
    return 'Beacon(id: $id, remoteId: $remoteId, type: $type, tagTime: $tagTime)';
  }
}

/// @nodoc
abstract mixin class $BeaconCopyWith<$Res> {
  factory $BeaconCopyWith(Beacon value, $Res Function(Beacon) _then) =
      _$BeaconCopyWithImpl;
  @useResult
  $Res call({String id, String remoteId, BeaconType type, DateTime tagTime});
}

/// @nodoc
class _$BeaconCopyWithImpl<$Res> implements $BeaconCopyWith<$Res> {
  _$BeaconCopyWithImpl(this._self, this._then);

  final Beacon _self;
  final $Res Function(Beacon) _then;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? remoteId = null,
    Object? type = null,
    Object? tagTime = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: null == remoteId
          ? _self.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as BeaconType,
      tagTime: null == tagTime
          ? _self.tagTime
          : tagTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Beacon implements Beacon {
  _Beacon(
      {required this.id,
      required this.remoteId,
      required this.type,
      required this.tagTime});
  factory _Beacon.fromJson(Map<String, dynamic> json) => _$BeaconFromJson(json);

  @override
  final String id;
  @override
  final String remoteId;
  @override
  final BeaconType type;
  @override
  final DateTime tagTime;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BeaconCopyWith<_Beacon> get copyWith =>
      __$BeaconCopyWithImpl<_Beacon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BeaconToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Beacon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tagTime, tagTime) || other.tagTime == tagTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, remoteId, type, tagTime);

  @override
  String toString() {
    return 'Beacon(id: $id, remoteId: $remoteId, type: $type, tagTime: $tagTime)';
  }
}

/// @nodoc
abstract mixin class _$BeaconCopyWith<$Res> implements $BeaconCopyWith<$Res> {
  factory _$BeaconCopyWith(_Beacon value, $Res Function(_Beacon) _then) =
      __$BeaconCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String remoteId, BeaconType type, DateTime tagTime});
}

/// @nodoc
class __$BeaconCopyWithImpl<$Res> implements _$BeaconCopyWith<$Res> {
  __$BeaconCopyWithImpl(this._self, this._then);

  final _Beacon _self;
  final $Res Function(_Beacon) _then;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? remoteId = null,
    Object? type = null,
    Object? tagTime = null,
  }) {
    return _then(_Beacon(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      remoteId: null == remoteId
          ? _self.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as BeaconType,
      tagTime: null == tagTime
          ? _self.tagTime
          : tagTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
