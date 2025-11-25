import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snueco/auth/firebase_auth/auth_util.dart';
import 'package:snueco/backend/backend.dart';
import 'package:snueco/flutter_flow/flutter_flow_util.dart';
import 'package:snueco/models/beacon.dart';
import 'package:snueco/models/action.dart';
import 'package:snueco/models/bottle.dart';
import 'package:snueco/models/storage.dart';
import 'package:snueco/services/database_service.dart';
import 'package:snueco/utils/field.dart';
import 'package:snueco/utils/keys.dart';

class BeaconRecorder {
  final SharedPreferences prefs;
  final _auth = FirebaseAuth.instance;
  final _databaseService = DatabaseService();

  final List<Beacon> _beacons = [];

  final _storageKey = Keys.storage;
  final _backgroundStorageKey = Keys.backgroundStorage;

  Beacon? _lastRecordedBeacon;

  BeaconRecorder({required this.prefs}) {
    _loadBeaconsFromPhone();
  }

  // ===============================
  // 포그라운드 기록
  // ===============================
  Future<void> record(Beacon beacon) async {
    if (_shouldIgnoreBeacon(beacon)) return;

    final index = _beacons.indexWhere((b) => b.remoteId == beacon.remoteId);
    if (index == -1) {
      _beacons.add(beacon);
    } else {
      _beacons[index] = beacon;
    }

    _lastRecordedBeacon = beacon;

    final action = Action(
      uid: _auth.currentUser!.uid,
      bid: beacon.id,
      tagTime: beacon.tagTime,
    );

    await _databaseService.addAction(action);
    await _updateUser(beacon);
    await _saveBeaconsToPhone();
  }

  // ===============================
  // 백그라운드 기록
  // ===============================
  Future<void> recordBackground(Beacon beacon) async {
    final backgroundBeacons = await _loadBackgroundBeacons();

    if (_shouldIgnoreBeacon(beacon, backgroundBeacons: backgroundBeacons)) {
      return;
    }

    final index =
        backgroundBeacons.indexWhere((b) => b.remoteId == beacon.remoteId);
    if (index == -1) {
      backgroundBeacons.add(beacon);
    } else {
      backgroundBeacons[index] = beacon;
    }

    await _saveBackgroundBeacons(backgroundBeacons);
  }

  // ===============================
  // 백그라운드 → 파이어스토어 플러시
  // ===============================
  Future<void> flushBackgroundBeacons() async {
    final backgroundBeacons = await _loadBackgroundBeacons();
    if (backgroundBeacons.isEmpty) return;

    try {
      final batchLogBottle = <Map<String, dynamic>>[];

      final stepsIncrement = backgroundBeacons.length;
      final rewardIncrement = stepsIncrement * 2;

      for (final beacon in backgroundBeacons) {
        final action = Action(
          uid: _auth.currentUser!.uid,
          bid: beacon.id,
          tagTime: beacon.tagTime,
        );

        await _databaseService.addAction(action);

        final bottle = Bottle(
          content: '계단업 ${beacon.type.name}',
          date: getCurrentTimestamp.secondsSinceEpoch,
          updateBottle: '+2g CO2-Eq',
        );

        batchLogBottle.add(bottle.toJson());
      }

      await _bulkUpdateUser(
        steps: stepsIncrement,
        reward: rewardIncrement,
        bottles: batchLogBottle,
      );

      await prefs.remove(_backgroundStorageKey);
      _lastRecordedBeacon = backgroundBeacons.last;

      print('✅ 백그라운드 비콘 처리 완료 (최적화됨)');
    } catch (e) {
      print('❌ 백그라운드 비콘 처리 중 에러: $e');
    }
  }

  // ===============================
  // 내부 유틸 함수
  // ===============================

  /// 저장을 무시해야 하는 경우 판단
  bool _shouldIgnoreBeacon(Beacon beacon, {List<Beacon>? backgroundBeacons}) {
    if (_lastRecordedBeacon != null) {
      if (_lastRecordedBeacon!.remoteId == beacon.remoteId &&
          beacon.tagTime.difference(_lastRecordedBeacon!.tagTime).inMinutes <
              3) {
        return true;
      }
    }

    final listToCheck = backgroundBeacons ?? _beacons;

    final index = listToCheck.indexWhere((b) => b.remoteId == beacon.remoteId);
    if (index != -1) {
      final previous = listToCheck[index];
      if (beacon.tagTime.difference(previous.tagTime).inMinutes < 3) {
        return true;
      }
    }

    return false;
  }

  /// 백그라운드 기록 로드
  Future<List<Beacon>> _loadBackgroundBeacons() async {
    final storageString = prefs.getString(_backgroundStorageKey);
    if (storageString == null) return [];

    final decoded = jsonDecode(storageString);
    final storage = Storage.fromJson(decoded);

    return storage.beacons;
  }

  /// 백그라운드 기록 저장
  Future<void> _saveBackgroundBeacons(List<Beacon> beacons) async {
    final storage = Storage(beacons: beacons);
    await prefs.setString(_backgroundStorageKey, jsonEncode(storage.toJson()));
  }

  /// 포그라운드 기록 로드
  void _loadBeaconsFromPhone() {
    final json = prefs.getString(_storageKey);
    if (json == null) return;

    final storage = Storage.fromJson(jsonDecode(json));
    _beacons.addAll(storage.beacons);
  }

  /// 포그라운드 기록 저장
  Future<void> _saveBeaconsToPhone() async {
    final storage = Storage(beacons: _beacons);
    await prefs.setString(_storageKey, jsonEncode(storage.toJson()));
  }

  /// 사용자 상태 개별 업데이트
  Future<void> _updateUser(Beacon beacon) async {
    final user = currentUserDocument!;
    final bottle = Bottle(
      content: '계단업 ${beacon.type.name}',
      date: getCurrentTimestamp.secondsSinceEpoch,
      updateBottle: '+2g CO2-Eq',
    );

    await user.reference.update({
      Field.steps: FieldValue.increment(1),
      Field.thisMonthSteps: FieldValue.increment(1),
      Field.logBottle: FieldValue.arrayUnion([bottle.toJson()]),
      Field.rewardWon: FieldValue.increment(2),
    });
  }

  /// 사용자 상태 일괄 업데이트
  Future<void> _bulkUpdateUser({
    required int steps,
    required int reward,
    required List<Map<String, dynamic>> bottles,
  }) async {
    final user = currentUserDocument!;

    await user.reference.update({
      Field.steps: FieldValue.increment(steps),
      Field.thisMonthSteps: FieldValue.increment(steps),
      Field.logBottle: FieldValue.arrayUnion(bottles),
      Field.rewardWon: FieldValue.increment(reward),
    });

    print('✅ 사용자 정보 일괄 업데이트 완료');
  }
}
