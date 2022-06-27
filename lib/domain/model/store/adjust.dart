import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'adjust.freezed.dart';

part 'adjust.g.dart';

@freezed
class Adjust with _$Adjust {
  factory Adjust({
    @Default("") String bank,
    @Default("") String account,
  }) = _Adjust;

  factory Adjust.fromJson(Map<String, dynamic> json) => _$AdjustFromJson(json);
}
