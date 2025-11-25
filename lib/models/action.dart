import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snueco/models/converters/tmestamp_converter.dart';

part 'action.freezed.dart';
part 'action.g.dart';

@freezed
abstract class Action with _$Action {
  // ignore: invalid_annotation_target
  @JsonSerializable(
    fieldRename: FieldRename.snake, // <---
  )
  factory Action({
    String? id,
    required String uid,
    required String bid,
    @TimestampConverter() required DateTime tagTime,
  }) = _Action;

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  factory Action.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Action.fromJson(doc.data()!).copyWith(id: doc.id);
}
