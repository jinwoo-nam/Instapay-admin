import 'package:instapay_admin/domain/model/calc_history/calc_history_summary_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'calc_history_summary.freezed.dart';
part 'calc_history_summary.g.dart';

@freezed
class CalcHistorySummary with _$CalcHistorySummary {
  factory CalcHistorySummary({
    required CalcHistorySummaryInfo complete,
    required CalcHistorySummaryInfo cancel,
    required CalcHistorySummaryInfo hold,
    required CalcHistorySummaryInfo holdCancel,
    required CalcHistorySummaryInfo finalPrice,
  }) = _CalcHistorySummary;
  factory CalcHistorySummary.fromJson(Map<String, dynamic> json) => _$CalcHistorySummaryFromJson(json);
}