import 'dart:async';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:snueco/enums/beacon_type.dart';
import 'package:snueco/models/beacon.dart' as model;
import 'package:stream_transform/stream_transform.dart';

class BeaconScanner {
  // ===============================
  // 포그라운드 비콘 스캔 (Ranging)
  // ===============================

  Stream<model.Beacon> startRangingStream() {
    return flutterBeacon.ranging(BeaconTypeUtil.allRegions).expand((result) {
      return result.beacons
          .map((b) => _mapToModel(b))
          .whereType<model.Beacon>();
    });
  }

  // ===============================
  // 백그라운드 비콘 감지 (Monitoring)
  // ===============================

  Stream<model.Beacon> startMonitoringStream(List<Region> regions) {
    return flutterBeacon.monitoring(regions).map((result) {
      try {
        // 🚫 Exit 이벤트는 무시
        if (result.monitoringEventType != MonitoringEventType.didEnterRegion) {
          return null;
        }

        final uuid = result.region.proximityUUID;
        if (uuid == null) return null;

        final type = BeaconTypeUtil.getBeaconTypeByUuid(uuid);
        if (type == null) return null;

        final mapping = type.toMajorMinor();
        if (mapping == null) return null;

        final (major, minor) = mapping;

        return model.Beacon(
          id: type.name,
          remoteId: '${major}_$minor',
          tagTime: DateTime.now(),
          type: type,
        );
      } catch (e, stack) {
        print('❌ [Monitoring 오류] $e\n$stack');
        return null;
      }
    }).whereType<model.Beacon>();
  }

  // ===============================
  // 내부 변환 함수
  // ===============================

  model.Beacon? _mapToModel(Beacon beacon) {
    final type = BeaconTypeUtil.fromMajorMinor(beacon.major, beacon.minor);
    if (type == null) return null;

    return model.Beacon(
      id: type.name,
      remoteId: '${beacon.major}_${beacon.minor}',
      tagTime: DateTime.now(),
      type: type,
    );
  }
}
