// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bottle _$BottleFromJson(Map<String, dynamic> json) => _Bottle(
      content: json['content'] as String,
      updateBottle: json['update_bottle'] as String,
      date: (json['date'] as num).toInt(),
    );

Map<String, dynamic> _$BottleToJson(_Bottle instance) => <String, dynamic>{
      'content': instance.content,
      'update_bottle': instance.updateBottle,
      'date': instance.date,
    };
