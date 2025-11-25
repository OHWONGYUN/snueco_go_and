import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottle.freezed.dart';
part 'bottle.g.dart';

@freezed
abstract class Bottle with _$Bottle {
  // ignore: invalid_annotation_target
  @JsonSerializable(
    fieldRename: FieldRename.snake, // <---
  )
  factory Bottle({
    required String content,
    required String updateBottle,
    required int date,
  }) = _Bottle;

  factory Bottle.fromJson(Map<String, dynamic> json) => _$BottleFromJson(json);

  factory Bottle.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Bottle.fromJson(doc.data()!);
}
