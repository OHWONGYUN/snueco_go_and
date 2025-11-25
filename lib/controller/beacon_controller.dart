import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snueco/auth/firebase_auth/auth_util.dart';
import 'package:snueco/backend/schema/users_record.dart';
import 'package:snueco/flutter_flow/flutter_flow_util.dart';
import 'package:snueco/services/i_beacon_service.dart';
import 'package:snueco/utils/field.dart';

class BeaconController with WidgetsBindingObserver {
  final IBeaconService iBeaconService;

  BeaconController({required this.iBeaconService});

  Timer? _dateCheckTimer;
  DateTime _lastCheckedDate = DateTime.now();

  Future<void> start() async {
    WidgetsBinding.instance.addObserver(this);
    await tryStartRanging(); // ✅ 로그인 + 권한 조건에 맞을 때만 시작

    authenticatedUserStream
        .firstWhere((user) => user != null)
        .then((user) async {
      // 앱 시작 시 날짜 체크
      await _checkDateAndMonth();
    });

    startDateChecker(); // ✅ 추가
  }

  void stop() {
    iBeaconService.dispose(); // 스캔 중단만
  }

  void dispose() {
    iBeaconService.dispose();
    stopDateChecker(); // ✅ 추가
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      stop(); // 스캔만 중단
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        iBeaconService.stopMonitoring();
        await tryStartRanging(); // ✅ 권한 체크 후 포그라운드 시작
        break;
      case AppLifecycleState.paused:
        iBeaconService.stopRanging();
        await tryStartMonitoring(); // ✅ 권한 체크 후 백그라운드 시작
        break;
      default:
        break;
    }
  }

  Future<void> tryStartRanging() async {
    final locationStatus = await Permission.location.status;

    if (!locationStatus.isGranted && !locationStatus.isLimited) {
      print('⚠️ 위치 권한 없음: 포그라운드 스캔 시작 안함');
      return;
    }

    try {
      await iBeaconService.flushBackgroundBeacons();
    } catch (e) {
      print('❗ 백그라운드 기록 플러시 실패: $e');
    }

    await iBeaconService.startRanging();
  }

  Future<void> tryStartMonitoring() async {
    final locationAlwaysStatus = await Permission.locationAlways.status;

    if (!locationAlwaysStatus.isGranted) {
      print('⚠️ 항상 위치 권한 없음: 백그라운드 모니터링 시작 안함');
      return;
    }

    iBeaconService.startMonitoring();
  }

  // 타이머
  void startDateChecker() {
    _dateCheckTimer?.cancel();
    _dateCheckTimer = Timer.periodic(Duration(minutes: 1), (_) {
      _checkDateAndMonthIfNeeded();
    });
  }

  void stopDateChecker() {
    _dateCheckTimer?.cancel();
    _dateCheckTimer = null;
  }

  Future<void> _checkDateAndMonthIfNeeded() async {
    final now = DateTime.now();

    if (_lastCheckedDate.year != now.year ||
        _lastCheckedDate.month != now.month ||
        _lastCheckedDate.day != now.day) {
      _lastCheckedDate = now;
      await _checkDateAndMonth(); // ✅
    }
  }

  Future<void> _checkDateAndMonth() async {
    final now = DateTime.now();
    final UsersRecord myRecord = currentUserDocument!;

    final String thisMonth = dateTimeFormat(
        'M/y', dateTimeFromSecondsSinceEpoch(now.secondsSinceEpoch));

    if (thisMonth != myRecord.thisMonth) {
      await myRecord.reference.update({
        Field.thisMonth: thisMonth,
        Field.thisMonthSteps: 0,
      });
    }

    final String today = dateTimeFormat(
        'd/M/y', dateTimeFromSecondsSinceEpoch(now.secondsSinceEpoch));

    if (today != myRecord.today) {
      await myRecord.reference.update({
        Field.today: today,
        Field.steps: 0,
      });
    }
  }
}
