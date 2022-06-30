import 'package:instapay_admin/domain/model/tras/tras_history.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/tras/tras_info.dart';

part 'trade_history_state.freezed.dart';

part 'trade_history_state.g.dart';

@freezed
class TradeHistoryState with _$TradeHistoryState {
  factory TradeHistoryState({
    DateTime? tradeStartDay,
    DateTime? tradeEndDay,
    @Default(true) bool isStartDateCalendarSelected,
    @Default(false) bool isLoadingTradeHistorySearch,
    @Default(false) bool isTradeCalendarSelected,
    TrasHistory? trasHistory,
    @Default([]) List<TrasInfo> totalTrasHistoryData,
    @Default(0) int trasHistoryTotalCount,
  }) = _TradeHistoryState;

  factory TradeHistoryState.fromJson(Map<String, dynamic> json) =>
      _$TradeHistoryStateFromJson(json);
}
