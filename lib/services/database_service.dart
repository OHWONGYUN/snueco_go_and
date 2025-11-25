import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snueco/models/action.dart';
import 'package:snueco/utils/field.dart';
import 'package:snueco/utils/tables.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  // add action
  Future<void> addAction(Action action) async {
    await _firestore.collection(Tables.actions).add(action.toJson());
  }

  // 마지막 액션 가져오기
  Future<Action?> getLastAction(String uid) async {
    final snapshot = await _firestore
        .collection(Tables.actions)
        .where(Field.uid, isEqualTo: uid)
        .orderBy(Field.tagTime, descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return Action.fromDoc(snapshot.docs.first);
  }

  // 오늘의 액션 가져오기
  Future<List<Action>> getTodayActions(String uid) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final startTimestamp = Timestamp.fromDate(start);
    final endTimestamp = Timestamp.fromDate(end);

    final snapshot = await _firestore
        .collection(Tables.actions)
        .where(Field.uid, isEqualTo: uid)
        .where(Field.tagTime, isGreaterThanOrEqualTo: startTimestamp)
        .where(Field.tagTime, isLessThanOrEqualTo: endTimestamp)
        .get();

    return snapshot.docs.map((doc) => Action.fromDoc(doc)).toList();
  }

  // 액션 삭제하기
  Future<void> deleteAction(String id) async {
    await _firestore.collection(Tables.actions).doc(id).delete();
  }
}
