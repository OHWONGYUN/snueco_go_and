import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RewardRecord extends FirestoreRecord {
  RewardRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "drink" field.
  List<int>? _drink;
  List<int> get drink => _drink ?? const [];
  bool hasDrink() => _drink != null;

  void _initializeFields() {
    _drink = getDataList(snapshotData['drink']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reward');

  static Stream<RewardRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RewardRecord.fromSnapshot(s));

  static Future<RewardRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RewardRecord.fromSnapshot(s));

  static RewardRecord fromSnapshot(DocumentSnapshot snapshot) => RewardRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RewardRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RewardRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RewardRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RewardRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRewardRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class RewardRecordDocumentEquality implements Equality<RewardRecord> {
  const RewardRecordDocumentEquality();

  @override
  bool equals(RewardRecord? e1, RewardRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.drink, e2?.drink);
  }

  @override
  int hash(RewardRecord? e) => const ListEquality().hash([e?.drink]);

  @override
  bool isValidKey(Object? o) => o is RewardRecord;
}
