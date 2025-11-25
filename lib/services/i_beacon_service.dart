import 'dart:async';
import 'dart:io';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snueco/enums/beacon_type.dart';
import 'package:snueco/models/beacon.dart' as model;

import 'beacon_recorder.dart';
import 'beacon_scanner.dart';

class IBeaconService {
  final BeaconScanner scanner;
  final BeaconRecorder recorder;

  StreamSubscription? _rangingSub;
  StreamSubscription? _monitoringSub;

  model.Beacon? _lastRangedBeacon; // 포그라운드 최종 감지 비콘
  model.Beacon? _lastMonitoringBeacon; // 백그라운드 모니터링 중 최종 감지 비콘
  DateTime? _lastRegionUpdateTime; // 마지막 리전 갱신 시각

  IBeaconService({
    required this.scanner,
    required this.recorder,
  });

  // ===============================
  // 초기화
  // ===============================

  /// 위치 권한 체크 및 요청
  Future<bool> checkAndRequestForegroundLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted || status.isLimited) {
      return true;
    }

    if (status.isDenied || status.isRestricted) {
      status = await Permission.location.request();
      return status.isGranted || status.isLimited;
    }

    return false;
  }

  Future<bool> checkAndRequestBackgroundLocationPermission() async {
    var status = await Permission.locationAlways.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.locationAlways.request();
      return status.isGranted;
    }

    return false;
  }

  // ===============================
  // 비콘 초기화
  // ===============================

  bool _isInitialized = false; // ✅ 초기화 여부 저장

  Future<void> initializeIfNeeded() async {
    if (_isInitialized) return;

    final locationStatus = await Permission.location.status;

    // Android BLE 권한 요청
    if (Platform.isAndroid) {
      await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
    }

    final bluetoothState = await flutterBeacon.bluetoothState;

    if (locationStatus.isGranted && bluetoothState == BluetoothState.stateOn) {
      try {
        await flutterBeacon.initializeScanning;
        _isInitialized = true;
        print('✅ flutterBeacon 초기화 완료');
      } catch (e) {
        print('❌ flutterBeacon 초기화 실패: $e');
      }
    } else {
      print('⚠️ 초기화 실패: 위치 권한/블루투스 상태 확인 필요');
    }
  }

  // ===============================
  // 포그라운드 비콘 스캔
  // ===============================
  Future<void> startRanging() async {
    await recorder.flushBackgroundBeacons(); // ✅ 앱 복귀 시 백그라운드 기록 flush
    stopRanging();
    _lastRangedBeacon = null;

    _rangingSub =
        scanner.startRangingStream().listen((model.Beacon beacon) async {
      _lastRangedBeacon = beacon;

      try {
        await recorder.record(beacon);
      } catch (e) {
        print('❌ 포그라운드 비콘 기록 중 오류: $e');
      }
    });
  }

  void stopRanging() {
    _rangingSub?.cancel();
    _rangingSub = null;
  }

  // ===============================
  // 백그라운드 비콘 모니터링
  // ===============================
  void startMonitoring() {
    stopMonitoring();

    final type = _lastRangedBeacon?.type ?? BeaconType.values.first;
    final regions = BeaconTypeUtil.getNearbyRegions(type);

    try {
      _monitoringSub = scanner
          .startMonitoringStream(regions)
          .listen((model.Beacon beacon) async {
        await _handleMonitoringBeacon(beacon);
      });
    } catch (e) {
      print('❌ 백그라운드 비콘 모니터링 중 오류: $e');
    }
  }

  void stopMonitoring() {
    _monitoringSub?.cancel();
    _monitoringSub = null;
  }

  // ===============================
  // 백그라운드 감지 이벤트 처리
  // ===============================
  Future<void> _handleMonitoringBeacon(model.Beacon beacon) async {
    // ✅ 먼저 기록부터!
    try {
      await recorder.recordBackground(beacon);
    } catch (e) {
      print('❌ 백그라운드 비콘 기록 중 오류: $e');
    }

    final now = DateTime.now();

    // ✅ 기록 후, 리전 갱신 필요하면
    if (_shouldUpdateRegions(beacon, now)) {
      _lastMonitoringBeacon = beacon;
      _lastRegionUpdateTime = now;

      stopMonitoring();
      final newRegions = BeaconTypeUtil.getNearbyRegions(beacon.type);
      _monitoringSub =
          scanner.startMonitoringStream(newRegions).listen((beacon) async {
        await _handleMonitoringBeacon(beacon);
      });

      print('✅ 리전 갱신 완료 (${beacon.id})');
    }
  }

  // ===============================
  // 리전 갱신 판단
  // ===============================
  bool _shouldUpdateRegions(model.Beacon beacon, DateTime now) {
    if (_lastMonitoringBeacon == null) return true;

    // 10초 이내에는 리전 갱신 금지
    if (_lastRegionUpdateTime != null &&
        now.difference(_lastRegionUpdateTime!).inSeconds < 10) {
      return false;
    }

    // 2개 층 이상 이동했으면 리전 갱신
    final lastIndex =
        BeaconTypeUtil.orderedBeaconTypes.indexOf(_lastMonitoringBeacon!.type);
    final currentIndex = BeaconTypeUtil.orderedBeaconTypes.indexOf(beacon.type);

    if ((lastIndex - currentIndex).abs() >= 2) {
      return true;
    }

    return false;
  }

  // ===============================
  // 백그라운드 기록 → 파이어스토어로 저장
  // ===============================
  Future<void> flushBackgroundBeacons() async {
    await recorder.flushBackgroundBeacons();
  }

  void dispose() {
    stopRanging();
    stopMonitoring();
  }
}
