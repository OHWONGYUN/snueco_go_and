// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Beacon _$BeaconFromJson(Map<String, dynamic> json) => _Beacon(
      id: json['id'] as String,
      remoteId: json['remote_id'] as String,
      type: $enumDecode(_$BeaconTypeEnumMap, json['type']),
      tagTime: DateTime.parse(json['tag_time'] as String),
    );

Map<String, dynamic> _$BeaconToJson(_Beacon instance) => <String, dynamic>{
      'id': instance.id,
      'remote_id': instance.remoteId,
      'type': _$BeaconTypeEnumMap[instance.type]!,
      'tag_time': instance.tagTime.toIso8601String(),
    };

const _$BeaconTypeEnumMap = {
  BeaconType.MB3_B2: 'MB3_B2',
  BeaconType.MB2_B1: 'MB2_B1',
  BeaconType.MB1_1: 'MB1_1',
  BeaconType.M1_2: 'M1_2',
  BeaconType.M2_3: 'M2_3',
  BeaconType.M3_4: 'M3_4',
  BeaconType.M4_5: 'M4_5',
  BeaconType.M5_6: 'M5_6',
  BeaconType.M6_7: 'M6_7',
  BeaconType.M7_8: 'M7_8',
  BeaconType.M8_9: 'M8_9',
  BeaconType.M9_10: 'M9_10',
  BeaconType.M10_11: 'M10_11',
  BeaconType.M11_12: 'M11_12',
  BeaconType.M12_13: 'M12_13',
  BeaconType.M13_14: 'M13_14',
  BeaconType.M14_15: 'M14_15',
  BeaconType.M15_16: 'M15_16',
  BeaconType.M16_17: 'M16_17',
  BeaconType.M17_18: 'M17_18',
  BeaconType.M18_19: 'M18_19',
  BeaconType.M19_20: 'M19_20',
  BeaconType.SB3_B2: 'SB3_B2',
  BeaconType.SB2_B1: 'SB2_B1',
  BeaconType.SB1_1: 'SB1_1',
  BeaconType.S1_2: 'S1_2',
  BeaconType.S2_3: 'S2_3',
  BeaconType.S3_4: 'S3_4',
  BeaconType.S4_5: 'S4_5',
  BeaconType.S5_6: 'S5_6',
  BeaconType.S6_7: 'S6_7',
  BeaconType.S7_8: 'S7_8',
  BeaconType.S8_9: 'S8_9',
  BeaconType.S9_10: 'S9_10',
  BeaconType.S10_11: 'S10_11',
  BeaconType.S11_12: 'S11_12',
  BeaconType.S12_13: 'S12_13',
  BeaconType.S13_14: 'S13_14',
  BeaconType.S14_15: 'S14_15',
  BeaconType.S15_16: 'S15_16',
  BeaconType.S16_17: 'S16_17',
  BeaconType.S17_18: 'S17_18',
  BeaconType.S18_19: 'S18_19',
  BeaconType.S19_20: 'S19_20',
};
