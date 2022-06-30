import 'package:instapay_admin/domain/model/tras/tras_info.dart';
import 'package:instapay_admin/domain/model/tras/tras_summary.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tras_history.freezed.dart';

part 'tras_history.g.dart';

@freezed
class TrasHistory with _$TrasHistory {
  factory TrasHistory({
    TrasSummary? summary,
    @Default(0) int count,
    @Default(0) int amount,
    @Default([]) List<TrasInfo> tras,
    String? sid,
  }) = _TrasHistory;

  factory TrasHistory.fromJson(Map<String, dynamic> json) =>
      _$TrasHistoryFromJson(json);
}
