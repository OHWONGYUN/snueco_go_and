import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snueco/models/beacon.dart';

part 'storage.freezed.dart';
part 'storage.g.dart';

@freezed
abstract class Storage with _$Storage {
  factory Storage({
    required List<Beacon> beacons,
  }) = _Storage;

  factory Storage.fromJson(Map<String, dynamic> json) =>
      _$StorageFromJson(json);
}
