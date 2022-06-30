import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pay_state_info.freezed.dart';

part 'pay_state_info.g.dart';

@freezed
class PayStateInfo with _$PayStateInfo {
  factory PayStateInfo({
    @Default(0) int count,
    @Default(0) int paymentAmount,
  }) = _PayStateInfo;

  factory PayStateInfo.fromJson(Map<String, dynamic> json) =>
      _$PayStateInfoFromJson(json);
}
