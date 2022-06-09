import 'package:freezed_annotation/freezed_annotation.dart';
part 'calc_history_summary_info.freezed.dart';
part 'calc_history_summary_info.g.dart';

@freezed
class CalcHistorySummaryInfo with _$CalcHistorySummaryInfo {
  factory CalcHistorySummaryInfo({
    @Default('') String state,
    @Default(0) int count,
    @Default(0) int price,
    @Default(0) int vat,
    @Default(0) int result
  }) = _CalcHistorySummaryInfo;
  factory CalcHistorySummaryInfo.fromJson(Map<String, dynamic> json) => _$CalcHistorySummaryInfoFromJson(json);
}