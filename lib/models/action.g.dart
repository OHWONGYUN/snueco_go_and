// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Action _$ActionFromJson(Map<String, dynamic> json) => _Action(
      id: json['id'] as String?,
      uid: json['uid'] as String,
      bid: json['bid'] as String,
      tagTime:
          const TimestampConverter().fromJson(json['tag_time'] as Timestamp),
    );

Map<String, dynamic> _$ActionToJson(_Action instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'bid': instance.bid,
      'tag_time': const TimestampConverter().toJson(instance.tagTime),
    };
