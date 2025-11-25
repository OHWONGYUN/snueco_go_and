// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Storage _$StorageFromJson(Map<String, dynamic> json) => _Storage(
      beacons: (json['beacons'] as List<dynamic>)
          .map((e) => Beacon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StorageToJson(_Storage instance) => <String, dynamic>{
      'beacons': instance.beacons.map((e) => e.toJson()).toList(),
    };
