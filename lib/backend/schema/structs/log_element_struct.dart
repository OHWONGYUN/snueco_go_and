// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogElementStruct extends FFFirebaseStruct {
  LogElementStruct({
    int? date,
    String? content,
    String? updateBottle,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _content = content,
        _updateBottle = updateBottle,
        super(firestoreUtilData);

  // "date" field.
  int? _date;
  int get date => _date ?? 0;
  set date(int? val) => _date = val;
  void incrementDate(int amount) => _date = date + amount;
  bool hasDate() => _date != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;
  bool hasContent() => _content != null;

  // "update_bottle" field.
  String? _updateBottle;
  String get updateBottle => _updateBottle ?? '';
  set updateBottle(String? val) => _updateBottle = val;
  bool hasUpdateBottle() => _updateBottle != null;

  static LogElementStruct fromMap(Map<String, dynamic> data) =>
      LogElementStruct(
        date: castToType<int>(data['date']),
        content: data['content'] as String?,
        updateBottle: data['update_bottle'] as String?,
      );

  static LogElementStruct? maybeFromMap(dynamic data) => data is Map
      ? LogElementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'content': _content,
        'update_bottle': _updateBottle,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.int,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'update_bottle': serializeParam(
          _updateBottle,
          ParamType.String,
        ),
      }.withoutNulls;

  static LogElementStruct fromSerializableMap(Map<String, dynamic> data) =>
      LogElementStruct(
        date: deserializeParam(
          data['date'],
          ParamType.int,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        updateBottle: deserializeParam(
          data['update_bottle'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LogElementStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LogElementStruct &&
        date == other.date &&
        content == other.content &&
        updateBottle == other.updateBottle;
  }

  @override
  int get hashCode => const ListEquality().hash([date, content, updateBottle]);
}

LogElementStruct createLogElementStruct({
  int? date,
  String? content,
  String? updateBottle,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LogElementStruct(
      date: date,
      content: content,
      updateBottle: updateBottle,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LogElementStruct? updateLogElementStruct(
  LogElementStruct? logElement, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    logElement
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLogElementStructData(
  Map<String, dynamic> firestoreData,
  LogElementStruct? logElement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (logElement == null) {
    return;
  }
  if (logElement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && logElement.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final logElementData = getLogElementFirestoreData(logElement, forFieldValue);
  final nestedData = logElementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = logElement.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLogElementFirestoreData(
  LogElementStruct? logElement, [
  bool forFieldValue = false,
]) {
  if (logElement == null) {
    return {};
  }
  final firestoreData = mapToFirestore(logElement.toMap());

  // Add any Firestore field values
  logElement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLogElementListFirestoreData(
  List<LogElementStruct>? logElements,
) =>
    logElements?.map((e) => getLogElementFirestoreData(e, true)).toList() ?? [];
