import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';
import 'package:instapay_admin/domain/model/franchisee/store.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

enum SelectScreenType {
  tradeHistoryScreen,
  calculateHistoryScreen,
  franchiseeInfoScreen,
  qrCodeManageScreen,
}

enum CalendarType {
  trade_start,
  trade_end,
  calc,
  qrManage_start,
  qrManage_end,
  qrDetail,
  qrCreate,
}

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(SelectScreenType.tradeHistoryScreen)
        SelectScreenType selectScreenType,
    @Default(false) bool isTradeCalendarSelected,
    @Default(CalendarType.trade_start) CalendarType periodType,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
