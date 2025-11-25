import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snueco/enums/beacon_type.dart';

part 'beacon.freezed.dart';
part 'beacon.g.dart';

@freezed
abstract class Beacon with _$Beacon {
  // ignore: invalid_annotation_target
  @JsonSerializable(
    fieldRename: FieldRename.snake, // <---
  )
  factory Beacon({
    required String id,
    required String remoteId,
    required BeaconType type,
    required DateTime tagTime,
  }) = _Beacon;

  factory Beacon.fromJson(Map<String, dynamic> json) => _$BeaconFromJson(json);
}
