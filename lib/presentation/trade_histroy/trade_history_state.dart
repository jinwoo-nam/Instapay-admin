import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'trade_history_state.freezed.dart';
part 'trade_history_state.g.dart';

@freezed
class TradeHistoryState with _$TradeHistoryState {
  factory TradeHistoryState({
    DateTime? tradeStartDay,
    DateTime? tradeEndDay,
    @Default(false) bool isLoadingTradeHistorySearch,
    @Default([]) List<PaymentCompleteInfo> paymentHistoryList,
    @Default(false) bool isTradeCalendarSelected,

  }) = _TradeHistoryState;
  factory TradeHistoryState.fromJson(Map<String, dynamic> json) => _$TradeHistoryStateFromJson(json);
}