// ignore_for_file: constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

// ===============================
// 비콘 종류 (Enum)
// ===============================

enum BeaconType {
  // 메인계단
  MB3_B2('메인계단 지하 3층과 지하 2층 사이'),
  MB2_B1('메인계단 지하 2층과 지하 1층 사이'),
  MB1_1('메인계단 지하 1층과 1층 사이'),
  M1_2('메인계단 1층과 2층 사이'),
  M2_3('메인계단 2층과 3층 사이'),
  M3_4('메인계단 3층과 4층 사이'),
  M4_5('메인계단4층과 5층 사이'),
  M5_6('메인계단 5층과 6층 사이'),
  M6_7('메인계단 6층과 7층 사이'),
  M7_8('메인계단 7층과 8층 사이'),
  M8_9('메인계단 8층과 9층 사이'),
  M9_10('메인계단 9층과 10층 사이'),
  M10_11('메인계단 10층과 11층 사이'),
  M11_12('메인계단 11층과 12층 사이'),
  M12_13('메인계단 12층과 13층 사이'),
  M13_14('메인계단 13층과 14층 사이'),
  M14_15('메인계단 14층과 15층 사이'),
  M15_16('메인계단 15층과 16층 사이'),
  M16_17('메인계단 16층과 17층 사이'),
  M17_18('메인계단 17층과 18층 사이'),
  M18_19('메인계단 18층과 19층 사이'),
  M19_20('메인계단 19층과 20층 사이'),

  // 서브계단
  SB3_B2('서브계단 지하 3층과 지하 2층 사이'),
  SB2_B1('서브계단 지하 2층과 지하 1층 사이'),
  SB1_1('서브계단 지하 1층과 1층 사이'),
  S1_2('서브계단 1층과 2층 사이'),
  S2_3('서브계단 2층과 3층 사이'),
  S3_4('서브계단 3층과 4층 사이'),
  S4_5('서브계단 4층과 5층 사이'),
  S5_6('서브계단 5층과 6층 사이'),
  S6_7('서브계단 6층과 7층 사이'),
  S7_8('서브계단 7층과 8층 사이'),
  S8_9('서브계단 8층과 9층 사이'),
  S9_10('서브계단 9층과 10층 사이'),
  S10_11('서브계단 10층과 11층 사이'),
  S11_12('서브계단 11층과 12층 사이'),
  S12_13('서브계단 12층과 13층 사이'),
  S13_14('서브계단 13층과 14층 사이'),
  S14_15('서브계단 14층과 15층 사이'),
  S15_16('서브계단 15층과 16층 사이'),
  S16_17('서브계단 16층과 17층 사이'),
  S17_18('서브계단 17층과 18층 사이'),
  S18_19('서브계단 18층과 19층 사이'),
  S19_20('서브계단 19층과 20층 사이');

  final String text;
  const BeaconType(this.text);
}

// ===============================
// BeaconType 관련 유틸리티 확장
// ===============================
extension BeaconTypeUtil on BeaconType {
  /// 축약형 디바이스 이름을 enum으로 변환
  static BeaconType? fromPlatformName(String name) {
    final normalized = _normalizeName(name);
    try {
      return BeaconType.values.firstWhere((e) => e.name == normalized);
    } catch (_) {
      return null;
    }
  }

  /// M12 → M1_2 / SB31 → SB3_1 등 정규화
  static String _normalizeName(String raw) {
    final match = RegExp(r'^([MSB]{1,2})(\d)(\d)$').firstMatch(raw);

    if (match != null) {
      final prefix = match.group(1)!;
      final a = match.group(2)!;
      final b = match.group(3)!;
      return '$prefix${a}_$b';
    }
    return raw; // 이미 정규 포맷이면 그대로
  }

  /// this BeaconType → (major, minor)
  (int major, int minor)? toMajorMinor() {
    final match = RegExp(r'^(MB|M|SB|S)(B?\d+)_B?(\d+)$').firstMatch(name);
    if (match == null) return null;

    final prefix = match.group(1)!;
    final fromStr = match.group(2)!;
    final toStr = match.group(3)!;

    int parseFloor(String s) =>
        s.startsWith('B') ? int.parse(s.substring(1)) : int.parse(s);

    final from = parseFloor(fromStr);
    final to = parseFloor(toStr);

    final minor = from * 100 + to;

    final major = switch (prefix) {
      'MB' => 1,
      'M' => 2,
      'SB' => 3,
      'S' => 4,
      _ => -1,
    };

    return (major, minor);
  }

  /// static: (major, minor) → BeaconType
  static BeaconType? fromMajorMinor(int major, int minor) {
    final from = minor ~/ 100;
    final to = minor % 100;

    final prefix = switch (major) {
      1 => 'MB',
      2 => 'M',
      3 => 'SB',
      4 => 'S',
      _ => null,
    };

    if (prefix == null) return null;

    final isUnderground = major == 1 || major == 3;
    final fromLabel = isUnderground ? 'B$from' : '$from';
    final toLabel = isUnderground ? (from == 1 ? '$to' : 'B$to') : '$to';

    final enumName = '$prefix${fromLabel}_$toLabel';

    return BeaconType.values.firstWhereOrNull((e) => e.name == enumName);
  }

  // ===============================
  // UUID 매핑
  // ===============================

  static const Map<String, BeaconType> _uuidToBeaconType = {
    // 메인계단
    '6107D61A-490A-4FDE-8873-C7168EFAEDEF': BeaconType.MB3_B2,
    '7DD764C6-53C8-47C7-A09A-1CE372E1BF82': BeaconType.MB2_B1,
    'A8009CED-5EC0-4363-922F-1CBD3DC8EF0D': BeaconType.MB1_1,
    'FDA50693-A4E2-4FB1-AFCF-C6EB07647825': BeaconType.M1_2,
    '3CAB70F3-9FD7-4F30-BA94-108964C735CB': BeaconType.M2_3,
    'FEDCE3F7-C0E0-4339-A683-CCE2158AB707': BeaconType.M3_4,
    '10C92FE6-1B64-4322-9DD3-16B0F62D3021': BeaconType.M4_5,
    '3B8EFA3D-98F7-4ADF-8883-0E09F13FF8E8': BeaconType.M5_6,
    '9B551F9F-48CA-4BD8-B678-0784591A5EC7': BeaconType.M6_7,
    '53D5DA85-5DCC-4C50-883C-9CF084596C6D': BeaconType.M7_8,
    'ABDFA238-75C1-4D8C-8F30-31D4B668F13E': BeaconType.M8_9,
    '52C3557E-BAA0-4F1A-BB46-F60950A91B60': BeaconType.M9_10,
    'D4DC505A-E5EF-48D4-8DE6-C95D5339D657': BeaconType.M10_11,
    '0F545157-E2C5-419C-BF17-18C250184A40': BeaconType.M11_12,
    '596A9D47-0BFC-405B-B040-94FA0FA5C7FB': BeaconType.M12_13,
    '8CBFD6CC-339D-470A-9AE3-485B24F6CC96': BeaconType.M13_14,
    '99C6E12E-F0EA-4140-ADF9-67C1D5A85D0E': BeaconType.M14_15,
    '9EE0DDE3-A000-42B3-A1BA-8010A4E32D2A': BeaconType.M15_16,
    '735CAA1C-C2EA-46A1-BA45-A16FB4F177E8': BeaconType.M16_17,
    'F055EA33-3EDC-4D4C-AD6B-30BB05DF60BD': BeaconType.M17_18,
    '867A48DB-35D1-40AF-BE7F-D71C41E0DA72': BeaconType.M18_19,
    'F79EC508-3C8F-473A-B0C1-9CAD738EEECF': BeaconType.M19_20,

    // 서브계단
    '51FE0ED0-3FE2-4FD4-8B08-AB8B31DF3C92': BeaconType.SB3_B2,
    '6A8B72A6-177E-43B3-8F02-49AC925C10C8': BeaconType.SB2_B1,
    'B207AAE3-60DB-46C1-9F50-86B2B0BFE0C4': BeaconType.SB1_1,
    '34D2639B-E1D7-4A42-A371-90940BF28CD9': BeaconType.S1_2,
    'D8B3CF0B-6A0C-4FD1-805F-67DD6072F304': BeaconType.S2_3,
    'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0': BeaconType.S3_4,
    '0FD82FAC-279C-452C-A425-DCFB587C9013': BeaconType.S4_5,
    '4CD09FEB-B7A5-4FE1-97EE-480CD5C815F6': BeaconType.S5_6,
    'A005C1E1-1B22-4E0D-A911-08EB55DA4C95': BeaconType.S6_7,
    'AFAE4BA4-0B16-4D91-A5B8-F9346456EB65': BeaconType.S7_8,
    'CD8DB6E1-C182-45E9-AA94-B4CC2E9BB4E4': BeaconType.S8_9,
    'D493F001-40D3-47EC-B971-0650B5B9D6C6': BeaconType.S9_10,
    '3349E74D-BCD9-49EC-BEF3-0885D2F28697': BeaconType.S10_11,
    '2649D1EC-9154-4127-BA4A-FA44E559FE6A': BeaconType.S11_12,
    'D180DAA2-013B-429F-9DAD-2C1600CD35D8': BeaconType.S12_13,
    '2485D956-BA94-45D1-ABB1-CEA7CCC0C8EC': BeaconType.S13_14,
    '6263EC2C-7854-45D4-81DB-ECFFF370D9C9': BeaconType.S14_15,
    '9B8EBFA5-9BCF-4760-8C52-52FD5B1FDD74': BeaconType.S15_16,
    'BED34DAE-2DB4-497C-9588-887A1BEA15C1': BeaconType.S16_17,
    '49C33B8E-72B9-4A2D-941A-C0F2889BC744': BeaconType.S17_18,
    '7316F0F4-540C-43D9-B9DE-B2A383B7E223': BeaconType.S18_19,
    '6241E4DD-12E4-4EDC-8F3F-AB425FE72509': BeaconType.S19_20,
  };

  static final Map<BeaconType, String> _beaconTypeToUuid =
      Map.fromEntries(_uuidToBeaconType.entries.map(
    (e) => MapEntry(e.value, e.key),
  ));

  static BeaconType? getBeaconTypeByUuid(String uuid) {
    return _uuidToBeaconType[uuid.toUpperCase()];
  }

  static String? getUuidByBeaconType(BeaconType type) {
    return _beaconTypeToUuid[type];
  }

  // ===============================
  // 리젼 생성
  // ===============================

  /// 모든 리젼을 가져옴
  static List<Region> get allRegions => BeaconType.values
      .map((type) {
        final uuid = getUuidByBeaconType(type);
        if (uuid == null) return null;
        return Region(
          identifier: type.name,
          proximityUUID: uuid.toUpperCase(),
        );
      })
      .whereType<Region>() // null 제거
      .toList();

  static List<Region> getNearbyRegions(BeaconType centerType,
      {int count = 20}) {
    final centerIndex = orderedBeaconTypes.indexOf(centerType);

    final half = count ~/ 2;
    int start = centerIndex - half;
    int end = centerIndex + half;

    if (start < 0) {
      end += -start;
      start = 0;
    }
    if (end > orderedBeaconTypes.length) {
      start -= (end - orderedBeaconTypes.length);
      end = orderedBeaconTypes.length;
      if (start < 0) start = 0;
    }

    final nearbyTypes = orderedBeaconTypes.sublist(start, end);

    return nearbyTypes
        .map((type) {
          final uuid = getUuidByBeaconType(type);
          if (uuid == null) return null;
          return Region(
            identifier: type.name,
            proximityUUID: uuid.toUpperCase(),
          );
        })
        .whereType<Region>() // null 제거
        .toList();
  }

  // ===============================
  // 층 정렬된 BeaconType 리스트
  // ===============================

  static final List<BeaconType> orderedBeaconTypes = _floorBeacons();

  static List<BeaconType> _floorBeacons() {
    final mList =
        BeaconType.values.where((e) => e.name.startsWith('M')).toList();
    final sList =
        BeaconType.values.where((e) => e.name.startsWith('S')).toList();

    final result = <BeaconType>[];

    final maxLen = mList.length > sList.length ? mList.length : sList.length;

    for (int i = 0; i < maxLen; i++) {
      if (i < mList.length) result.add(mList[i]);
      if (i < sList.length) result.add(sList[i]);
    }

    return result;
  }
}
