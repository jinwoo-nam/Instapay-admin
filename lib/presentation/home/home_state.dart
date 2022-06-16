import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';
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

enum PeriodGroupSelectType {
  trade,
  qrManage,
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
    @Default(false) bool isCalcCalendarSelected,
    @Default(false) bool isQrManageCalendarSelected,
    @Default(false) bool isQrDetailCalendarSelected,
    @Default(false) bool isQrCreateCalendarSelected,
    @Default(CalendarType.trade_start) CalendarType periodType,
    @Default([]) List<QrCodeInfo> qrInfoList,
    @Default([]) List<PaymentCompleteInfo> paymentHistoryList,
    @Default([]) List<CalcHistoryDetailInfo> calcDetailInfoList,
    @Default([]) List<Contact> managers,
    Store? storeData,
    CalcHistorySummary? calcHistorySummary,
    @Default(false) bool isLoadingCalcHistorySearch,
    @Default(false) bool isLoadingTradeHistorySearch,
    @Default(false) bool isLoadingQrManageSearch,
    DateTime? tradeStartDay,
    DateTime? tradeEndDay,
    DateTime? calcDay,
    DateTime? qrManageStartDay,
    DateTime? qrManageEndDay,
    DateTime? qrDetailEndDay,
    DateTime? qrCreateEndDay,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
