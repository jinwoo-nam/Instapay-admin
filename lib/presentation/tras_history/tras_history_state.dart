import 'package:instapay_admin/domain/model/calc_history/tras_history.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'tras_history_state.freezed.dart';
part 'tras_history_state.g.dart';

@freezed
class TrasHistoryState with _$TrasHistoryState {
  factory TrasHistoryState({
    @Default([]) List<TrasInfo> totalTrasHistoryData,
    @Default(false) bool isCalcCalendarSelected,
    DateTime? calcDay,
    @Default(false) bool isLoadingCalcHistorySearch,
    TrasHistory? trasHistory,
    @Default(0) int trasHistoryTotalCount,
  }) = _TrasHistoryState;
  factory TrasHistoryState.fromJson(Map<String, dynamic> json) => _$TrasHistoryStateFromJson(json);
}