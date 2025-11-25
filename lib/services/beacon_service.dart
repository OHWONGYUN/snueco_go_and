import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snueco/auth/firebase_auth/auth_util.dart';
import 'package:snueco/backend/backend.dart';
import 'package:snueco/enums/beacon_type.dart';
import 'package:snueco/flutter_flow/flutter_flow_util.dart';
import 'package:snueco/models/action.dart';
import 'package:snueco/models/beacon.dart';
import 'package:snueco/models/bottle.dart';
import 'package:snueco/models/storage.dart';
import 'package:snueco/services/database_service.dart';
import 'package:snueco/utils/field.dart';

class BeaconService {
  static const platform = MethodChannel('com.example.my_project/beacon');
  final SharedPreferences prefs;

  BeaconService({required this.prefs}) {
    // 앱 시작시 휴대폰 내부에 저장된 비콘 정보 불러오기
    _loadBeaconsFromPhone();
  }

  final _auth = FirebaseAuth.instance;

  final _databaseService = DatabaseService();

  // 제자리에 있는 경우와 제힌시간 이내 인지 확인을 위한 임시 비콘 리스트
  final List<Beacon> _beacons = [];

  // DB저장을 위한 스캔된 비콘 리스트
  final List<Beacon> _scannedBeacons = [];

  Future<void> scanBeacon() async {
    var blePermission = await Permission.bluetooth.status;
    // 날짜가 변경되었는지 확인
    await _checkDateAndMonth();

    // 스캔된 비콘이 있으면 DB에 저장
    if (_scannedBeacons.isNotEmpty) {
      await _addAction();
    }

    // 비콘정보 휴대폰 내부에 저장 (앱이 종료되어도 비콘 정보가 유지되도록)
    if (_beacons.isNotEmpty) {
      await _saveBeaconsToPhone();
    }

    /////////beacon 스캔
    if (blePermission.isDenied) {
      final result = await Permission.bluetooth.request();

      if (result.isGranted) {
        _startScan();
      }
    } else {
      _startScan();
    }
  }

  void _startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    var subscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        // 해당 디바이스가 비콘일 경우 리스트에 추가
        final rawName = result.device.platformName; // 예: "M12"
        final myType = BeaconTypeUtil.fromPlatformName(rawName);

        final bool isBeacon = BeaconType.values.any((type) => type == myType);

        if (isBeacon) {
          // 아이디가 같은 것이 이미 있다면 추가 하지 않음
          final bool isAlreadyScanned = _scannedBeacons.any(
            (b) => b.remoteId == result.device.remoteId.str,
          );

          if (isAlreadyScanned) {
            continue;
          }

          final BeaconType type = BeaconType.values.firstWhere(
            (type) => type == myType,
          );
          final DateTime now = DateTime.now();

          final Beacon beacon = Beacon(
            id: result.device.platformName,
            remoteId: result.device.remoteId.str,
            tagTime: now,
            type: type,
          );

          _scannedBeacons.add(beacon);
        }
      }
    });

    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }

  Future<void> _checkDateAndMonth() async {
    final now = DateTime.now();
    final UsersRecord myRecord = currentUserDocument!;

    final String thisMonth = dateTimeFormat(
      'M/y',
      dateTimeFromSecondsSinceEpoch(now.secondsSinceEpoch),
    );

    // 월이 변경되었을 경우 초기화
    if (thisMonth != myRecord.thisMonth) {
      await myRecord.reference.update({
        Field.thisMonth: thisMonth,
        Field.thisMonthSteps: 0,
      });
    }

    final String today = dateTimeFormat(
      'd/M/y',
      dateTimeFromSecondsSinceEpoch(now.secondsSinceEpoch),
    );

    // 날짜가 변경되었을 경우 초기화
    if (today != myRecord.today) {
      await myRecord.reference.update({Field.today: today, Field.steps: 0});
    }
  }

  Future<void> _addAction() async {
    // 스캔된 비콘이 있으면 조건 확인후 DB에 저장 한 후 리스트에서 제거
    for (final beacon in _scannedBeacons) {
      // 이전에 검색되었던 비콘인지 확인
      final index = _beacons.indexWhere((b) => b.remoteId == beacon.remoteId);

      if (index == -1) {
        // 처음 스캔된 비콘
        _beacons.add(beacon);
      } else {
        // 이전에 스캔된 비콘
        final previousTagTime = _beacons[index].tagTime;
        final currentTagTime = beacon.tagTime;

        // 3분 이내인 경우 제외
        if (currentTagTime.difference(previousTagTime).inMinutes < 3) {
          continue;
        }

        // 제자리에 있는 경우 제외 (마지막 비콘과 같은 비콘이라면 제자리에 있는 것으로 판단)
        final Beacon latestBeacon = _beacons.reduce(
          (current, next) =>
              current.tagTime.isAfter(next.tagTime) ? current : next,
        );

        if (latestBeacon.remoteId == beacon.remoteId) {
          continue;
        }

        // 조건에 맞는 경우 리스트 업데이트 후 저장
        _beacons[index] = beacon;
      }

      final Action action = Action(
        uid: _auth.currentUser!.uid,
        bid: beacon.id,
        tagTime: beacon.tagTime,
      );

      // DB에 저장
      await _databaseService.addAction(action);

      // 유저 데이터 업데이트
      await _updateUser(beacon);
    }

    _scannedBeacons.clear();
  }

  Future<void> _updateUser(Beacon beacon) async {
    // 스텝수 증가 (오늘과 이달 동시에 증가)
    // log_bottle 추가, reward_won 증가
    final UsersRecord myRecord = currentUserDocument!;

    final Bottle bottle = Bottle(
      content: '계단업 ${beacon.type.name}',
      date: getCurrentTimestamp.secondsSinceEpoch,
      updateBottle: '+2g CO2-Eq',
    );

    await myRecord.reference.update({
      Field.steps: FieldValue.increment(1),
      Field.thisMonthSteps: FieldValue.increment(1),
      Field.logBottle: FieldValue.arrayUnion([bottle.toJson()]),
      Field.rewardWon: FieldValue.increment(2),
    });
  }

  // 비콘 정보 저장 관련
  final String _storageKey = 'storage';

  void _loadBeaconsFromPhone() {
    final String? storageString = prefs.getString(_storageKey);

    if (storageString != null) {
      final Storage storage = Storage.fromJson(jsonDecode(storageString));
      _beacons.addAll(storage.beacons);
    }
  }

  Future<void> _saveBeaconsToPhone() async {
    final Storage storage = Storage(beacons: _beacons);
    await prefs.setString(_storageKey, jsonEncode(storage.toJson()));
  }
}
