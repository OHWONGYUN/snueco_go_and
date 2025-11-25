// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StepElementStruct extends FFFirebaseStruct {
  StepElementStruct({
    String? month,
    int? steps,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _month = month,
        _steps = steps,
        super(firestoreUtilData);

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;
  bool hasMonth() => _month != null;

  // "steps" field.
  int? _steps;
  int get steps => _steps ?? 0;
  set steps(int? val) => _steps = val;
  void incrementSteps(int amount) => _steps = steps + amount;
  bool hasSteps() => _steps != null;

  static StepElementStruct fromMap(Map<String, dynamic> data) =>
      StepElementStruct(
        month: data['month'] as String?,
        steps: castToType<int>(data['steps']),
      );

  static StepElementStruct? maybeFromMap(dynamic data) => data is Map
      ? StepElementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'steps': _steps,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
        'steps': serializeParam(
          _steps,
          ParamType.int,
        ),
      }.withoutNulls;

  static StepElementStruct fromSerializableMap(Map<String, dynamic> data) =>
      StepElementStruct(
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
        steps: deserializeParam(
          data['steps'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'StepElementStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StepElementStruct &&
        month == other.month &&
        steps == other.steps;
  }

  @override
  int get hashCode => const ListEquality().hash([month, steps]);
}

StepElementStruct createStepElementStruct({
  String? month,
  int? steps,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StepElementStruct(
      month: month,
      steps: steps,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StepElementStruct? updateStepElementStruct(
  StepElementStruct? stepElement, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    stepElement
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStepElementStructData(
  Map<String, dynamic> firestoreData,
  StepElementStruct? stepElement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (stepElement == null) {
    return;
  }
  if (stepElement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && stepElement.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final stepElementData =
      getStepElementFirestoreData(stepElement, forFieldValue);
  final nestedData =
      stepElementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = stepElement.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStepElementFirestoreData(
  StepElementStruct? stepElement, [
  bool forFieldValue = false,
]) {
  if (stepElement == null) {
    return {};
  }
  final firestoreData = mapToFirestore(stepElement.toMap());

  // Add any Firestore field values
  stepElement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStepElementListFirestoreData(
  List<StepElementStruct>? stepElements,
) =>
    stepElements?.map((e) => getStepElementFirestoreData(e, true)).toList() ??
    [];
