import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TblTagRecord extends FirestoreRecord {
  TblTagRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "bid" field.
  String? _bid;
  String get bid => _bid ?? '';
  bool hasBid() => _bid != null;

  // "tag_time" field.
  DateTime? _tagTime;
  DateTime? get tagTime => _tagTime;
  bool hasTagTime() => _tagTime != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _bid = snapshotData['bid'] as String?;
    _tagTime = snapshotData['tag_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tbl_tag');

  static Stream<TblTagRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TblTagRecord.fromSnapshot(s));

  static Future<TblTagRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TblTagRecord.fromSnapshot(s));

  static TblTagRecord fromSnapshot(DocumentSnapshot snapshot) => TblTagRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TblTagRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TblTagRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TblTagRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TblTagRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTblTagRecordData({
  String? uid,
  String? bid,
  DateTime? tagTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'bid': bid,
      'tag_time': tagTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class TblTagRecordDocumentEquality implements Equality<TblTagRecord> {
  const TblTagRecordDocumentEquality();

  @override
  bool equals(TblTagRecord? e1, TblTagRecord? e2) {
    //const listEquality = ListEquality();
    return e1?.uid == e2?.uid &&
        e1?.bid == e2?.bid &&
        e1?.tagTime == e2?.tagTime;
  }

  @override
  int hash(TblTagRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.bid,
        e?.tagTime,
      ]);

  @override
  bool isValidKey(Object? o) => o is TblTagRecord;
}
