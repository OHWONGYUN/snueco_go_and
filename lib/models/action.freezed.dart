// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Action {
  String? get id;
  String get uid;
  String get bid;
  @TimestampConverter()
  DateTime get tagTime;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActionCopyWith<Action> get copyWith =>
      _$ActionCopyWithImpl<Action>(this as Action, _$identity);

  /// Serializes this Action to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.tagTime, tagTime) || other.tagTime == tagTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, bid, tagTime);

  @override
  String toString() {
    return 'Action(id: $id, uid: $uid, bid: $bid, tagTime: $tagTime)';
  }
}

/// @nodoc
abstract mixin class $ActionCopyWith<$Res> {
  factory $ActionCopyWith(Action value, $Res Function(Action) _then) =
      _$ActionCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String uid,
      String bid,
      @TimestampConverter() DateTime tagTime});
}

/// @nodoc
class _$ActionCopyWithImpl<$Res> implements $ActionCopyWith<$Res> {
  _$ActionCopyWithImpl(this._self, this._then);

  final Action _self;
  final $Res Function(Action) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = null,
    Object? bid = null,
    Object? tagTime = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      bid: null == bid
          ? _self.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      tagTime: null == tagTime
          ? _self.tagTime
          : tagTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Action implements Action {
  _Action(
      {this.id,
      required this.uid,
      required this.bid,
      @TimestampConverter() required this.tagTime});
  factory _Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  @override
  final String? id;
  @override
  final String uid;
  @override
  final String bid;
  @override
  @TimestampConverter()
  final DateTime tagTime;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActionCopyWith<_Action> get copyWith =>
      __$ActionCopyWithImpl<_Action>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Action &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.tagTime, tagTime) || other.tagTime == tagTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, bid, tagTime);

  @override
  String toString() {
    return 'Action(id: $id, uid: $uid, bid: $bid, tagTime: $tagTime)';
  }
}

/// @nodoc
abstract mixin class _$ActionCopyWith<$Res> implements $ActionCopyWith<$Res> {
  factory _$ActionCopyWith(_Action value, $Res Function(_Action) _then) =
      __$ActionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String uid,
      String bid,
      @TimestampConverter() DateTime tagTime});
}

/// @nodoc
class __$ActionCopyWithImpl<$Res> implements _$ActionCopyWith<$Res> {
  __$ActionCopyWithImpl(this._self, this._then);

  final _Action _self;
  final $Res Function(_Action) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? uid = null,
    Object? bid = null,
    Object? tagTime = null,
  }) {
    return _then(_Action(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      bid: null == bid
          ? _self.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      tagTime: null == tagTime
          ? _self.tagTime
          : tagTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
