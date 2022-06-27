import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'staff.freezed.dart';
part 'staff.g.dart';

@freezed
class Staff with _$Staff {
  factory Staff({
    @Default("") String wid,
    @Default("") String hash,
  }) = _Staff;
  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}