import 'package:instapay_admin/domain/model/calc_history/pay_state_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tras_summary.freezed.dart';

part 'tras_summary.g.dart';

@freezed
class TrasSummary with _$TrasSummary {
  factory TrasSummary({
    PayStateInfo? complete,
    PayStateInfo? notpaid,
    PayStateInfo? canceled,
    PayStateInfo? total,
  }) = _TrasSummary;

  factory TrasSummary.fromJson(Map<String, dynamic> json) =>
      _$TrasSummaryFromJson(json);
}
