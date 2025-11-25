// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bottle {
  String get content;
  String get updateBottle;
  int get date;

  /// Create a copy of Bottle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BottleCopyWith<Bottle> get copyWith =>
      _$BottleCopyWithImpl<Bottle>(this as Bottle, _$identity);

  /// Serializes this Bottle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Bottle &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.updateBottle, updateBottle) ||
                other.updateBottle == updateBottle) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, updateBottle, date);

  @override
  String toString() {
    return 'Bottle(content: $content, updateBottle: $updateBottle, date: $date)';
  }
}

/// @nodoc
abstract mixin class $BottleCopyWith<$Res> {
  factory $BottleCopyWith(Bottle value, $Res Function(Bottle) _then) =
      _$BottleCopyWithImpl;
  @useResult
  $Res call({String content, String updateBottle, int date});
}

/// @nodoc
class _$BottleCopyWithImpl<$Res> implements $BottleCopyWith<$Res> {
  _$BottleCopyWithImpl(this._self, this._then);

  final Bottle _self;
  final $Res Function(Bottle) _then;

  /// Create a copy of Bottle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? updateBottle = null,
    Object? date = null,
  }) {
    return _then(_self.copyWith(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      updateBottle: null == updateBottle
          ? _self.updateBottle
          : updateBottle // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Bottle implements Bottle {
  _Bottle(
      {required this.content, required this.updateBottle, required this.date});
  factory _Bottle.fromJson(Map<String, dynamic> json) => _$BottleFromJson(json);

  @override
  final String content;
  @override
  final String updateBottle;
  @override
  final int date;

  /// Create a copy of Bottle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BottleCopyWith<_Bottle> get copyWith =>
      __$BottleCopyWithImpl<_Bottle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BottleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Bottle &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.updateBottle, updateBottle) ||
                other.updateBottle == updateBottle) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, updateBottle, date);

  @override
  String toString() {
    return 'Bottle(content: $content, updateBottle: $updateBottle, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$BottleCopyWith<$Res> implements $BottleCopyWith<$Res> {
  factory _$BottleCopyWith(_Bottle value, $Res Function(_Bottle) _then) =
      __$BottleCopyWithImpl;
  @override
  @useResult
  $Res call({String content, String updateBottle, int date});
}

/// @nodoc
class __$BottleCopyWithImpl<$Res> implements _$BottleCopyWith<$Res> {
  __$BottleCopyWithImpl(this._self, this._then);

  final _Bottle _self;
  final $Res Function(_Bottle) _then;

  /// Create a copy of Bottle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
    Object? updateBottle = null,
    Object? date = null,
  }) {
    return _then(_Bottle(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      updateBottle: null == updateBottle
          ? _self.updateBottle
          : updateBottle // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
