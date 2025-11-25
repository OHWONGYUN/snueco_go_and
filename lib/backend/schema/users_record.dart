import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "steps" field.
  int? _steps;
  int get steps => _steps ?? 0;
  bool hasSteps() => _steps != null;

  // "CO2_reduction" field.
  int? _cO2Reduction;
  int get cO2Reduction => _cO2Reduction ?? 0;
  bool hasCO2Reduction() => _cO2Reduction != null;

  // "reward_won" field.
  int? _rewardWon;
  int get rewardWon => _rewardWon ?? 0;
  bool hasRewardWon() => _rewardWon != null;

  // "roles" field.
  String? _roles;
  String get roles => _roles ?? '';
  bool hasRoles() => _roles != null;

  // "college" field.
  String? _college;
  String get college => _college ?? '';
  bool hasCollege() => _college != null;

  // "major" field.
  String? _major;
  String get major => _major ?? '';
  bool hasMajor() => _major != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  bool hasDistance() => _distance != null;

  // "ranking" field.
  List<String>? _ranking;
  List<String> get ranking => _ranking ?? const [];
  bool hasRanking() => _ranking != null;

  // "reward_change" field.
  int? _rewardChange;
  int get rewardChange => _rewardChange ?? 0;
  bool hasRewardChange() => _rewardChange != null;

  // "count_drink" field.
  int? _countDrink;
  int get countDrink => _countDrink ?? 0;
  bool hasCountDrink() => _countDrink != null;

  // "count_bottle" field.
  int? _countBottle;
  int get countBottle => _countBottle ?? 0;
  bool hasCountBottle() => _countBottle != null;

  // "log_bottle" field.
  List<LogElementStruct>? _logBottle;
  List<LogElementStruct> get logBottle => _logBottle ?? const [];
  bool hasLogBottle() => _logBottle != null;

  // "last_bottle_update" field.
  String? _lastBottleUpdate;
  String get lastBottleUpdate => _lastBottleUpdate ?? '';
  bool hasLastBottleUpdate() => _lastBottleUpdate != null;

  // "last_step_update" field.
  String? _lastStepUpdate;
  String get lastStepUpdate => _lastStepUpdate ?? '';
  bool hasLastStepUpdate() => _lastStepUpdate != null;

  // "month_steps" field.
  List<StepElementStruct>? _monthSteps;
  List<StepElementStruct> get monthSteps => _monthSteps ?? const [];
  bool hasMonthSteps() => _monthSteps != null;

  // "today" field.
  String? _today;
  String get today => _today ?? '';
  bool hasToday() => _today != null;

  // "this_month_steps" field.
  int? _thisMonthSteps;
  int get thisMonthSteps => _thisMonthSteps ?? 0;
  bool hasThisMonthSteps() => _thisMonthSteps != null;

  // "this_month" field.
  String? _thisMonth;
  String get thisMonth => _thisMonth ?? '';
  bool hasThisMonth() => _thisMonth != null;

  // "SB2_B1" field.
  int? _sb2B1;
  int get sb2B1 => _sb2B1 ?? 0;
  bool hasSb2B1() => _sb2B1 != null;

  // "SB1_1" field.
  int? _sb11;
  int get sb11 => _sb11 ?? 0;
  bool hasSb11() => _sb11 != null;

  // "S1_2" field.
  int? _s12;
  int get s12 => _s12 ?? 0;
  bool hasS12() => _s12 != null;

  // "S2_3" field.
  int? _s23;
  int get s23 => _s23 ?? 0;
  bool hasS23() => _s23 != null;

  // "S3_4" field.
  int? _s34;
  int get s34 => _s34 ?? 0;
  bool hasS34() => _s34 != null;

  // "S4_5" field.
  int? _s45;
  int get s45 => _s45 ?? 0;
  bool hasS45() => _s45 != null;

  // "MB2_B1" field.
  int? _mb2B1;
  int get mb2B1 => _mb2B1 ?? 0;
  bool hasMb2B1() => _mb2B1 != null;

  // "MB1_1" field.
  int? _mb11;
  int get mb11 => _mb11 ?? 0;
  bool hasMb11() => _mb11 != null;

  // "M1_2" field.
  int? _m12;
  int get m12 => _m12 ?? 0;
  bool hasM12() => _m12 != null;

  // "M2_3" field.
  int? _m23;
  int get m23 => _m23 ?? 0;
  bool hasM23() => _m23 != null;

  // "M3_4" field.
  int? _m34;
  int get m34 => _m34 ?? 0;
  bool hasM34() => _m34 != null;

  // "M4_5" field.
  int? _m45;
  int get m45 => _m45 ?? 0;
  bool hasM45() => _m45 != null;

  // "BeforeTime_SB2_B1" field.
  DateTime? _beforeTimeSB2B1;
  DateTime? get beforeTimeSB2B1 => _beforeTimeSB2B1;
  bool hasBeforeTimeSB2B1() => _beforeTimeSB2B1 != null;

  // "BeforeTime_SB1_1" field.
  DateTime? _beforeTimeSB11;
  DateTime? get beforeTimeSB11 => _beforeTimeSB11;
  bool hasBeforeTimeSB11() => _beforeTimeSB11 != null;

  // "BeforeTime_S1_2" field.
  DateTime? _beforeTimeS12;
  DateTime? get beforeTimeS12 => _beforeTimeS12;
  bool hasBeforeTimeS12() => _beforeTimeS12 != null;

  // "BeforeTime_S2_3" field.
  DateTime? _beforeTimeS23;
  DateTime? get beforeTimeS23 => _beforeTimeS23;
  bool hasBeforeTimeS23() => _beforeTimeS23 != null;

  // "BeforeTime_S3_4" field.
  DateTime? _beforeTimeS34;
  DateTime? get beforeTimeS34 => _beforeTimeS34;
  bool hasBeforeTimeS34() => _beforeTimeS34 != null;

  // "BeforeTime_S4_5" field.
  DateTime? _beforeTimeS45;
  DateTime? get beforeTimeS45 => _beforeTimeS45;
  bool hasBeforeTimeS45() => _beforeTimeS45 != null;

  // "BeforeTime_MB2_B1" field.
  DateTime? _beforeTimeMB2B1;
  DateTime? get beforeTimeMB2B1 => _beforeTimeMB2B1;
  bool hasBeforeTimeMB2B1() => _beforeTimeMB2B1 != null;

  // "BeforeTime_MB1_1" field.
  DateTime? _beforeTimeMB11;
  DateTime? get beforeTimeMB11 => _beforeTimeMB11;
  bool hasBeforeTimeMB11() => _beforeTimeMB11 != null;

  // "BeforeTime_M1_2" field.
  DateTime? _beforeTimeM12;
  DateTime? get beforeTimeM12 => _beforeTimeM12;
  bool hasBeforeTimeM12() => _beforeTimeM12 != null;

  // "BeforeTime_M2_3" field.
  DateTime? _beforeTimeM23;
  DateTime? get beforeTimeM23 => _beforeTimeM23;
  bool hasBeforeTimeM23() => _beforeTimeM23 != null;

  // "BeforeTime_M3_4" field.
  DateTime? _beforeTimeM34;
  DateTime? get beforeTimeM34 => _beforeTimeM34;
  bool hasBeforeTimeM34() => _beforeTimeM34 != null;

  // "BeforeTime_M4_5" field.
  DateTime? _beforeTimeM45;
  DateTime? get beforeTimeM45 => _beforeTimeM45;
  bool hasBeforeTimeM45() => _beforeTimeM45 != null;

  // "List_BeforeTime_SB2_B1" field./////////////************************** */
  List<DateTime>? _listBeforeTimeSB2B1;
  List<DateTime> get listBeforeTimeSB2B1 => _listBeforeTimeSB2B1 ?? const [];
  bool hasListBeforeTimeSB2B1() => _listBeforeTimeSB2B1 != null;

  // "List_BeforeTime_SB1_1" field./////////////************************** */
  List<DateTime>? _listBeforeTimeSB11;
  List<DateTime> get listBeforeTimeSB11 => _listBeforeTimeSB11 ?? const [];
  bool hasListBeforeTimeSB11() => _listBeforeTimeSB11 != null;

  // "List_BeforeTime_S1_2" field./////////////************************** */
  List<DateTime>? _listBeforeTimeS12;
  List<DateTime> get listBeforeTimeS12 => _listBeforeTimeS12 ?? const [];
  bool hasListBeforeTimeS12() => _listBeforeTimeS12 != null;

  // "List_BeforeTime_S2_3" field./////////////************************** */
  List<DateTime>? _listBeforeTimeS23;
  List<DateTime> get listBeforeTimeS23 => _listBeforeTimeS23 ?? const [];
  bool hasListBeforeTimeS23() => _listBeforeTimeS23 != null;

  // "List_BeforeTime_S3_4" field./////////////************************** */
  List<DateTime>? _listBeforeTimeS34;
  List<DateTime> get listBeforeTimeS34 => _listBeforeTimeS34 ?? const [];
  bool hasListBeforeTimeS34() => _listBeforeTimeS34 != null;

  // "List_BeforeTime_S4_5" field./////////////************************** */
  List<DateTime>? _listBeforeTimeS45;
  List<DateTime> get listBeforeTimeS45 => _listBeforeTimeS45 ?? const [];
  bool hasListBeforeTimeS45() => _listBeforeTimeS45 != null;

  // "List_BeforeTime_MB2_B1" field./////////////************************** */
  List<DateTime>? _listBeforeTimeMB2B1;
  List<DateTime> get listBeforeTimeMB2B1 => _listBeforeTimeMB2B1 ?? const [];
  bool hasListBeforeTimeMB2B1() => _listBeforeTimeMB2B1 != null;

  // "List_BeforeTime_MB1_1" field./////////////************************** */
  List<DateTime>? _listBeforeTimeMB11;
  List<DateTime> get listBeforeTimeMB11 => _listBeforeTimeMB11 ?? const [];
  bool hasListBeforeTimeMB11() => _listBeforeTimeMB11 != null;

  // "List_BeforeTime_M1_2" field./////////////************************** */
  List<DateTime>? _listBeforeTimeM12;
  List<DateTime> get listBeforeTimeM12 => _listBeforeTimeM12 ?? const [];
  bool hasListBeforeTimeM12() => _listBeforeTimeM12 != null;

  // "List_BeforeTime_M2_3" field./////////////************************** */
  List<DateTime>? _listBeforeTimeM23;
  List<DateTime> get listBeforeTimeM23 => _listBeforeTimeM23 ?? const [];
  bool hasListBeforeTimeM23() => _listBeforeTimeM23 != null;

  // "List_BeforeTime_M3_4" field./////////////************************** */
  List<DateTime>? _listBeforeTimeM34;
  List<DateTime> get listBeforeTimeM34 => _listBeforeTimeM34 ?? const [];
  bool hasListBeforeTimeM34() => _listBeforeTimeM34 != null;

  // "List_BeforeTime_M4_5" field./////////////************************** */
  List<DateTime>? _listBeforeTimeM45;
  List<DateTime> get listBeforeTimeM45 => _listBeforeTimeM45 ?? const [];
  bool hasListBeforeTimeM45() => _listBeforeTimeM45 != null;

  // "tbl_tag" field.
  List<LogElementStruct>? _tblTag;
  List<LogElementStruct> get tblTag => _tblTag ?? const [];
  bool hasTblTag() => _tblTag != null;

  // "curr_tag_time" field.
  DateTime? _currtagtime;
  DateTime? get currtagtime => _currtagtime;
  bool hascurrtagtime() => _currtagtime != null;

  // "recent_tag_time" field.
  DateTime? _recenttagtime;
  DateTime? get recenttagtime => _recenttagtime;
  bool hasrecenttagtime() => _recenttagtime != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _steps = castToType<int>(snapshotData['steps']);
    _cO2Reduction = castToType<int>(snapshotData['CO2_reduction']);
    _rewardWon = castToType<int>(snapshotData['reward_won']);
    _roles = snapshotData['roles'] as String?;
    _college = snapshotData['college'] as String?;
    _major = snapshotData['major'] as String?;
    _distance = castToType<double>(snapshotData['distance']);
    _ranking = getDataList(snapshotData['ranking']);
    _rewardChange = castToType<int>(snapshotData['reward_change']);
    _countDrink = castToType<int>(snapshotData['count_drink']);
    _countBottle = castToType<int>(snapshotData['count_bottle']);
    _logBottle = getStructList(
      snapshotData['log_bottle'],
      LogElementStruct.fromMap,
    );
    _lastBottleUpdate = snapshotData['last_bottle_update'] as String?;
    _lastStepUpdate = snapshotData['last_step_update'] as String?;
    _monthSteps = getStructList(
      snapshotData['month_steps'],
      StepElementStruct.fromMap,
    );
    _today = snapshotData['today'] as String?;
    _thisMonthSteps = castToType<int>(snapshotData['this_month_steps']);
    _thisMonth = snapshotData['this_month'] as String?;
    _sb2B1 = castToType<int>(snapshotData['SB2_B1']);
    _sb11 = castToType<int>(snapshotData['SB1_1']);
    _s12 = castToType<int>(snapshotData['S1_2']);
    _s23 = castToType<int>(snapshotData['S2_3']);
    _s34 = castToType<int>(snapshotData['S3_4']);
    _s45 = castToType<int>(snapshotData['S4_5']);
    _mb2B1 = castToType<int>(snapshotData['MB2_B1']);
    _mb11 = castToType<int>(snapshotData['MB1_1']);
    _m12 = castToType<int>(snapshotData['M1_2']);
    _m23 = castToType<int>(snapshotData['M2_3']);
    _m34 = castToType<int>(snapshotData['M3_4']);
    _m45 = castToType<int>(snapshotData['M4_5']);
    _beforeTimeSB2B1 = snapshotData['BeforeTime_SB2_B1'] as DateTime?;
    _beforeTimeSB11 = snapshotData['BeforeTime_SB1_1'] as DateTime?;
    _beforeTimeS12 = snapshotData['BeforeTime_S1_2'] as DateTime?;
    _beforeTimeS23 = snapshotData['BeforeTime_S2_3'] as DateTime?;
    _beforeTimeS34 = snapshotData['BeforeTime_S3_4'] as DateTime?;
    _beforeTimeS45 = snapshotData['BeforeTime_S4_5'] as DateTime?;
    _beforeTimeMB2B1 = snapshotData['BeforeTime_MB2_B1'] as DateTime?;
    _beforeTimeMB11 = snapshotData['BeforeTime_MB1_1'] as DateTime?;
    _beforeTimeM12 = snapshotData['BeforeTime_M1_2'] as DateTime?;
    _beforeTimeM23 = snapshotData['BeforeTime_M2_3'] as DateTime?;
    _beforeTimeM34 = snapshotData['BeforeTime_M3_4'] as DateTime?;
    _beforeTimeM45 = snapshotData['BeforeTime_M4_5'] as DateTime?;

    _tblTag = getStructList(
      snapshotData['tbl_tag'],
      LogElementStruct.fromMap,
    );
    _currtagtime = snapshotData['curr_tag_time'] as DateTime?;
    _recenttagtime = snapshotData['recent_tag_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? steps,
  int? cO2Reduction,
  int? rewardWon,
  String? roles,
  String? college,
  String? major,
  double? distance,
  int? rewardChange,
  int? countDrink,
  int? countBottle,
  String? lastBottleUpdate,
  String? lastStepUpdate,
  String? today,
  int? thisMonthSteps,
  String? thisMonth,
  int? sb2B1,
  int? sb11,
  int? s12,
  int? s23,
  int? s34,
  int? s45,
  int? mb2B1,
  int? mb11,
  int? m12,
  int? m23,
  int? m34,
  int? m45,
  DateTime? beforeTimeSB2B1,
  DateTime? beforeTimeSB11,
  DateTime? beforeTimeS12,
  DateTime? beforeTimeS23,
  DateTime? beforeTimeS34,
  DateTime? beforeTimeS45,
  DateTime? beforeTimeMB2B1,
  DateTime? beforeTimeMB11,
  DateTime? beforeTimeM12,
  DateTime? beforeTimeM23,
  DateTime? beforeTimeM34,
  DateTime? beforeTimeM45,
  DateTime? currtagtime,
  DateTime? recenttagtime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'steps': steps,
      'CO2_reduction': cO2Reduction,
      'reward_won': rewardWon,
      'roles': roles,
      'college': college,
      'major': major,
      'distance': distance,
      'reward_change': rewardChange,
      'count_drink': countDrink,
      'count_bottle': countBottle,
      'last_bottle_update': lastBottleUpdate,
      'last_step_update': lastStepUpdate,
      'today': today,
      'this_month_steps': thisMonthSteps,
      'this_month': thisMonth,
      'SB2_B1': sb2B1,
      'SB1_1': sb11,
      'S1_2': s12,
      'S2_3': s23,
      'S3_4': s34,
      'S4_5': s45,
      'MB2_B1': mb2B1,
      'MB1_1': mb11,
      'M1_2': m12,
      'M2_3': m23,
      'M3_4': m34,
      'M4_5': m45,
      'BeforeTime_SB2_B1': beforeTimeSB2B1,
      'BeforeTime_SB1_1': beforeTimeSB11,
      'BeforeTime_S1_2': beforeTimeS12,
      'BeforeTime_S2_3': beforeTimeS23,
      'BeforeTime_S3_4': beforeTimeS34,
      'BeforeTime_S4_5': beforeTimeS45,
      'BeforeTime_MB2_B1': beforeTimeMB2B1,
      'BeforeTime_MB1_1': beforeTimeMB11,
      'BeforeTime_M1_2': beforeTimeM12,
      'BeforeTime_M2_3': beforeTimeM23,
      'BeforeTime_M3_4': beforeTimeM34,
      'BeforeTime_M4_5': beforeTimeM45,
      'curr_tag_time': currtagtime,
      'recent_tag_time': recenttagtime,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.steps == e2?.steps &&
        e1?.cO2Reduction == e2?.cO2Reduction &&
        e1?.rewardWon == e2?.rewardWon &&
        e1?.roles == e2?.roles &&
        e1?.college == e2?.college &&
        e1?.major == e2?.major &&
        e1?.distance == e2?.distance &&
        listEquality.equals(e1?.ranking, e2?.ranking) &&
        e1?.rewardChange == e2?.rewardChange &&
        e1?.countDrink == e2?.countDrink &&
        e1?.countBottle == e2?.countBottle &&
        listEquality.equals(e1?.logBottle, e2?.logBottle) &&
        e1?.lastBottleUpdate == e2?.lastBottleUpdate &&
        e1?.lastStepUpdate == e2?.lastStepUpdate &&
        listEquality.equals(e1?.monthSteps, e2?.monthSteps) &&
        e1?.today == e2?.today &&
        e1?.thisMonthSteps == e2?.thisMonthSteps &&
        e1?.thisMonth == e2?.thisMonth &&
        e1?.sb2B1 == e2?.sb2B1 &&
        e1?.sb11 == e2?.sb11 &&
        e1?.s12 == e2?.s12 &&
        e1?.s23 == e2?.s23 &&
        e1?.s34 == e2?.s34 &&
        e1?.s45 == e2?.s45 &&
        e1?.mb2B1 == e2?.mb2B1 &&
        e1?.mb11 == e2?.mb11 &&
        e1?.m12 == e2?.m12 &&
        e1?.m23 == e2?.m23 &&
        e1?.m34 == e2?.m34 &&
        e1?.m45 == e2?.m45 &&
        e1?.beforeTimeSB2B1 == e2?.beforeTimeSB2B1 &&
        e1?.beforeTimeSB11 == e2?.beforeTimeSB11 &&
        e1?.beforeTimeS12 == e2?.beforeTimeS12 &&
        e1?.beforeTimeS23 == e2?.beforeTimeS23 &&
        e1?.beforeTimeS34 == e2?.beforeTimeS34 &&
        e1?.beforeTimeS45 == e2?.beforeTimeS45 &&
        e1?.beforeTimeMB2B1 == e2?.beforeTimeMB2B1 &&
        e1?.beforeTimeMB11 == e2?.beforeTimeMB11 &&
        e1?.beforeTimeM12 == e2?.beforeTimeM12 &&
        e1?.beforeTimeM23 == e2?.beforeTimeM23 &&
        e1?.beforeTimeM34 == e2?.beforeTimeM34 &&
        e1?.beforeTimeM45 == e2?.beforeTimeM45 &&
        e1?.currtagtime == e2?.currtagtime &&
        e1?.recenttagtime == e2?.recenttagtime;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.steps,
        e?.cO2Reduction,
        e?.rewardWon,
        e?.roles,
        e?.college,
        e?.major,
        e?.distance,
        e?.ranking,
        e?.rewardChange,
        e?.countDrink,
        e?.countBottle,
        e?.logBottle,
        e?.lastBottleUpdate,
        e?.lastStepUpdate,
        e?.monthSteps,
        e?.today,
        e?.thisMonthSteps,
        e?.thisMonth,
        e?.sb2B1,
        e?.sb11,
        e?.s12,
        e?.s23,
        e?.s34,
        e?.s45,
        e?.mb2B1,
        e?.mb11,
        e?.m12,
        e?.m23,
        e?.m34,
        e?.m45,
        e?.beforeTimeSB2B1,
        e?.beforeTimeSB11,
        e?.beforeTimeS12,
        e?.beforeTimeS23,
        e?.beforeTimeS34,
        e?.beforeTimeS45,
        e?.beforeTimeMB2B1,
        e?.beforeTimeMB11,
        e?.beforeTimeM12,
        e?.beforeTimeM23,
        e?.beforeTimeM34,
        e?.beforeTimeM45,
        e?.tblTag,
        e?.currtagtime,
        e?.recenttagtime
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
